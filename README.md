# PickEat

> 날씨 · 위치 · 취향을 반영해 "오늘 뭐 먹지?"를 대신 골라주는 개인화 맛집 추천 웹 서비스

---

## 1. 주제 선정 이유

기존 맛집 서비스는 **인기순 · 거리순 · 별점순** 정렬이 중심입니다.
정렬 기준이 모두에게 동일하기 때문에, 정작 "지금 내 상황에서 뭘 먹을지"는 사용자가 다시 고민해야 합니다.

그래서 PickEat은 **검색 대신 추천**을 출발점으로 삼았습니다.

- **취향 기반** — 찜, 리뷰, 최근 본 맛집 데이터를 태그로 집계해 사용자별 선호 태그(`USER_TASTE_PROFILE`)를 생성
- **위치 기반** — 현재 위치 또는 검색 지역을 기준으로 주변 음식점을 추천
- **상황 기반** — 날씨와 활동 흐름을 반영해 "지금 먹기 좋은" 선택지를 제안

**기대 효과**

- 사용자: 메뉴 선정에 드는 고민 시간을 줄임
- 관리자: 회원 · 맛집 · 리뷰 · 문의 데이터를 한 화면에서 운영

---

## 2. 시스템 구조

```
[Client]                JSP / Browser
   │  HTTP Request
   ▼
[Controller]            Request Mapping, 파라미터 수신
   │
   ▼
[Service]               추천 · 인증 · 검증 비즈니스 로직
   │
   ▼
[Repository]            Spring JDBC, SQL 실행
   │
   ├──────────────▶ [MySQL]      회원 / 맛집 / 리뷰 / 찜 / 태그
   │
   └──────────────▶ [Kakao API]  Map · Local · Login
```

**설계 포인트**

- 요청 수신(Controller) / 로직 처리(Service) / 데이터 접근(Repository)을 분리해 유지보수성을 확보
- 외부 Kakao Local 데이터와 자체 DB 데이터를 Repository 계층에서 함께 다뤄, Service는 데이터 출처와 무관하게 동작
- Spring Security로 인증과 `ROLE_USER` / `ROLE_ADMIN` 권한 분기를 처리
- 화면은 페이지 이동 기반(서버 렌더링)으로 구성해 구현 범위를 안정적으로 유지

**주요 테이블**

| 테이블 | 역할 |
| --- | --- |
| `MEMBER` | 회원 정보, 권한, 로그인 계정 |
| `RESTAURANT` | 맛집 기본 정보, Kakao 장소 데이터 (`api_place_id` UNIQUE) |
| `REVIEW` | 별점, 후기, 상태 관리 |
| `BOOKMARK` | 사용자 찜 데이터 |
| `RECENTLY_RESTAURANT` | 최근 조회 맛집 기록 |
| `RESTAURANT_TAG` / `USER_TASTE_PROFILE` | 추천용 태그와 사용자 취향 점수 |

---

## 3. 배포 (AWS)

> 배포 담당: 문재웅

로컬 실행에서 끝내지 않고, **AWS EC2에 WAR를 올려 외부 접속까지 검증**했습니다.

### 배포 구성

```
[사용자 브라우저]
      │  HTTP
      ▼
[AWS EC2 · Ubuntu]
      │
      ├── Apache Tomcat        ── PickEat WAR 실행
      │
      └── MySQL                ── 서비스 데이터
      
[Kakao Developers]            ── 배포 도메인 등록 (Map / Login)
```

### 배포 절차

| 단계 | 작업 | 비고 |
| --- | --- | --- |
| 1 | EC2 인스턴스 생성 및 키 페어 발급 | Ubuntu, 보안 그룹에서 SSH·서비스 포트 개방 |
| 2 | 서버에 JDK, Tomcat, MySQL 설치 | 로컬과 동일한 Java 버전으로 맞춤 |
| 3 | 로컬에서 `mvn package`로 WAR 빌드 | 배포 산출물 생성 |
| 4 | `scp`로 WAR 전송 | 키 파일 기반 접속 |
| 5 | Tomcat `webapps`에 배포 후 재기동 | `bin/startup.sh` 실행 |
| 6 | 외부 접속 및 기능 검증 | 로그인, 지도, 추천 흐름 확인 |

```bash
# 1. WAR 빌드 (로컬)
mvn clean package

# 2. 서버로 전송
scp -i <key>.pem target/AppProject01.war ubuntu@<서버주소>:/home/ubuntu

# 3. 서버 접속
ssh -i <key>.pem ubuntu@<서버주소>

# 4. WAR 배치 후 톰캣 기동
sudo mv AppProject01.war /opt/apache-tomcat/webapps/
cd /opt/apache-tomcat/bin && sudo ./startup.sh
```

---

## 4. 트러블 슈팅

### 4-1. 인증 / 권한

<details>
<summary><b>Kakao Login 후 세션이 끊기고 권한이 인식되지 않음</b></summary>

- **증상** — 카카오 로그인은 성공하고 세션에 `loginMember`도 있는데, 권한이 필요한 페이지에서 다시 로그인 화면으로 이동
- **원인** — Spring `SecurityContext`가 세션에 저장되지 않아 인증 정보가 비어 있었음
- **해결** — 카카오 인증 토큰 수신 후 `UsernamePasswordAuthenticationToken`을 직접 생성하고, `HttpSessionSecurityContextRepository`로 `SecurityContext`를 세션에 저장
- **위치** — `KakaoController`, `KakaoService`, `security-context.xml`

</details>

<details>
<summary><b>POST 요청 시 403 Forbidden (CSRF 토큰 누락)</b></summary>

