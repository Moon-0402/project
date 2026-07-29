# PickEat - update 브랜치 설명

## 브랜치 역할

`update` 브랜치는 `main` 브랜치 이후 주요 기능들이 대량으로 추가된 기능 확장 브랜치입니다.  
`main`보다 31커밋 앞서 있으며, 리뷰 기능, AI-Pick 추천 기능, 관리자 리뷰 관리, 보안 설정, JSP 화면 개선 등이 반영되어 있습니다.

## main 대비 변경 요약

- `main`보다 31커밋 앞섬
- AI-Pick 추천 기능 추가
- 리뷰 사용자 기능 추가
- 관리자 리뷰 관리 기능 추가
- Spring Security 설정 개선
- Controller, Service, Repository 계층 확장
- JSP 화면 다수 수정
- 공통 Header / Footer / CSS 구조 개선
- 추천, 맛집 상세, 최근 본 맛집 화면 개선

## 주요 추가 기능

### 1. AI-Pick 추천 기능

추가된 대표 파일:

```text
src/main/java/com/springmvc/controller/aipick/AiPickController.java
src/main/java/com/springmvc/dto/aipick/AiPickDTO.java
src/main/java/com/springmvc/repository/aipick/AiPickRepository.java
src/main/java/com/springmvc/repository/aipick/AiPickRepositoryImpl.java
src/main/java/com/springmvc/service/aipick/AiPickService.java
src/main/java/com/springmvc/service/aipick/AiPickServiceImpl.java
src/main/webapp/WEB-INF/views/aipick/aiPick.jsp
```

이 기능은 사용자의 즐겨찾기, 리뷰, 최근 본 맛집 데이터를 바탕으로 개인화 추천을 제공하기 위한 기능입니다.

### 2. 리뷰 기능

추가된 대표 파일:

```text
src/main/java/com/springmvc/controller/review/ReviewController.java
src/main/java/com/springmvc/dto/review/ReviewDTO.java
src/main/java/com/springmvc/repository/review/ReviewRepository.java
src/main/java/com/springmvc/repository/review/ReviewRepositoryImpl.java
src/main/java/com/springmvc/service/review/ReviewService.java
src/main/java/com/springmvc/service/review/ReviewServiceImpl.java
src/main/webapp/WEB-INF/views/review/form.jsp
src/main/webapp/WEB-INF/views/review/list.jsp
src/main/webapp/WEB-INF/views/review/main.jsp
src/main/webapp/WEB-INF/views/review/myList.jsp
```

사용자는 맛집에 리뷰를 작성하고, 본인의 리뷰를 조회 및 관리할 수 있습니다.

### 3. 관리자 리뷰 관리

추가된 대표 파일:

```text
src/main/java/com/springmvc/controller/reviewAdmin/ReviewAdminController.java
src/main/java/com/springmvc/repository/reviewAdmin/ReviewAdminRepository.java
src/main/java/com/springmvc/service/reviewAdmin/ReviewAdminService.java
src/main/webapp/WEB-INF/views/admin/reviewList.jsp
src/main/webapp/WEB-INF/views/admin/reviewDetail.jsp
```

관리자는 리뷰 목록을 확인하고, 리뷰 상태를 관리할 수 있습니다.

### 4. Spring Security 및 Context 설정 개선

수정된 대표 파일:

```text
src/main/webapp/WEB-INF/spring/security-context.xml
src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml
src/main/webapp/WEB-INF/spring/root-context.xml
src/main/webapp/WEB-INF/web.xml
```

인증, 권한, Controller/Service/Repository Bean 등록 범위가 정리되었습니다.

### 5. 화면 및 CSS 개선

추가 또는 수정된 대표 파일:

```text
src/main/webapp/WEB-INF/views/header.jsp
src/main/webapp/WEB-INF/views/footer.jsp
src/main/webapp/resources/css/pickeat-final-fix.css
src/main/webapp/resources/css/pickeat-hard-fix.css
src/main/webapp/resources/js/pickeat-theme-fix.js
```

공통 레이아웃, 다크 모드, 화면 가독성, 사용자/관리자 페이지 스타일 개선이 진행되었습니다.

## 면접에서 설명할 때

`update` 브랜치는 다음처럼 설명할 수 있습니다.

> update 브랜치는 main 브랜치 이후 리뷰, AI-Pick, 관리자 리뷰 관리, Spring Security 설정, JSP 화면 개선이 집중적으로 반영된 기능 확장 브랜치입니다. 사용자 행동 데이터를 추천 기능으로 연결하고, Controller-Service-Repository 계층을 확장해 실제 서비스 기능을 구현했습니다.

## 추천 사용 용도

- 주요 기능 구현 확인
- AI-Pick과 리뷰 기능 설명
- 관리자 리뷰 관리 기능 설명
- Spring Security 설정 변화 확인
- main과 기능 차이를 비교할 때 사용

## 주의할 점

`update` 브랜치는 기능 확장 브랜치이지만, `JW` 브랜치가 `update`보다 5커밋 더 앞서 있습니다.  
최종 포트폴리오용 설명은 `JW` 브랜치를 기준으로 작성하는 것이 더 적합합니다.
