use my_test;

desc memos;

create table bootcamp (
	id int not null auto_increment primary key,
    title varchar(100),
    subject varchar(30),
    teacher varchar(20),
    start_time timestamp
);

drop table bootcamp;

select * from bootcamp;

insert into bootcamp (title, `subject`, teacher, start_time)
 values ("안드로이드 개발", "JAVA", "홍길동", "2020-05-02 11:23:00");


-- 깃허브 Node 실습 8

create table contact (
	id int not null auto_increment primary key,
    name varchar(100),
    phone varchar(50),
    comment varchar(100)
);

select * from contact;

select * from contact where name like "%%" or phone like "%%";

insert into contact (name, phone) values
("홍길동", "010-1234-7676");

drop table contact;