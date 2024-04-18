-- 기존 테이블 드랍
drop table delivery;
drop table enrollments;
drop table payments;
drop table reviews;
drop table books;
drop table courses;
drop table categories;
drop table users;
drop table instructors;
drop table roadmap;
drop table lectures;

-- 강사 정보 테이블 생성
--CREATE TABLE Instructors (
--    instructor_id varchar2(100) PRIMARY KEY,    -- 데이터타입 varchar로 변경
--    instructor_name VARCHAR2(100),
--    email VARCHAR2(100),
--    password VARCHAR2(100),
--    phone_number VARCHAR2(20),
--    address VARCHAR2(200)
--);

-- 사용자 정보 테이블 생성
CREATE TABLE Users (
    user_id varchar2(100) PRIMARY KEY,      -- 데이터타입 varchar로 변경
    user_name VARCHAR2(100),
    email VARCHAR2(100),
    password VARCHAR2(100),
    phone_number VARCHAR2(20),
    address VARCHAR2(1000),          -- varchar2(1000)으로 늘림
    instruct_course varchar2(20)     -- 강의를 만드는 유저구분
);



-- 강의 정보 테이블 생성
CREATE TABLE Courses (
    course_id NUMBER PRIMARY KEY,
    course_title VARCHAR2(200),
    course_description VARCHAR2(1000),
    course_category VARCHAR2(100),
    user_id varchar2(100),        -- user_id로 바꿈
    course_price NUMBER,
    registration_date DATE,
    enrollment_count NUMBER,
    img_path VARCHAR2(1000),
    constraints fk_courses foreign key(user_id)
    references Users(user_id)
    on delete cascade
    
);

-- 수강 신청 테이블 생성
CREATE TABLE Enrollments (
    enrollment_id NUMBER PRIMARY KEY,
    user_id varchar2(100),
    course_id NUMBER,
    enrollment_date DATE,
    roadmap_id varcahr2(100)

    constraints fk_enrollments1 foreign key(user_id)
    references Users(user_id)
    on delete cascade
    
);

-- 평가 테이블 생성
CREATE TABLE Reviews (
    review_id NUMBER PRIMARY KEY,
    user_id varchar2(100),
    course_id NUMBER,
    review_content VARCHAR2(1000),
    review_score NUMBER,
    review_date DATE,
    
    constraints fk_reviews foreign key(user_id)
    references Users(user_id)
    on delete cascade
);

-- 결제 테이블 생성
CREATE TABLE Payments (
    payment_id NUMBER PRIMARY KEY,
    user_id varchar2(100),
    course_id NUMBER,
    payment_date DATE,
    payment_amount NUMBER,
    payment_status VARCHAR2(20),

    constraints fk_payments foreign key(user_id)
    references Users(user_id)
    on delete cascade
);

-- 카테고리 테이블 생성
CREATE TABLE Categories (       -- 카테고리 아이디 지움
    course_category VARCHAR2(100) primary key
    
);

-- ---------------------------------------------------
-- course_category 외래키 설정
ALTER TABLE Courses
ADD CONSTRAINT fk_courses_category
FOREIGN KEY (course_category)
REFERENCES Categories(course_category)
ON DELETE CASCADE;
-- -------------------------
create table books(
    book_id number primary key,
    course_id number,
    book_price number,      -- book_price로 변수명 바꿈
    book_title varchar2(250),
    constraint fk_books foreign key(course_id) references courses(course_id)
    on delete cascade
);

create table delivery(
    delivery_id number primary key,
    payment_id number,
    delivery_status varchar(50),
    
    constraint fk_delivery foreign key(payment_id) references payments(payment_id)
    on delete cascade
);


-- 도서 테이블 생성
create table books(
    book_id number primary key,
    course_id number,
    price number,
    book_title varchar2(250),
    constraint fk_books foreign key(course_id) references courses(course_id)
    on delete cascade
);

-- 배송 테이블 생성
create table delivery(
    delivery_id number primary key,
    payment_id number,
    delivery_status varchar(50),
    
    constraint fk_delivery foreign key(payment_id) references payments(payment_id)
    on delete cascade
);

-- price 변수명 변경
alter table books rename column price to book_price;
desc books;
alter table courses rename column price to course_price;
desc courses;

-- unique 제약조건 추가
ALTER TABLE Enrollments
ADD CONSTRAINT uc_enrollment UNIQUE (user_id, course_id);

ALTER TABLE Reviews
ADD CONSTRAINT uc_review UNIQUE (user_id, course_id);


