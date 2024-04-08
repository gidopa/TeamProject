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





INSERT INTO Users (user_id, user_name, email, password, phone_number, address, instruct_course) VALUES ('user01', 'John Doe', 'johndoe@example.com', 'password123', '010-1234-5678', '123 John Street, Seoul', 'backend');
INSERT INTO Users (user_id, user_name, email, password, phone_number, address, instruct_course) VALUES ('user02', 'Jane Smith', 'janesmith@example.com', 'password123', '010-2345-6789', '234 Jane Road, Seoul', 'frontend');
INSERT INTO Users (user_id, user_name, email, password, phone_number, address, instruct_course) VALUES ('user03', 'Mike Brown', 'mikebrown@example.com', 'password123', '010-3456-7890', '345 Mike Ave, Seoul', 'ai');
INSERT INTO Users (user_id, user_name, email, password, phone_number, address, instruct_course) VALUES ('user04', 'Sarah Connor', 'sarahconnor@example.com', 'password123', '010-4567-8901', '456 Sarah Blvd, Seoul', 'backend');
INSERT INTO Users (user_id, user_name, email, password, phone_number, address, instruct_course) VALUES ('user05', 'James Lee', 'jameslee@example.com', 'password123', '010-5678-9012', '567 James Lane, Seoul', 'frontend');
INSERT INTO Users (user_id, user_name, email, password, phone_number, address, instruct_course) VALUES ('user06', 'Emily Park', 'emilypark@example.com', 'password123', '010-6789-0123', '678 Emily Path, Seoul', 'ai');

INSERT INTO Courses (course_id, course_title, course_description, course_category, user_id, course_price, registration_date, enrollment_count, img_path) VALUES (1, 'Backend Development Basics', 'Learn the basics of server-side development.', 'backend', 'user01', 100, TO_DATE('2024-04-01', 'YYYY-MM-DD'), 0, 'img/backend_basics.jpg');
INSERT INTO Courses (course_id, course_title, course_description, course_category, user_id, course_price, registration_date, enrollment_count, img_path) VALUES (2, 'Frontend for Beginners', 'An introduction to frontend technologies.', 'frontend', 'user02', 100, TO_DATE('2024-04-02', 'YYYY-MM-DD'), 0, 'img/frontend_beginners.jpg');
INSERT INTO Courses (course_id, course_title, course_description, course_category, user_id, course_price, registration_date, enrollment_count, img_path) VALUES (3, 'AI for Everyone', 'Understanding AI without heavy math.', 'ai', 'user03', 150, TO_DATE('2024-04-03', 'YYYY-MM-DD'), 0, 'img/ai_everyone.jpg');
INSERT INTO Courses (course_id, course_title, course_description, course_category, user_id, course_price, registration_date, enrollment_count, img_path) VALUES (4, 'Advanced Backend Techniques', 'Dive deeper into backend development.', 'backend', 'user04', 200, TO_DATE('2024-04-04', 'YYYY-MM-DD'), 0, 'img/backend_advanced.jpg');
INSERT INTO Courses (course_id, course_title, course_description, course_category, user_id, course_price, registration_date, enrollment_count, img_path) VALUES (5, 'Interactive Frontend Development', 'Creating interactive web applications.', 'frontend', 'user05', 150, TO_DATE('2024-04-05', 'YYYY-MM-DD'), 0, 'img/frontend_interactive.jpg');
INSERT INTO Courses (course_id, course_title, course_description, course_category, user_id, course_price, registration_date, enrollment_count, img_path) VALUES (6, 'Machine Learning Basics', 'Introduction to machine learning concepts.', 'ai', 'user06', 200, TO_DATE('2024-04-06', 'YYYY-MM-DD'), 0, 'img/ml_basics.jpg');

INSERT INTO Categories (course_category) VALUES ('backend');
INSERT INTO Categories (course_category) VALUES ('frontend');
INSERT INTO Categories (course_category) VALUES ('ai');

INSERT INTO lectures (lecture_id, course_id, lecture_number, lecture_title, lecture_summary, video_link, duration) VALUES (1, 1, 1, 'Introduction to Backend', 'Overview of backend technologies.', 'https://www.youtube.com/watch?v=example1', 30);
INSERT INTO lectures (lecture_id, course_id, lecture_number, lecture_title, lecture_summary, video_link, duration) VALUES (2, 1, 2, 'Setting Up Your Environment', 'How to set up development environment for backend.', 'https://www.youtube.com/watch?v=example2', 45);

