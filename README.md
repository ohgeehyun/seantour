# 지오씨엔아이 해양레저 프로젝트 - 바다여행


## LTS코리아 CMS(jnit cms) 기본 설정
### 1. 권장 Jdk, Tomcat, DB(MySQL) 버전
* **jdk** : 1.7
* **tomcat** : 7
* **MySQL** : 5.1


### 2. 필수 작성 및 확인 목록
> **resources/egovframework/egovProps/globals.properties** 파일을 열어 아래 부분을 수정한다

* 운영서버 타입(WINDOWS, LINUX, UNIX)
  ```
  Globals.OsType =
  ```

* DB서버 타입(mysql, cubrid, oracle) - datasource 및 sqlMap 파일 지정에 사용됨
  ```
  Globals.DbType =
  ```

* 위저드 사용시 데이터베이스 관련 설정을 불러옴
  ```
  #mysql
  Globals.DriverClassName=com.mysql.jdbc.Driver
  Globals.Url=jdbc:mysql://[IP]:[PORT]/[SID]?useUnicode=true&characterEncoding=utf8
  ```
  ```
  #DB계정 ID/PW설정
  Globals.UserName =[id]
  Globals.Password =[pw]
  ```
 
* 파일 업로드 경로(경로 설정은 반드시 절대경로를 사용해야함, 경로 뒤에 /를 붙여 주어야함.)
  ```
  Globals.fileStorePath =C:/egov/upload/
  ```

* cms 대용량 파일 업로드 경로(경로 설정은 반드시 절대경로를 사용해야함, 경로 뒤에 /를 붙여 주어야함.)
  ```
  Globals.upload.dir =C:/egov/upload/
  ```
 
* 관리자 접근레벨 설정 Property File Path
  ```
  Webadm.Properties =C:\egov\workspace\jnitcms\src\main\webapp\webadm.properties
  ```
 
### 3. MYSQL 환경설정
#### 테이블 대,소문자를 구분 하지 않는 설정 필요
* 파일 : **my.cnf**
* 설명 : [mysqld] 영역에 **lower_case_table_names = 1**  추가
* 내용(example)
  ```
  [mysqld]
  lower_case_table_names = 1
  ```

### 4. DDL과 DML을 이용한 테이블 생성 및 기본 데이터 Insert
  * **/resources/jnit/ddl/mysql/jnit_mysql_table.ddl** : 테이블 생성
  * **/resources/jnit/ddl/mysql/jnit_mysql_data.ddl** : 데이터 추가