-- ------------------------
-- not null 제약조건 추가
-- reviews table
alter table reviews modify user_id not null;
alter table reviews modify course_id not null;
alter table reviews modify review_score not null;
alter table reviews modify review_date not null;

-- users table
alter table users modify user_name not null;
alter table users modify password not null;
alter table users modify email not null;
alter table users modify phone_number not null;
alter table users modify address not null;

-- payments table
alter table payments modify payment_status not null;

-- courses table
alter table courses modify course_price not null;
alter table courses modify registration_date not null;
alter table courses modify course_title not null;

-- books
alter table books modify book_price not null;
alter table books modify book_title not null;

-- 결제창에 무조건 들어가야할 데이터 열 추가
ALTER TABLE Payments ADD user_name VARCHAR2(100);
ALTER TABLE Payments ADD phone_number VARCHAR(20);
ALTER TABLE Payments ADD email VARCHAR2(100);
ALTER TABLE Payments ADD course_title VARCHAR2(200);

ALTER TABLE Payments MODIFY user_name not null;
ALTER TABLE Payments MODIFY phone_number not null;
ALTER TABLE Payments MODIFY email not null;
ALTER TABLE Payments MODIFY course_title not null;

CREATE TABLE lectures (
    lecture_id NUMBER PRIMARY KEY,
    course_id NUMBER,
    lecture_number NUMBER,        -- 강의 순서
    lecture_title VARCHAR2(200),  -- 강의 제목 또는 소제목
    lecture_summary VARCHAR2(1000), -- 강의 요약
    video_link VARCHAR2(1000),     -- 강의 영상 링크
    duration NUMBER,               -- 강의 시간 (예: 분 단위)
    CONSTRAINT fk_lectures_courses FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE
);



INSERT INTO Categories (course_category) VALUES ('backend');
INSERT INTO Categories (course_category) VALUES ('frontend');
INSERT INTO Categories (course_category) VALUES ('ai');

ALTER TABLE lectures
ADD (img_path VARCHAR2(255));

-- 시퀀스 생성
drop sequence courses_course_id
create sequence Courses_course_id
increment BY 1
start with 1
minvalue 1
maxvalue 9999
nocycle
nocache
noorder;

CREATE TABLE RoadMap (
    RoadMap_Id NUMBER NOT NULL,
    RoadMap_Title VARCHAR2(255),
    RoadMap_Description CLOB,
    Img_Path VARCHAR2(500),
    user_ID VARCHAR2(255),
    CONSTRAINT pk_RoadMap PRIMARY KEY (RoadMap_id)
);

ALTER TABLE courses
ADD roadmap_id NUMBER;

ALTER TABLE courses
ADD CONSTRAINT fk_course_roadmap FOREIGN KEY (roadmap_id)
REFERENCES roadmap (roadmap_id);

ALTER TABLE enrollments
ADD roadmap_id NUMBER;

ALTER TABLE enrollments
ADD CONSTRAINT fk_enrollment_roadmap FOREIGN KEY (roadmap_id)
REFERENCES roadmap (roadmap_id);

ALTER TABLE roadmap RENAME COLUMN img_path TO roadmap_img;
update courses set roadmap_id = 1 where course_id=1;
update courses set roadmap_id = 1 where course_id=4;

create sequence RoadMap_roadmap_id
increment BY 1
start with 1
minvalue 1
maxvalue 9999
nocycle
nocache
noorder;

ALTER TABLE lectures MODIFY (duration VARCHAR2(100));
create sequence lectures_lecture_id
increment BY 1
start with 1
minvalue 1
maxvalue 9999
nocycle
nocache
noorder;

create table Teachers (
    teacher_id varchar2(100) primary key,
    teacher_name varchar2(100),
    constraint fk_teachers foreign key(teacher_id) references users(user_id)
    on delete cascade
);

alter table enrollments rename column user_id to student_id;
commit;

alter table users rename column instruct_course to interest;
commit;
select * from users;
select * from categories;
select * from lectures;
select * from courses;
select * from delivery;
select * from enrollments;
select * from payments;
select * from reviews;
select * from books;
select * from roadmap;
desc roadmap;
desc lectures;

ALTER TABLE payments
MODIFY (PAYMENT_ID VARCHAR2(255));
ALTER TABLE delivery
MODIFY (PAYMENT_ID VARCHAR2(255));
ALTER TABLE enrollments
MODIFY (enrollment_id VARCHAR2(255));
commit;


select * from reviews inner join courses on reviews.course_id = courses.course_id;
select * from reviews;
select * from courses;
delete from reviews;
create sequence Reviews_review_id
increment BY 1
start with 1
minvalue 1
maxvalue 9999
nocycle
nocache
noorder;
commit;

