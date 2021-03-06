# movie_test database

use movie_test;

# replies 이후의 테이블 설계 내용
## 영화 예약에 필요한 것
### 영화 정보(영화 id, 영화 제목, ...)
### 상영 시간 정보(상영 시간 id, 영화 id, 상영 순서, 상영 날짜/시간)
### 상영관 정보(상영관 id, 상영관 넘버, 좌석 넘버)
### 예약 정보(예약 id, 상영관 id, 상영 시간 id, 유저 id)

create table movies(
	id int not null auto_increment primary key,
    title varchar(200),
    genre varchar(100),
    attendance int,
    year date
);
create table users (
	user_id int not null auto_increment primary key,
    login_id varchar(20) unique,
    email varchar(200),
    passwd varchar(100),
    created_at timestamp default current_timestamp,
    photo_url varchar(100),
    reset_passwd_token varchar(100) default ''
);
create table user_tokens (
	id int not null auto_increment primary key,
    user_id int,
    token varchar(200),
    foreign key (user_id) references users(user_id) on delete cascade
);
create table favorites (
	id int not null auto_increment primary key,
    user_id int,
    movie_id int,
    foreign key (user_id) references users(user_id) on delete cascade,
    foreign key (movie_id) references movies(id) on delete cascade
);
create table replies (
	reply_id int not null auto_increment primary key,
    user_id int,
    movie_id int,
    comments varchar(100),
    rating int,
    created_at timestamp default now(),
    updated_at timestamp default now() on update now(),
    foreign key (user_id) references users(user_id),
    foreign key (movie_id) references movies(id)
);
create table start_at (
	start_at_id int not null auto_increment primary key,
    movie_id int,
    screening_no int,
    start_at timestamp,
    foreign key (movie_id) references movies(id)
);
create table theaters (
	thearter_id int not null auto_increment primary key,
    thearter_no int,
    seat_no varchar(2)
);
create table reservations (
	reserve_id int not null auto_increment primary key,
    thearter_id int,
    start_at_id int,
    user_id int,
    foreign key (thearter_id) references theaters(thearter_id),
    foreign key (start_at_id) references start_at(start_at_id)
);

# insert_movie_data로 movies 데이터를 insert

use movie_test;
select * from movies;
select * from users;
select * from user_tokens order by id;
select * from favorites;
select * from replies;
select * from start_at;
select * from theaters;
select * from reservations;

select u.user_id, u.email, u.created_at, t.token from users as u join user_tokens as t on u.user_id = t.user_id where u.user_id = ? and t.token = ?; 

select m.id, ifnull(f.id, 0) as favorite_id, ifnull(u.user_id, 0) as user_id 
from movies as m left join favorites as f on m.id = f.movie_id
left join users as u on f.user_id = u.user_id 
where m.id = 1 and u.user_id = 2
order by m.id;

select * from favorites where movie_id = 1 and user_id = 2;

select m.*, if(f.id is not null, true, false), count(r.comments) as cnt_comments,
ifnull(round(avg(r.rating), 2), "unrated") as avg_rating
from movies as m left join replies as r on m.id = r.movie_id
left join favorites as f on m.id = f.movie_id and f.user_id = 10
group by m.id
order by m.id
limit 0, 25;

insert into favorites (user_id, movie_id) values (11, 1);

delete from favorites where user_id = 11 and movie_id = 3;

select count(*) from favorites;