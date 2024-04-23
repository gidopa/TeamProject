<img src="https://img.shields.io/badge/github-181717?style=for-the-badge&logo=github&logoColor=white">

<div align="center">
  <h1>인터넷 강의 사이트</h1>
</div>


#### 많이 사용되는 인프런을 벤치마킹해 많은 사람들이 자신의 지식을 공유하고 또 다른 사람의 지식을 공유받아 서로 윈윈 할 수 있는 인터넷 강의 사이트

## 참고 사이트
[인프런](https://www.inflearn.com/)


## :mortar_board: 목차
[1. 개요](#1-개요)

[2. ERD](#2-erd)

[3. 주요 기능](#3-주요기능)


## 1. 개요
### :computer: 기술 스택
#### Platform
![Windows](https://img.shields.io/badge/Windows-0078D6?style=for-the-badge&logo=windows&logoColor=white)
![Eclipse](https://img.shields.io/badge/Eclipse-0078D6.svg?style=for-the-badge&logo=Eclipse&logoColor=purple)
![apachetomcat](https://img.shields.io/badge/tomcat-0078D6.svg?style=for-the-badge&logo=apachetomcat&logoColor=yellow)
#### RDBMS
![Oracle](https://img.shields.io/badge/Oracle-0078D6?style=for-the-badge&logo=oracle&logoColor=red)
#### Templates
![JSP](https://img.shields.io/badge/JSP-0078D6.svg?style=for-the-badge&logo=Laravel&logoColor=white)
![CSS3](https://img.shields.io/badge/css3-0078D6.svg?style=for-the-badge&logo=css3&logoColor=white)
 ![BOOTSTRAP](https://img.shields.io/badge/Bootstrap-0078D6?style=for-the-badge&logo=bootstrap&logoColor=#7952B3)
#### Application Development / Skills
![Java](https://img.shields.io/badge/Java-0078D6?style=for-the-badge&logo=openjdk&logoColor=white)
![JavaScript](https://img.shields.io/badge/javascript-0078D6.svg?style=for-the-badge&logo=javascript&logoColor=%23F7DF1E)
 ![Jquery](https://img.shields.io/badge/jQuery-0078D6?style=for-the-badge&logo=jquery&logoColor=white)
 ![Logback](https://img.shields.io/badge/Logback-0078D6?style=for-the-badge&logo=loopback&logoColor=white)

![kakao](https://img.shields.io/badge/kakao%20API-0078D6?style=for-the-badge&logo=kakaotalk&logoColor=#F80000)
  ![naver](https://img.shields.io/badge/naver%20API-0078D6?style=for-the-badge&logo=naver&logoColor=green)
 ![JSON](https://img.shields.io/badge/json%20web%20tokens-0078D6?style=for-the-badge&logo=json-web-tokens&logoColor=pink)
 
<hr>

 ### :watch: 프로젝트 기간
 2024-04-01 ~ 2024-04-24
 
<hr>

### :busts_in_silhouette: 팀원 소개
- 박기도 :full_moon:
- 장원보 :walking: 
- 장영훈
- 김용수 :dragon_face: 
- 전영환
- 박해원
- 김영환

<hr>

### :flags: 기본 규칙
- Naming Convention
  - JAVA : Camel Case
  - DB, JS : snake_case
  - 최대한 변수의 의미에 중점을 둔 네이밍
    
- Comment
  - 클래스와 메소드가 어떤 역할을 하는지
  - 다중 if/for 등 로직이 복잡한 경우 / 특별한 제약이 필요한 경우
  - 변수의 이름만으로 설명이 부족한 경우
 
- Debug용 콘솔 출력
  - System.out.println 보다는 Logback 적극 활용
 
- 기타
  - 서블릿 기반의 MVC 패턴
  - SRP(단일 책임 원칙)을 준수하여 함수와 클래스가 하나의 책임만을 갖도록 설계
  - 함수나 클래스는 작고 명확하게 유지하면서 코드의 중복을 줄여 유지보수를 용이하도록 설계
  - 진행 상태확인 및 대략적인 소모차트 예상 , 간단한 스크럼 회의 이후 스프린트 진행, 스프린트 리뷰 등의 방법으로 지속적인 커뮤니케이션 유지
 
<hr>
    
## 2. Erd
![ERD](https://github.com/gidopa/TeamProject/assets/120196095/7458a764-30ef-438b-bf81-59167be1bed9)


## 3. 주요기능
:arrow_right: 로그인 
일반적인 로그인 및 카카오 로그인 API, 네이버 로그인 API 활용

:arrow_right: 강의 등록 / 수정 
회원 가입만 하면 그 누구라도 강의를 등록하여 지식공유자의 일원으로서 강사로의 활동 가능 / 추후 업데이트를 위한 수정 기능 

:arrow_right: 강의 시청
구매한 강의라면 무기한 시청

:arrow_right: 로드맵
지식 공유자가 제시하는 한 분야의 정복을 위한 로드맵

:arrow_right: 결제
포트원의 KG 이니시스 V1 모듈을 이용한 결제 시스템 구현

:arrow_right: 수강후기 / 공지사항 / 고객센터 게시판
여러 가지 정보들을 얻을 수 있는 게시판 구현








