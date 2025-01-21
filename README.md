## 역할 분담
|강승민|임하형|차기석|
|:---:|:---:|:---:|
|회원 정보 수정 및 회원 삭제|회원 정보 입력 및 git 관리<br>(merge, conflict solve)|회원 검색 결과 조회 및 DB 구축|
<br>

## DATABASE 구축
```sql
create table student_info(
   stu_id int auto_increment primary key,
   stu_name varchar(50),
    stu_live varchar(50), -- 거주하는 동
    stu_school varchar(50),
    stu_major varchar(50)
);

create table student_name(
   stu_id int primary key,
   stu_name varchar(50),
    foreign key(stu_id) references student_info(stu_id)
);

insert into student_info(stu_name, stu_live, stu_school, stu_major) values('강승민', '광교', '서울대학교', '심리사이버경제부동산학과');
insert into student_name values(1, '강승민');
insert into student_info(stu_name, stu_live, stu_school, stu_major) values('임하형', '서구', '하버드대학교', '컴퓨터공학과');
insert into student_name values(2, '임하형');
insert into student_info(stu_name, stu_live, stu_school, stu_major) values('차기석', '계양구', '서울사이버대학교', '컴퓨터공학과');
insert into student_name values(3, '차기석');
insert into student_info(stu_name, stu_live, stu_school, stu_major) values('김주영', '성북구', '숭실대학교', '간호학과');
insert into student_name values(4, '김주영');
insert into student_info(stu_name, stu_live, stu_school, stu_major) values('이다훈', '강남구', '고려대학교', '감귤포장학과');
insert into student_name values(5, '이다훈');
```
