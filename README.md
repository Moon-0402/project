## 1. 담당 범위

PickEat은 **로그인 사용자의 활동 데이터(찜 · 리뷰 · 최근 본 맛집)** 를 근거로 추천을 만드는 서비스입니다.
즉 "지금 요청한 사람이 누구인가"가 확정되지 않으면 서비스의 핵심 기능인 AI Pick 자체가 동작하지 않습니다.

| 구분 | 구현 내용 |
| --- | --- |
| 회원 | 회원가입, 아이디 중복 확인, 로그인 / 로그아웃 |
| 소셜 로그인 | Kakao OAuth 2.0 인증, 최초 로그인 시 자동 회원 등록 |
| 인가 | `ROLE_USER` / `ROLE_ADMIN` 분리, URL 기반 접근 제어 |
| 보안 | CSRF 토큰 적용, 로그아웃 시 세션 무효화, 비인가 접근 처리 |
| 마이페이지 | 내 정보 수정, 비밀번호 변경 |

---

## 2. 설계 원칙

### 원칙 1 — 인증 상태의 단일 기준은 `SecurityContext`

로그인 경로는 두 가지(폼 로그인 / 카카오 로그인)지만, **인증 이후의 상태는 한 곳에만 둔다**는 것을 전제로 잡았습니다.

- 인증 정보의 **원본**: `SecurityContext` (세션에 저장)
  → 권한 판단, URL 접근 제어, 컨트롤러의 인가 처리는 전부 여기서만 읽음
- 세션의 `loginMember`: **화면 표시용 보조 데이터**
  → 헤더의 닉네임 노출, JSP 분기 등 뷰 편의를 위한 값

두 저장소를 병행하되 **역할을 명확히 나눈 것**이 핵심입니다.
"세션에는 로그인 정보가 있는데 권한 체크는 실패한다"는 상황은 이 둘의 역할이 섞일 때 발생하기 때문에, 인증 여부의 판단 기준을 `SecurityContext` 하나로 고정했습니다.

### 원칙 2 — 소셜 로그인도 폼 로그인과 같은 형태로 수렴시킨다

카카오 로그인은 인증 주체가 외부(Kakao)이지만, 인증이 끝난 뒤에는 **폼 로그인과 완전히 동일한 상태**가 되도록 설계했습니다.

```
폼 로그인    ──┐
               ├──▶ Authentication 객체 ──▶ SecurityContext ──▶ 이후 로직은 동일
Kakao 로그인 ──┘
```

덕분에 서비스 · 컨트롤러 계층은 **사용자가 어떤 경로로 로그인했는지 몰라도 됩니다.**
AI Pick, 찜, 리뷰 기능은 로그인 방식과 무관하게 같은 코드로 동작합니다.

## 3. 인증 흐름

### 3-1. 폼 로그인

```
사용자 (login.jsp)
   │  login_id / password
   ▼
MemberController
   │
   ▼
MemberService          ── 계정 조회 및 비밀번호 검증
   │
   ▼
MemberRepository       ── MEMBER 테이블 조회
   │
   ▼
Authentication 생성 → SecurityContext 저장 (세션)
   │
   ▼
role 값에 따라 분기 → USER: 메인 / ADMIN: 관리자 대시보드
```

### 3-2. 카카오 로그인

```
사용자 → [카카오 인증 서버]  로그인 및 동의
   │
   │  인가 코드(code) 리다이렉트
   ▼
KakaoController
   │  ① code → Access Token 요청
   ▼
KakaoService
   │  ② Access Token으로 사용자 정보 조회
   ▼
   ③ 기존 회원인가?
        ├─ 예   → 해당 회원 정보 사용
        └─ 아니오 → MEMBER 테이블에 자동 등록 (ROLE_USER)
   │
   ▼
   ④ UsernamePasswordAuthenticationToken 생성
      + SimpleGrantedAuthority("ROLE_" + role)
   ▼
   ⑤ SecurityContext에 인증 객체 저장 → 세션에 반영
   ▼
   ⑥ 메인 페이지로 리다이렉트
```
## 4. 권한 설계

### 권한 모델

| 권한 | 대상 | 부여 시점 |
| --- | --- | --- |
| `ROLE_USER` | 일반 회원 | 회원가입 시 / 카카오 최초 로그인 시 자동 |
| `ROLE_ADMIN` | 운영자 | DB에서 직접 지정 |