-- 강의 2에 대한 모듈들
INSERT INTO lecturees (lecture_id, course_id, lecture_number, lecture_title, lecture_summary, video_link, duration) VALUES (3, 2, 1, 'Introduction to Frontend', 'Overview of frontend development.', 'https://www.youtube.com/watch?v=example3', 30);
INSERT INTO lectures (lecture_id, course_id, lecture_number, lecture_title, lecture_summary, video_link, duration) VALUES (4, 2, 2, 'HTML Basics', 'Introduction to HTML.', 'https://www.youtube.com/watch?v=example4', 45);

-- 강의 3에 대한 모듈들
INSERT INTO lectures (lecture_id, lecture_id, lecture_number, lecture_title, lecture_summary, video_link, duration) VALUES (5, 3, 1, 'What is AI?', 'Understanding Artificial Intelligence basics.', 'https://www.youtube.com/watch?v=example5', 30);
INSERT INTO lectures (lecture_id, lecture_id, lecture_number, lecture_title, lecture_summary, video_link, duration) VALUES (6, 3, 2, 'AI Applications', 'Exploring applications of AI in various fields.', 'https://www.youtube.com/watch?v=example6', 45);

INSERT INTO Enrollments (enrollment_id, user_id, course_id, enrollment_date) VALUES (1, 'user01', 2, TO_DATE('2024-04-10', 'YYYY-MM-DD'));
INSERT INTO Enrollments (enrollment_id, user_id, course_id, enrollment_date) VALUES (2, 'user02', 1, TO_DATE('2024-04-11', 'YYYY-MM-DD'));
INSERT INTO Enrollments (enrollment_id, user_id, course_id, enrollment_date) VALUES (3, 'user03', 4, TO_DATE('2024-04-12', 'YYYY-MM-DD'));
INSERT INTO Enrollments (enrollment_id, user_id, course_id, enrollment_date) VALUES (4, 'user04', 5, TO_DATE('2024-04-13', 'YYYY-MM-DD'));
INSERT INTO Enrollments (enrollment_id, user_id, course_id, enrollment_date) VALUES (5, 'user05', 3, TO_DATE('2024-04-14', 'YYYY-MM-DD'));
INSERT INTO Enrollments (enrollment_id, user_id, course_id, enrollment_date) VALUES (6, 'user06', 6, TO_DATE('2024-04-15', 'YYYY-MM-DD'));

INSERT INTO Payments (payment_id, user_id, course_id, payment_date, payment_amount, payment_status, user_name, phone_number, email, course_title) VALUES (1, 'user01', 2, TO_DATE('2024-04-10', 'YYYY-MM-DD'), 100, 'Completed', 'John Doe', '010-1234-5678', 'johndoe@example.com', 'Frontend for Beginners');
INSERT INTO Payments (payment_id, user_id, course_id, payment_date, payment_amount, payment_status, user_name, phone_number, email, course_title) VALUES (2, 'user02', 1, TO_DATE('2024-04-11', 'YYYY-MM-DD'), 100, 'Completed', 'Jane Smith', '010-2345-6789', 'janesmith@example.com', 'Backend Development Basics');
INSERT INTO Payments (payment_id, user_id, course_id, payment_date, payment_amount, payment_status, user_name, phone_number, email, course_title) VALUES (3, 'user03', 3, TO_DATE('2024-04-12', 'YYYY-MM-DD'), 150, 'Completed', 'Mike Brown', '010-3456-7890', 'mikebrown@example.com', 'AI for Everyone');
INSERT INTO Payments (payment_id, user_id, course_id, payment_date, payment_amount, payment_status, user_name, phone_number, email, course_title) VALUES (4, 'user04', 4, TO_DATE('2024-04-13', 'YYYY-MM-DD'), 200, 'Completed', 'Sarah Connor', '010-4567-8901', 'sarahconnor@example.com', 'Advanced Backend Techniques');
INSERT INTO Payments (payment_id, user_id, course_id, payment_date, payment_amount, payment_status, user_name, phone_number, email, course_title) VALUES (5, 'user05', 5, TO_DATE('2024-04-14', 'YYYY-MM-DD'), 150, 'Completed', 'James Lee', '010-5678-9012', 'jameslee@example.com', 'Interactive Frontend Development');
INSERT INTO Payments (payment_id, user_id, course_id, payment_date, payment_amount, payment_status, user_name, phone_number, email, course_title) VALUES (6, 'user06', 6, TO_DATE('2024-04-15', 'YYYY-MM-DD'), 200, 'Completed', 'Emily Park', '010-6789-0123', 'emilypark@example.com', 'Machine Learning Basics');




