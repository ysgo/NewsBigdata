# [ Database Configuration ]

- MariaDB 기반

## 회원 정보

```mysql
create table memberinfo( 
    email varchar(100) not null, 
    password char(32) not null, 
    username varchar(20) not null, 
    gender varchar(8) not null, 
    generation int(5) not null, 
    created_at datetime default now() not null, 
    primary key(email), 
    unique key(username) 
);

select * from memberinfo;

drop table memberinfo;

```

## 뉴스 테이블

```mysql
create table newstmp(
    title varchar(300),
    date varchar(20), 
    contents text(65535)
);

- HIVE로 CSV 파일 DB에 저장
load data local infile '/root/sampledata/dfpoliticsUTF.csv' 
into table newstmp 
fields terminated by '#' lines terminated by '^';

```