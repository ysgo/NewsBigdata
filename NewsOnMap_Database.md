# [ Database Configuration ]

- MariaDB 기반
- 뉴스 관련 정보 테이블은 정해진 순서대로 생성해야함(아래 순서대로)

## 회원 정보 테이블

```mariadb
CREATE TABLE memberinfo ( 
    email varchar(100) NOT NULL, 
    password varchar(100) NOT NULL DEFAULT '0', 
    username varchar(20) NOT NULL, 
    gender varchar(8) NOT NULL, 
    generation int(5) NOT NULL, 
    created_at DATETIME DEFAULT NOW() NOT NULL, 
	
    PRIMARY KEY (email), 
    UNIQUE KEY (username) 
);
```



## 뉴스 정보 테이블 - 1

```mariadb
CREATE TABLE news_lists (
	id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(50) NOT NULL,
	title VARCHAR(255) NOT NULL,
	category VARCHAR(50) NOT NULL,
	date VARCHAR(50) NOT NULL,
	url VARCHAR(255),
	content LONGTEXT NOT NULL,
	
	PRIMARY KEY (id)
);
```



## 지역 정보 테이블

### 시도 테이블 - 2

```mariadb
CREATE TABLE provinces (
	id INT NOT NULL AUTO_INCREMENT,
	code INT NOT NULL,
	name VARCHAR(50),
	latitude DOUBLE,
	longitude DOUBLE,
	
	PRIMARY KEY(id)
);
```

### 시군구 테이블 - 3

```mysql
CREATE TABLE sigungus (
	id INT NOT NULL AUTO_INCREMENT,
	province_id INT NOT NULL,
	code INT NOT NULL,
	name VARCHAR(50),
	latitude DOUBLE,
	longitude DOUBLE,
	
	PRIMARY KEY(id),
	FOREIGN KEY(province_id) REFERENCES provinces (id)
)
```



## 뉴스 관련 지역 정보 테이블 - 4

```mariadb
CREATE TABLE news_districts (
	id INT NOT NULL AUTO_INCREMENT,
	news_id INT NOT NULL,
	province_id INT NOT NULL,
	sigungu_id INT NOT NULL,
	
	PRIMARY KEY(id),
	FOREIGN KEY(news_id) REFERENCES news_lists (id),
	FOREIGN KEY(province_id) REFERENCES provinces (id),
	FOREIGN KEY(sigungu_id) REFERENCES sigungus (id)
)
```
