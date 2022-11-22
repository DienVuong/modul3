create database quanlysinhvien;
use quanlysinhvien;

create table class(
classID int auto_increment primary key not null,
class_name varchar(60) not null,
start_date datetime,
status bit
);
alter table student
change sudent_name
 student_name varchar(30);
create table student(
studentID int auto_increment primary key not null,
sudent_name varchar(30) not null,
address varchar(50),
phone varchar(20),
status bit,
classID int,
foreign key (classID) references class(classID)
);

create table subject(
subID int auto_increment primary key not null,
sub_name varchar(30) not null,
credit tinyint default 1 not null,
check( credit >= 1),
status bit default 1
);

create table mark(
markID int auto_increment primary key not null,
subID int  not null,
studentID int  not null,
foreign key (subID) references subject(subID),
foreign key (studentID) references student(studentID),
unique (subid, studentid),
mark float default 0,
check ( mark between 0 and 100),
examtimes tinyint default 1
);

insert into class(classid, class_name, start_date, status)
values(1, 'A1', '2008/12/20', 1),
(2, 'A2', '2008/12/22', 1),
(3, 'A3', current_date(), 0);

insert into student(studentid, sudent_name, address, phone, status,classid)
values(1,'Hung', 'Ha Noi', '0912113113',1,1),
(2,'Hoa', 'Hai Phong', null,1,1),
(3, 'Manh', 'HCM', '0123123123', 0,2);


insert into subject(subid, sub_name, credit, status)
values(1, 'CF', 5,1),
(2,'C',6,1),
(3,'HDJ', 5,1),
(4, 'RDBMS', 10,1);

insert into mark
values(1,1,1,8,1),
(2,1,2,10,2),
(3,2,1,12,1);


select * from student;

select * from student
where status = true;

select * from subject
where credit <10;

select student.studentid, student.student_name, class.class_name
from student  inner join class  on student.classid = class.classid
where class.class_name = 'A1';

select student.studentid, student.student_name, subject.sub_name, mark.mark
from student inner join mark on student.studentID = mark.studentID inner join subject on mark.subID = subject.subID
where subject.sub_name = 'CF';

-- hien thi sinh vien co ten bat dau bang ky tu h

select * from student
where student_name like 'h%';

-- hien thi thong tin lop hoc co thoi gian bat dau vao thang 12

select * from class
where month(start_date) = 12;

-- hien thi tat ca mon hoc co credit trong khoang 3-5

select * from subject
where credit between 3 and 5;

-- thay doi ma lop classID cua sinh vien hung la 2

update  student
set classid = 2
where studentid = 1;

-- hien thi thong tin studentname, subname, mark theo diem thi mark giam danneu trung sap theo ten tang dan
select student.student_name, subject.sub_name, mark from student
join mark on student.studentID = mark.studentID join subject on mark.subID = subject.subID
order by mark desc, student.student_name ;





-- hien thi so luong sinh vien o tung noi

select address, count(studentid) as 'so luong hoc vien' from student
group by address;

-- hien thi diem trung binh cac mon cua hoc vien
select student.studentid, student.student_name, avg(mark) as ' diem trung binh' from student
join mark on student.studentid = mark.studentid
group by student.studentid, student.student_name;

-- hien thi nhung hoc vien co diem trung binh >15
select student.studentid, student.student_name, avg(mark) as 'diem trunh binh > 15' from student
 join mark on student.studentid = mark.studentid
group by student.studentid, student.student_name
having avg(mark) >15;

-- hien thi thong tin hoc vien co diem trung binh lopn nhat
select student.studentid, student.student_name, avg(mark) as 'diem trung binh lon nhat' from student
join mark on student.studentid = mark.studentID
group by student.studentid, student.student_name
having avg(mark) >= all (select avg( mark) from mark group by mark.studentid);





-- bai tap luyen tap cac ham thong dung trong sql

-- hien thi mon hoc co credit lon nhat
select * from subject
where credit = (select max(credit) from subject);


-- create view 

CREATE VIEW customer_views AS
select customerNumber, customerName, phone
from customers;

select * from customer_views;

-- cap nhat view

CREATE OR REPLACE VIEW customer_views AS

SELECT customerNumber, customerName, contactFirstName, contactLastName, phone

FROM customers
WHERE city = 'Nantes';

select * from customer_views;


-- xoa view

drop view customer_views;









