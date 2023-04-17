
# MariaDB Docker 세팅 

## 컨테이너 실행 명령어  
docker run --name mariadb -d -p 3307:3306 --restart=always -e MYSQL_ROOT_PASSWORD=root mariadb
(포트가 꼬일지도몰라서 3307포트로 변경함)

## DB 사용자 생성
CREATE USER 'sy'@'%' IDENTIFIED BY '1030';

## baseball 데이터베이스 권한 부여 
GRANT ALL PRIVILEGES ON baseball.* TO 'sy'@'%';

## 새로고침 
FLUSH PRIVILEGES;

## 정보확인 
select User, Host from mysql.user;