INSERT INTO Delivery (delivery_id, payment_id, delivery_status) VALUES (1, 1, '배송 준비 중');
INSERT INTO Delivery (delivery_id, payment_id, delivery_status) VALUES (2, 2, '배송 중');
INSERT INTO Delivery (delivery_id, payment_id, delivery_status) VALUES (3, 3, '배송 완료');
INSERT INTO Delivery (delivery_id, payment_id, delivery_status) VALUES (4, 4, '배송 준비 중');
INSERT INTO Delivery (delivery_id, payment_id, delivery_status) VALUES (5, 5, '배송 중');
INSERT INTO Delivery (delivery_id, payment_id, delivery_status) VALUES (6, 6, '배송 완료');
INSERT INTO Reviews (review_id, user_id, course_id, review_content, review_score, review_date) VALUES (1, 'user01', 2, 'Great course for beginners!', 5, TO_DATE('2024-04-20', 'YYYY-MM-DD'));
INSERT INTO Reviews (review_id, user_id, course_id, review_content, review_score, review_date) VALUES (2, 'user02', 1, 'Very informative and well structured.', 4, TO_DATE('2024-04-21', 'YYYY-MM-DD'));
INSERT INTO Reviews (review_id, user_id, course_id, review_content, review_score, review_date) VALUES (3, 'user03', 4, 'Helpful for understanding advanced concepts.', 5, TO_DATE('2024-04-22', 'YYYY-MM-DD'));
INSERT INTO Reviews (review_id, user_id, course_id, review_content, review_score, review_date) VALUES (4, 'user04', 5, 'Interactive and engaging content.', 4, TO_DATE('2024-04-23', 'YYYY-MM-DD'));
INSERT INTO Reviews (review_id, user_id, course_id, review_content, review_score, review_date) VALUES (5, 'user05', 3, 'A good introduction to AI for non-experts.', 5, TO_DATE('2024-04-24', 'YYYY-MM-DD'));
INSERT INTO Reviews (review_id, user_id, course_id, review_content, review_score, review_date) VALUES (6, 'user06', 6, 'Comprehensive and easy to follow.', 4, TO_DATE('2024-04-25', 'YYYY-MM-DD'));

INSERT INTO Books (book_id, course_id, book_price, book_title) VALUES (1, 1, 20, 'Backend Development for Beginners');
INSERT INTO Books (book_id, course_id, book_price, book_title) VALUES (2, 2, 25, 'Frontend Essentials with HTML and CSS');
INSERT INTO Books (book_id, course_id, book_price, book_title) VALUES (3, 3, 30, 'AI for the Curious Minds');
INSERT INTO Books (book_id, course_id, book_price, book_title) VALUES (4, 4, 20, 'Advanced Backend Strategies');
INSERT INTO Books (book_id, course_id, book_price, book_title) VALUES (5, 5, 25, 'Creative Frontend Design Patterns');
INSERT INTO Books (book_id, course_id, book_price, book_title) VALUES (6, 6, 30, 'Machine Learning from Scratch');


ALTER TABLE lectures
ADD (img_path VARCHAR2(255));

update lectures set video_link = 'https://www.youtube.com/watch?v=G3Y9FXZdM8U' where lecture_id=1 and course_id=1;
update lectures set video_link = 'https://www.youtube.com/watch?v=z1h1tUlqErM' where lecture_id=2 and course_id=1;
-- 시퀀스 생성
create sequence Courses_course_id
increment BY 1
start with 1
minvalue 1
maxvalue 9999
nocycle
nocache
noorder;

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