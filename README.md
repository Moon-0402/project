# PickEat - main 브랜치 설명

## 브랜치 역할

`main` 브랜치는 PickEat 프로젝트의 기본 브랜치입니다.  
프로젝트의 기본 Maven/Spring MVC 구조가 잡혀 있는 기준 브랜치로 볼 수 있습니다.

## 프로젝트 기본 정보

- Repository: `Moon-0402/project`
- Branch: `main`
- 기본 브랜치 여부: 예
- 프로젝트명: `AppProject01`
- 패키징 방식: `war`
- 주요 기반: eGovFrame 기반 Spring MVC 웹 프로젝트
- Java/Spring 환경:
  - Java 17 사용 프로젝트로 관리
  - Spring Framework 6.2.0
  - Spring Security 6.3.4
  - eGovFrame 5.0.0 기반 설정

## main 브랜치에서 확인 가능한 핵심

`main`은 최종 기능이 모두 합쳐진 브랜치라기보다는, 프로젝트의 기본 뼈대가 되는 브랜치입니다.

확인 포인트는 다음과 같습니다.

- Maven 기반 WAR 프로젝트 구조
- eGovFrame Web Config Parent 사용
- Spring MVC 기반 웹 애플리케이션 구조
- MySQL Connector 설정
- Spring / Spring Security 버전 관리
- 기본 Controller, JSP, 설정 파일 구조

## 면접에서 설명할 때

`main` 브랜치는 최종 기능 확인용보다는 프로젝트의 기본 구조를 보여주는 기준 브랜치입니다.

면접관에게는 다음처럼 설명하면 좋습니다.

> main 브랜치는 프로젝트의 기본 구조와 Maven, Spring MVC, eGovFrame 설정을 확인할 수 있는 기준 브랜치입니다. 실제 기능 확장과 UI 개선, AI-Pick, 리뷰, 관리자 기능은 update와 JW 브랜치에서 더 많이 진행되었습니다.

## 추천 사용 용도

- 프로젝트 기본 구조 확인
- `pom.xml`과 Spring 설정 확인
- 다른 브랜치와 비교할 기준점
- 최종 포트폴리오 제출용보다는 비교 기준용

## 주의할 점

포트폴리오 제출이나 면접 시 최종 구현 내용을 보여주려면 `main`보다 `JW` 브랜치를 기준으로 설명하는 것이 더 적합합니다.