- **증상** — 찜하기, 리뷰 작성 등 POST 요청에서 403 발생
- **원인** — 폼에 CSRF 토큰이 포함되지 않음
- **해결** — 모든 POST form에 hidden input으로 `${_csrf.parameterName}` / `${_csrf.token}` 추가
- **위치** — `bookmark/list.jsp`, `detail.jsp`, review JSP

</details>

<details>
<summary><b>로그인 / 권한 URL 설정 오류</b></summary>

- **원인** — `intercept-url` 선언 순서와 `request-matcher` 설정이 맞지 않아 의도한 URL 규칙이 적용되지 않음
- **해결** — 정적 리소스는 `permitAll`, admin/user URL은 역할별로 분리하고 좁은 패턴을 먼저 선언
- **위치** — `security-context.xml`

</details>

### 4-2. Spring 설정

<details>
<summary><b>Controller Bean이 생성되지 않음 (컴포넌트 스캔 분리)</b></summary>

- **원인** — `root-context` / `servlet-context`를 분리한 뒤 스캔 대상이 겹치거나 누락되어 Controller Bean이 등록되지 않음
- **해결** — Controller는 `servlet-context`, Service/Repository는 `root-context`에서 스캔하도록 `include-filter` / `exclude-filter`로 명확히 분리
- **위치** — `servlet-context.xml`, `root-context.xml`

</details>

<details>
<summary><b>404 URL 매핑 오류</b></summary>

- **원인** — form action, Controller mapping, contextPath가 서로 어긋남
- **해결** — `${pageContext.request.contextPath}` 기준으로 URL을 통일하고, 공통 URI 변수를 `header.jsp`에서 `<c:set>`으로 관리
- **위치** — Controller 매핑, JSP form action, `header.jsp`

</details>

### 4-3. 데이터 / 추천 로직

<details>
<summary><b>BadSqlGrammarException</b></summary>

- **원인** — `r.kakao_category_name`처럼 실제 테이블에 없는 컬럼을 SQL에서 사용 (DB 컬럼명과 Repository SQL 컬럼명 불일치)
- **해결** — 실제 `RESTAURANT` 테이블 컬럼 기준으로 SELECT / JOIN 구문 수정, `schema.sql`과 대조
- **위치** — `RestaurantRepositoryImpl`, `schema.sql`

</details>

<details>
<summary><b>AI Pick 추천 결과가 0건</b></summary>

- **원인** — 로그인 사용자 기준이 아닌 전체 데이터를 조회했고, 사용자 태그(`tag_name`) 생성이 누락됨
- **해결** — 세션의 `loginMember.memberId`를 기준으로 찜 / 리뷰 / 최근 본 맛집만 조회하도록 수정
- **위치** — `AiPickController`, `AiPickServiceImpl`

</details>

<details>
<summary><b>AI Pick 추천이 1건만 출력</b></summary>

- **원인** — 태그 매핑 데이터 부족, 중복 제거 조건과 거리 · 평점 조건이 과도해 후보가 거의 남지 않음
- **해결** — `BOOKMARK` / `REVIEW` / `RECENTLY` 데이터를 사용자 기준으로 UNION해 후보군을 넓히고, 태그 매핑 데이터를 정리한 뒤 거리(`HAVING distance <= 10`) · 평점 조건을 재조정
- **위치** — `AiPickRepositoryImpl`, `RESTAURANT_TAG`, `USER_TASTE_PROFILE`

</details>

<details>
<summary><b>JSP EL 표현식 오류</b></summary>

- **원인** — 비교 연산자와 삼항 연산자 작성 순서가 잘못됨
- **해결** — `조건 ? 참값 : 거짓값` 형태로 EL 식을 정리
- **위치** — `ai-pick.jsp`

</details>

### 4-4. 외부 API / 배포

<details>
<summary><b>Kakao Map이 표시되지 않음</b></summary>

- **원인** — JavaScript 키에 등록된 도메인과 실제 배포 주소(포트 포함)가 달라 SDK 로드가 차단됨
- **해결** — Kakao Developers에 실제 배포 도메인과 포트를 등록
- **위치** — Kakao Developers 설정, map JSP

</details>

<details>
<summary><b>AWS / Tomcat 배포 오류</b></summary>

- **원인** — `scp` 계정명 오타, `startup.sh` 실행 경로 혼동, context path 불일치로 WAR 업로드 후 404 발생
- **해결** — `ubuntu` 계정으로 접속, WAR를 `webapps`에 배포한 뒤 `bin/`에서 `./startup.sh` 실행
- **위치** — `apache-tomcat/webapps`, `bin/startup.sh`

```bash
# WAR 전송
scp -i "spring-key.pem" AppProject01.war ubuntu@<서버주소>:/home/ubuntu
# 서버 접속
ssh -i "spring-key.pem" ubuntu@<서버주소>
# 톰캣 실행
sudo ./startup.sh
```

</details>

<details>
<summary><b>Git 충돌 / 브랜치 전환 실패</b></summary>

- **원인** — 커밋하지 않은 local changes, non-fast-forward 오류
- **해결** — `commit` 또는 `stash` 후 브랜치 전환, 충돌 파일 정리 후 push
- **위치** — `JW` / `update` 브랜치, `pom.xml`, Java·JSP 파일

</details>

---

## 5. 향후 개선 방향

- **추천 고도화** — 날씨, 시간대, 거리, 사용자 평가를 가중치로 반영하고 유사 취향 사용자 데이터 활용
- **데이터 품질** — Kakao 카테고리와 자체 태그 매핑 정확도 개선, 맛집 신뢰도 지표 설계
- **서비스 확장** — 반응형 UI 적용, AWS 배포 안정화, 도메인 및 HTTPS 적용
