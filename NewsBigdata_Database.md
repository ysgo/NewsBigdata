# [ Database Configuration ]

- MariaDB 기반

## 회원 정보 테이블

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

## 뉴스 정보 테이블

```mysql
CREATE TABLE `news_list` (
	`idx` INT(50) NOT NULL AUTO_INCREMENT,
	`newsname` VARCHAR(50) NOT NULL,
	`title` VARCHAR(255) NOT NULL,
	`category` VARCHAR(50) NOT NULL,
	`date` VARCHAR(50) NOT NULL,
	`url` VARCHAR(255) NULL DEFAULT NULL,
	`content` LONGTEXT NOT NULL,
	PRIMARY KEY (`idx`),
	UNIQUE INDEX `title` (`title`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=273;


- HIVE로 CSV 파일 DB에 저장
load data local infile '/root/sampledata/dfpoliticsUTF.csv' 
into table newstmp 
fields terminated by '#' lines terminated by '^';
```

## 뉴스 관련 지역 정보 테이블

```mysql
CREATE TABLE `news_district` (
	`idx` INT(50) NOT NULL,
	`p_code` INT(10) UNSIGNED NOT NULL,
	`s_code` INT(10) UNSIGNED NOT NULL
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB;
```

## 지역 정보 테이블

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

