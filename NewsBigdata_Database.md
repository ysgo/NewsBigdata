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

