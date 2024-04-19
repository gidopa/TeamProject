-- 기존 테이블 드랍
drop table reviews;
drop table payments;
drop table lectures;
drop table enrollments;
drop table roadmap;
drop table roadmaps;
drop table courses;
drop table users;
drop table categories;

-- 시퀀스 드랍
drop sequence Courses_course_id;
drop sequence RoadMap_roadmap_id;
drop sequence lectures_lecture_id;
drop sequence Reviews_review_id;


-- 테이블 생성
CREATE TABLE Categories (       
    course_category VARCHAR2(100) primary key
);

CREATE TABLE USERS (
    USER_ID VARCHAR2(100 BYTE) NOT NULL,
    USER_NAME VARCHAR2(100 BYTE) NOT NULL,
    EMAIL VARCHAR2(100 BYTE) NOT NULL,
    PASSWORD VARCHAR2(100 BYTE) NOT NULL,
    PHONE_NUMBER VARCHAR2(20 BYTE) NOT NULL,
    ADDRESS VARCHAR2(1000 BYTE) NOT NULL,
    INTEREST VARCHAR2(20 BYTE),
    CONSTRAINT PK_USERS PRIMARY KEY (USER_ID)
);


CREATE TABLE COURSES (
    COURSE_ID NUMBER NOT NULL,
    COURSE_TITLE VARCHAR2(200 BYTE) NOT NULL,
    COURSE_DESCRIPTION VARCHAR2(1000 ),
    COURSE_CATEGORY VARCHAR2(100 ),
    USER_ID VARCHAR2(100 BYTE),
    COURSE_PRICE NUMBER NOT NULL,
    REGISTRATION_DATE DATE NOT NULL,
    ENROLLMENT_COUNT NUMBER,
    IMG_PATH VARCHAR2(1000 ),
    ROADMAP_ID NUMBER,
    CONSTRAINT PK_COURSES PRIMARY KEY (COURSE_ID),
    constraint fk_courses FOREIGN key(user_id) references Users(user_id)
    on delete cascade,
    constraint  fk_courses_category FOREIGN KEY (course_category) REFERENCES Categories(course_category)
    ON DELETE CASCADE
);

CREATE TABLE ROADMAP (
    ROADMAP_ID NUMBER NOT NULL,
    ROADMAP_TITLE VARCHAR2(255 BYTE),
    ROADMAP_DESCRIPTION CLOB,
    ROADMAP_IMG VARCHAR2(500 BYTE),
    USER_ID VARCHAR2(255 BYTE),
    CONSTRAINT PK_ROADMAPS PRIMARY KEY (ROADMAP_ID)
);

CREATE TABLE ENROLLMENTS (
    ENROLLMENT_ID VARCHAR2(255) NOT NULL,
    STUDENT_ID VARCHAR2(100 BYTE),
    COURSE_ID NUMBER,
    ENROLLMENT_DATE DATE,
    ROADMAP_ID NUMBER,
    CONSTRAINT PK_ENROLLMENTS PRIMARY KEY (ENROLLMENT_ID),
    CONSTRAINT uc_enrollment UNIQUE (STUDENT_ID, COURSE_ID),
    constraint fk_enrollments1 foreign key(student_id) references Users(user_id)
    on delete cascade,
    CONSTRAINT fk_enrollment_roadmap FOREIGN KEY (roadmap_id) REFERENCES roadmaps (roadmap_id)
    on delete cascade
);

CREATE TABLE LECTURES (
    LECTURE_ID NUMBER NOT NULL,
    COURSE_ID NUMBER,
    LECTURE_NUMBER NUMBER,
    LECTURE_TITLE VARCHAR2(200 BYTE),
    LECTURE_SUMMARY VARCHAR2(3000 BYTE),
    VIDEO_LINK VARCHAR2(1000 BYTE),
    DURATION VARCHAR2(100 BYTE),
    IMG_PATH VARCHAR2(255 BYTE),
    CONSTRAINT PK_LECTURES PRIMARY KEY (LECTURE_ID),
    CONSTRAINT fk_lectures_courses FOREIGN KEY (course_id) REFERENCES Courses(course_id) 
    ON DELETE CASCADE
); 

CREATE TABLE PAYMENTS (
    PAYMENT_ID VARCHAR2(200 BYTE) NOT NULL,
    USER_ID VARCHAR2(100 BYTE),
    COURSE_ID NUMBER,
    PAYMENT_DATE DATE,
    PAYMENT_AMOUNT NUMBER,
    PAYMENT_STATUS VARCHAR2(20 BYTE),
    USER_NAME VARCHAR2(100 BYTE) NOT NULL,
    PHONE_NUMBER VARCHAR2(20 BYTE) NOT NULL,
    EMAIL VARCHAR2(100 BYTE) NOT NULL,
    ROADMAP_ID NUMBER,
    CONSTRAINT PK_PAYMENTS PRIMARY KEY (PAYMENT_ID),
    constraint fk_payments foreign key(user_id) references Users(user_id)
    on delete cascade
);

CREATE TABLE REVIEWS (
    REVIEW_ID NUMBER NOT NULL,
    USER_ID VARCHAR2(100 BYTE) NOT NULL,
    COURSE_ID NUMBER NOT NULL,
    REVIEW_CONTENT VARCHAR2(1000 BYTE),
    REVIEW_SCORE NUMBER NOT NULL,
    REVIEW_DATE DATE NOT NULL,
    CONSTRAINT PK_REVIEWS PRIMARY KEY (REVIEW_ID),
    CONSTRAINT uc_review UNIQUE (USER_ID, COURSE_ID),
    constraint fk_reviews foreign key(user_id) references Users(user_id)
    on delete cascade
);

-- 시퀀스 생성
create sequence Courses_course_id
increment BY 1
start with 1
minvalue 1
maxvalue 9999
nocycle
nocache
noorder;

create sequence RoadMap_roadmap_id
increment BY 1
start with 1
minvalue 1
maxvalue 9999
nocycle
nocache
noorder;

create sequence lectures_lecture_id
increment BY 1
start with 1
minvalue 1
maxvalue 9999
nocycle
nocache
noorder;

create sequence Reviews_review_id
increment BY 1
start with 1
minvalue 1
maxvalue 9999
nocycle
nocache
noorder;

-- 카테고리 삽입
insert into Categories (course_category)
values ('backend');
insert into Categories (course_category)
values ('frontend');
insert into Categories (course_category)
values ('ai');
commit;