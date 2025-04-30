Create database SISDB;
Use SISDB;
Create Table Students (
students_id int primary key auto_increment,
first_name varchar (255) not null,
last_name varchar (255) not null,
date_of_birth date not null,
email varchar (255) unique not null,
phone_number varchar(15)
);
Create Table teacher(
teacher_id int primary key auto_increment,
first_name varchar (255) not null,
last_name varchar (255) not null,
email varchar (255) unique not null
);
Create Table Courses (
course_id int primary key auto_increment,
course_name varchar (255) not null,
credits int not null,
teacher_id int ,
constraint ti foreign key (teacher_id) references teacher (teacher_id)
);
Create Table Enrollments(
enrollment_id int primary key auto_increment,
students_id int ,
course_id int,
enrollment_date date not null,
constraint fk foreign key (students_id) references Students (students_id) on delete cascade,
constraint ci foreign key (course_id) references Courses (course_id) on delete cascade
);
Create Table Payments(
payment_id int primary key auto_increment,
students_id int,
amount int,
payment_date date ,
constraint si foreign key (students_id) references Students (students_id) on delete cascade
);
insert into Students(first_name, last_name, date_of_birth, email, phone_number) VALUES
('Allan', 'Ronald', '2000-01-15', 'allan.ronald@gmail.com', '1234567990'),
('Alice', 'Nandhan', '2001-05-22', 'alice.nandhan@gmail.com', '1234567891'),
('Boomi', 'Naadhan', '2001-05-28', 'boomi.naadhan@gmail.com', '1234567892'),
('Cathlin', 'Jenifer', '2001-08-22', 'cathlin.jenifer@gmail.com', '1234567893'),
('Diviny', 'Patricia', '2001-09-12', 'diviny.patricia@gmail.com', '1234567894'),
('Emy', 'Psalm', '2001-05-07', 'emy.psalm@gmail.com', '1234567895'),
('Saradha', 'Priya', '2001-10-03', 'saradha.priya@gmail.com', '1234567896'),
('Seetha', 'Nandhan', '2001-12-09', 'seetha.nandhan@gmail.com', '12345678917'),
('Yazhini', 'Kannan', '2001-03-22', 'yazhini.kannan@gmail.com', '1234567898'),
('Zoe', 'Fathima', '2001-07-17', 'Zoe.Fathima@gmail.com', '1234567899');
INSERT INTO teacher (first_name, last_name, email) VALUES
('Dr. Aarti', 'Sharma', 'aarti.sharma@gmail.com'),
('Dr. Rajesh', 'Kumar', 'rajesh.kumar@yahoo.com'),
('Dr. Sneha', 'Patel', 'sneha.patel@gmail.com'),
('Dr. Vikram', 'Rao', 'vikram.rao@yahoo.com'),
('Dr. Meena', 'Iyer', 'meena.iyer@gmail.com'),
('Dr. Anil', 'Verma', 'anil.verma@yahoo.com'),
('Dr. Pooja', 'Desai', 'pooja.desai@gmail.com'),
('Dr. Rohit', 'Mehta', 'rohit.mehta@yahoo.com'),
('Dr. Neha', 'Joshi', 'neha.joshi@gmail.com'),
('Dr. Arjun', 'Singh', 'arjun.singh@yahoo.com');
insert into Courses (course_name, credits, teacher_id) VALUES
('Computer Science Basics', 3, 1),
('Data Structures', 4, 2),
('Maths', 3, 3),
('OS', 4, 4),
('DBMS', 3, 5),
('Web Development', 2, 6),
('Mobile App Development', 3, 7),
('Software Engineering', 4, 8),
('ML', 3, 9),
('AI', 3, 10);
insert into Enrollments (students_id, course_id, enrollment_date) VALUES
(1, 1, '2024-01-15'),
(2, 2, '2024-02-01'),
(3, 3, '2024-03-05'),
(4, 4, '2024-01-20'),
(5, 5, '2024-03-10'),
(6, 6, '2024-04-01'),
(7, 7, '2024-02-28'),
(8, 8, '2024-03-15'),
(9, 9, '2024-04-10'),
(10, 10, '2024-05-01');
INSERT INTO Payments (students_id, amount, payment_date) VALUES
(1, 500, '2024-01-16'),
(2, 450, '2024-02-02'),
(3, 600, '2024-03-06'),
(4, 550, '2024-01-21'),
(5, 500, '2024-03-11'),
(6, 480, '2024-04-02'),
(7, 520, '2024-02-29'),
(8, 530, '2024-03-16'),
(9, 610, '2024-04-11'),
(10, 470, '2024-05-02');
insert into Students(first_name,last_name,date_of_birth,email,phone_number) values
('John','Doe','1995-08-15','john.doe@example.com','1234567890');
insert into Enrollments (students_id, course_id, enrollment_date) VALUES
(11,3,'2024-06-18');
update teacher set email = 'patel.90sneh@gmail.com' where teacher_id = 3;
delete from Enrollments where students_id = 9 and course_id = 9;
update Courses set teacher_id = 2 where course_id = 1; 
delete from Enrollments where students_id = 1;
delete from students where students_id = 2;
update payments set amount = 570 where students_id = 2;
select s.students_id , s.first_name, s.last_name , sum(p.amount) as totalpayments
from Students s
join payments p on s.students_id = p.students_id
where s.students_id = 6
group by s.students_id , s.first_name , s.last_name;
select c.course_id , c.course_name , count(e.enrollment_id) as count_of_students
from Courses c
left join enrollments e on c.course_id = e.course_id
group by c.course_id , c.course_name 
order by count_of_students desc;
select s.students_id , s.first_name , s.last_name 
from Students s
left join enrollments e on s.students_id = e.students_id
where e.enrollment_id is null;

