# PickEat - JW 브랜치 설명

## 브랜치 역할

`JW` 브랜치는 PickEat 프로젝트에서 가장 많이 개선된 최종 작업 브랜치에 가깝습니다.  
`main`보다 36커밋 앞서 있고, `update`보다도 5커밋 더 앞서 있습니다.

따라서 포트폴리오나 면접 설명에서는 `JW` 브랜치를 기준으로 프로젝트를 설명하는 것이 가장 적합합니다.

## 브랜치 상태

- Repository: `Moon-0402/project`
- Branch: `JW`
- `main` 대비: 36커밋 앞섬
- `update` 대비: 5커밋 앞섬
- 최종 설명 추천 브랜치: 예

## main 대비 핵심 변화

`JW` 브랜치에는 다음 기능과 개선 사항이 포함되어 있습니다.

- AI-Pick 추천 기능 추가 및 개선
- 리뷰 작성, 수정, 목록, 내 리뷰 기능 추가
- 관리자 리뷰 목록 및 상세 관리 기능 추가
- Kakao 로그인 처리 개선
- Kakao Local API 검색 및 장소 저장 로직 개선
- 맛집 검색, 상세, 리스트 처리 개선
- 관리자 화면 UI 개선
- 공통 Header / Footer 개선
- 다크 모드 및 모바일 CSS 개선
- Spring Security 설정 개선
- Controller, Service, Repository 계층 확장
- 사용자/관리자 화면 전반 JSP 개선

## update 대비 추가 변화

`JW`는 `update`보다 5커밋 더 앞서며, 특히 다음 영역에서 추가 개선이 있습니다.

### 1. Kakao 로그인 및 인증 흐름 개선

수정된 대표 파일:

```text
src/main/java/com/springmvc/controller/member/KakaoController.java
src/main/java/com/springmvc/service/user/KakaoServiceImpl.java
```

카카오 로그인 이후 일반 로그인 사용자와 동일하게 권한과 세션을 처리할 수 있도록 인증 흐름을 개선한 브랜치입니다.

### 2. Kakao Local API 및 맛집 검색 개선

수정된 대표 파일:

```text
src/main/java/com/springmvc/service/kakao/KakaoLocalService.java
src/main/java/com/springmvc/controller/restaurant/RestaurantController.java
src/main/java/com/springmvc/repository/restaurant/RestaurantRepositoryImpl.java
```

검색 키워드, 카테고리, 장소 저장, 맛집 리스트 출력 관련 로직이 추가로 개선되었습니다.

### 3. AI-Pick 화면 및 추천 UI 개선

수정된 대표 파일:

```text
src/main/webapp/WEB-INF/views/aipick/aiPick.jsp
```

AI-Pick 화면의 UI와 추천 결과 표시 영역이 강화되었습니다.

### 4. 관리자 화면 개선

수정된 대표 파일:

```text
src/main/webapp/WEB-INF/views/admin/admin.jsp
src/main/webapp/WEB-INF/views/admin/adminSidebar.jsp
src/main/webapp/WEB-INF/views/admin/inquiryDetail.jsp
src/main/webapp/WEB-INF/views/admin/memberList.jsp
src/main/webapp/WEB-INF/views/admin/reviewList.jsp
src/main/webapp/WEB-INF/views/admin/reviewDetail.jsp
```

관리자 대시보드, 회원 관리, 리뷰 관리, 문의 관리 화면이 개선되었습니다.

### 5. Footer, 모바일, 공통 UI 개선

수정 또는 추가된 대표 파일:

```text
src/main/webapp/WEB-INF/views/footer.jsp
src/main/webapp/resources/css/pickeat-mobile.css
src/main/webapp/resources/css/pickeat-final-fix.css
src/main/webapp/resources/css/pickeat-hard-fix.css
src/main/webapp/resources/js/pickeat-theme-fix.js
```

모바일 화면 대응, Footer 위치 문제, 다크 모드 가독성, 화면 레이아웃 보완이 반영되었습니다.

## JW 브랜치 기준 프로젝트 소개

PickEat은 사용자가 맛집을 단순 검색하는 데서 끝나지 않고,  
즐겨찾기, 리뷰, 최근 본 맛집 데이터를 활용해 개인화 추천을 제공하는 Spring MVC 기반 웹 서비스입니다.

사용자는 맛집 검색, 지도 조회, 상세 조회, 즐겨찾기, 리뷰 작성, 문의 작성, AI-Pick 추천 기능을 사용할 수 있습니다.  
관리자는 회원, 맛집, 리뷰, 문의를 관리할 수 있으며, Spring Security를 통해 사용자와 관리자 권한을 분리했습니다.

## 담당 기능 요약

- 회원가입, 로그인, 로그아웃
- 카카오 OAuth 로그인
- Spring Security 인증 및 권한 처리
- 마이페이지, 회원정보 수정, 비밀번호 변경
- 맛집 목록, 상세, 지도 조회
- Kakao Local API 기반 장소 검색
- 즐겨찾기와 최근 본 맛집
- 리뷰 작성, 수정, 목록 조회
- 관리자 리뷰 관리
- 사용자 문의 및 관리자 답변 관리
- AI-Pick 개인화 추천
- JSP 화면 및 CSS 개선
- 모바일 UI 보완
- Maven WAR 빌드 및 Tomcat 배포 테스트

## AI-Pick 추천 로직

AI-Pick은 머신러닝 모델을 직접 학습시키는 방식이 아니라,  
사용자의 행동 데이터를 분석하는 규칙 기반 추천 기능입니다.

활용 데이터:

```text
BOOKMARK
REVIEW
RECENTLY_RESTAURANT
RESTAURANT_TAG
USER_TASTE_PROFILE
```

추천 흐름:

```text
사용자 활동 데이터 수집
        │
        ▼
restaurant_id 추출
        │
        ▼
RESTAURANT_TAG에서 태그 추출
        │
        ▼
사용자별 선호 태그 생성
        │
        ▼
태그가 일치하는 맛집 후보 조회
        │
        ▼
위치 정보와 랜덤 요소 반영
        │
        ▼
AI-Pick 추천 결과 출력
```

## 면접에서 설명할 때

`JW` 브랜치는 다음처럼 설명하면 좋습니다.

> JW 브랜치는 PickEat 프로젝트의 최종 작업 브랜치에 가깝습니다. main 브랜치 이후 AI-Pick 추천, 리뷰 기능, 관리자 리뷰 관리, 카카오 로그인 개선, 카카오 장소 검색 개선, 화면 UI와 모바일 대응까지 반영했습니다. 특히 사용자 행동 데이터를 맛집 태그와 연결해 개인화 추천을 구현했고, Spring Security를 통해 사용자와 관리자 권한을 분리했습니다.

## 포트폴리오 제출 추천

면접관에게 GitHub 링크를 보낼 때는 `JW` 브랜치를 기준으로 안내하는 것이 좋습니다.

```text
https://github.com/Moon-0402/project/tree/JW
```

만약 GitHub 기본 화면에서 바로 보이게 하고 싶다면, 나중에 `JW` 브랜치를 `main`에 merge하거나 GitHub 기본 브랜치를 `JW`로 변경하는 방법도 있습니다.

## 주의할 점

현재 ChatGPT 연동에서는 README.md를 직접 커밋하는 권한이 막혀 있으므로, 이 md 내용을 GitHub에서 직접 업로드하는 방식이 가장 확실합니다.
