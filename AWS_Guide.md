# [ AWS DB Config Guide ]

## Database Install

```bash
- 마리아 관련 패키지 검색
$ apt-cache search maria
....
mariadb-server - MariaDB database server (metapackage depending on the latest version) 확인
....

$ sudo apt-get install mariadb-server

$ mysql -u root -p 
Enter password: 


```



## MariabDB 원격접속

- 참조사이트

  ```
  http://lab4109.blogspot.kr/2013/10/aws-ec2-ip.html 
  
  http://devxpert.egloos.com/viewer/1017656 
  ```

- 새로운 DB 생성

  ```
  MariaDB [(none)]> create database testDB;
  ```

- 새로운 사용자 생성

  ```
  MariaDB [(none)]> create user 'test'@'%' identified by 'password'; ---외부(원격)에서 사용하기 위해서는 '%' 로 생성을 해야 한다고 함
  
  MariaDB [(none)]> create user 'test'@'localhost' identified by 'password'; ---로컬용
  ```

- 권한부여와 확정

  ```
  MariaDB [(none)]> grant all privileges on [testDB].* to test@'%';
  
  MariaDB [(none)]> flush privileges;
  ```

- EC2 서버에 SQL에서 사용하는 포트 개방(port:3306) 필요

- MySQL 기본설정이 로컬로 설정되있는지 확인

  ```
  sudo nano /etc/mysql/my.cnf 
  
  ...
  
  #bind_address=127.0.0.1 ---주석처리 또는 0.0.0.0
  
  ...
  ```

- MySQL 서비스 재시작

  ```
  sudo service mysql restart
  
  sudo /etc/init.d/mysql restart
  ```

  

## MariaDB 계정 생성 및 권한 주기

```
마리아디비에 접속
# mysql -u root -p
Enter password: 패스워드 입력

데이터베이스 리스트 확인
# show databases;

없다면 생성
# create database DB명;

기본으로 생성되어 있는 mysql 데이터베이스를 사용한다
# use mysql;

mysql의 user 테이블에서 이미 생성된 계정 확인
# select host, user, password from user;
# SELECT Host, User, Super_priv FROM mysql.user WHERE User='testuser';

mysql은 보안상 기본적으로 외부접속을 허용하지 않기 때문에
계정을 생성할떄 특정 IP 혹은 localhost 를 지정하거나 %를 지정하여 외부접속을 허용할 수 있다.

user1 계정 생성
# create user '계정아이디'@'접속위치' identified by '패스워드';
ex. create user 'user1'@'%' identified by 'user!@#$';

user1 권한 주기
# grant all privileges on DB이름.테이블 to '계정아이디'@'접속위치';
ex. grant all privileges on testDB.* to 'user1'@'localhost';            
        //localhost 는 내부에서만 접속가능
     grant select on testDB.* to 'user1'@'%';

권한 확인
# show grants for 'user1'@'접속위치';

계정 삭제
# drop user '계정아이디'@'접속위치';
ex. drop user 'user1'@'%';

권한 삭제
# revoke all on DB이름.테이블 FROM '계정아이디'@'접속위치';

출처: https://sehoonoverflow.tistory.com/6 [세훈오버플로우]
```

## 패스워드 변경

```
방법 1: SET PASSWORD
SET PASSWORD FOR '아이디'@'%' = PASSWORD('패스워드');
방법 2: UPDATE & FLUSH
UPDATE mysql.user SET authentication_string=PASSWORD('패스워드') WHERE User='아이디' AND Host='%';
FLUSH PRIVILEGES;
UPDATE mysql.user SET Password=PASSWORD('패스워드') WHERE User='아이디' AND Host='%';
FLUSH PRIVILEGES;
방법 3: GRANT
GRANT USAGE ON *.* TO '아이디'@'%' IDENTIFIED BY '패스워드';
방법 4: mysqladmin
mysqladmin -u아이디 -p기존패스워드 password 신규패스워드
```