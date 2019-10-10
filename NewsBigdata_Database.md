# [ Database Configuration ]

- MariaDB 기반

## 회원 정보

```mysql
create table memberinfo( 
    email varchar(100) not null, 
    password varchar(100) not null default '0', 
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
CREATE TABLE `news` (
	`newsname` VARCHAR(50) NULL DEFAULT NULL,
	`title` VARCHAR(255) NULL DEFAULT NULL,
	`category` VARCHAR(50) NULL DEFAULT NULL,
	`date` VARCHAR(50) NULL DEFAULT NULL,
	`url` VARCHAR(255) NULL DEFAULT NULL,
	`content` LONGTEXT NULL DEFAULT NULL
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB;

- HIVE로 CSV 파일 DB에 저장
load data local infile '/root/sampledata/dfpoliticsUTF.csv' 
into table newstmp 
fields terminated by '#' lines terminated by '^';
```

## 타이틀, 본문 관련 지역 테이블

```mysql
CREATE TABLE `contents` (
	`content` LONGTEXT NULL DEFAULT NULL,
	`p_name` VARCHAR(50) NULL DEFAULT NULL,
	`s_name` VARCHAR(50) NULL DEFAULT NULL
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB;

CREATE TABLE `titles` (
	`title` VARCHAR(255) NULL DEFAULT NULL,
	`p_name` VARCHAR(50) NULL DEFAULT NULL,
	`s_name` VARCHAR(50) NULL DEFAULT NULL
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB;
```

## 지역명 테이블

```mysql
CREATE TABLE `province` (
	`p_code` INT(50) NULL DEFAULT NULL,
	`name` VARCHAR(50) NULL DEFAULT NULL,
	`latitude` DOUBLE NULL DEFAULT NULL,
	`longitude` DOUBLE NULL DEFAULT NULL
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB;

CREATE TABLE `sigungu` (
	`p_code` INT(50) NULL DEFAULT NULL,
	`s_code` INT(50) NULL DEFAULT NULL,
	`name` VARCHAR(50) NULL DEFAULT NULL,
	`latitude` DOUBLE NULL DEFAULT NULL,
	`longitude` DOUBLE NULL DEFAULT NULL
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB;
```