`MEMBER.role` 컬럼(`ENUM('USER','ADMIN')`)을 기준으로, 인증 시점에 `ROLE_` 접두사를 붙여 권한 객체로 변환합니다.

### URL 접근 정책

| 경로 | 접근 권한 | 설명 |
| --- | --- | --- |
| `/css/**`, `/js/**`, `/images/**` | permitAll | 정적 리소스 |
| `/`, `/member/login`, `/member/join`, `/kakao/**` | permitAll | 로그인 전 진입 경로 |
| `/restaurants/**` | permitAll | 맛집 조회는 비회원도 가능 |
| `/aipick/**`, `/bookmark/**`, `/review/write`, `/mypage/**` | `ROLE_USER` 이상 | 개인 활동 데이터 기반 기능 |
| `/admin/**` | `ROLE_ADMIN` | 관리자 전용 |

**설계 시 주의한 점**

- `intercept-url`은 **위에서부터 순서대로 매칭**되므로, 좁은 패턴(`/admin/**`)을 넓은 패턴보다 먼저 선언
- 비회원도 서비스 가치를 먼저 체감할 수 있도록, **맛집 조회는 열고 개인화 기능만 잠그는** 방식으로 경계를 설정

---

## 5. 보안 설계

| 항목 | 처리 방식 | 목적 |
| --- | --- | --- |
| CSRF | 모든 POST form에 `_csrf` hidden input 적용 | 위조 요청 차단 |
| 세션 | 로그아웃 시 세션 무효화 및 인증 객체 제거 | 로그아웃 후 재사용 방지 |
| 인가 실패 | 권한 부족 시 접근 거부 처리 후 안내 페이지로 이동 | 관리자 URL 노출 방지 |
| 화면 분기 | 로그인 여부 · 권한에 따라 `header.jsp` 메뉴 분기 | 접근 불가 메뉴 미노출 |

---

## 6. 설정 파일 구조

Spring 컨테이너를 두 개로 나누고, 스캔 대상을 명확히 분리했습니다.

| 파일 | 등록 대상 | 역할 |
| --- | --- | --- |
| `servlet-context.xml` | Controller | 웹 계층 — 요청 매핑, 뷰 리졸버 |
| `root-context.xml` | Service, Repository, DataSource | 서비스 · 데이터 계층 |
| `security-context.xml` | 인증 · 인가 설정 | 필터 체인, URL 정책, 로그인/로그아웃 핸들러 |

- Controller와 Service/Repository의 스캔 범위가 겹치면 Bean이 중복 생성되거나 주입에 실패하므로, `include-filter` / `exclude-filter`로 **한쪽에만 등록되도록** 제한
- 보안 설정을 별도 파일로 분리해, 인가 정책 변경 시 웹 설정을 건드리지 않도록 구성

---

## 7. 클래스 구성

| 계층 | 클래스 / 파일 | 역할 |
| --- | --- | --- |
| Controller | `MemberController` | 회원가입, 로그인, 로그아웃, 마이페이지 요청 처리 |
| Controller | `KakaoController` | 인가 코드 수신, 인증 객체 생성 및 SecurityContext 저장 |
| Service | `MemberServiceImpl` | 계정 검증, 중복 확인, 회원 정보 수정 |
| Service | `KakaoServiceImpl` | Access Token 요청, 카카오 사용자 정보 조회, 자동 가입 |
| Repository | `MemberRepositoryImpl` | `MEMBER` 테이블 CRUD (Spring JDBC) |
| View | `login.jsp`, `join.jsp`, `mypage/*.jsp` | 인증 관련 화면 |
| Config | `security-context.xml` | 인증 · 인가 정책 |

---

## 8. 관련 테이블

```sql
MEMBER
  member_id   BIGINT       PK
  login_id    VARCHAR(50)  UNIQUE   -- 카카오 회원은 카카오 식별자 기반으로 생성
  password    VARCHAR(255)
  name        VARCHAR(50)
  email       VARCHAR(100) UNIQUE
  phone       VARCHAR(20)
  role        ENUM('USER','ADMIN')  -- 인가의 기준값
  created_at  DATETIME
```

`role` 하나로 인가 정책 전체가 결정되도록 설계해, 권한 추가가 필요해지면 ENUM 값과 `intercept-url` 한 줄만 늘리면 되도록 했습니다.
