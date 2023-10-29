```shell
groupadd -g 701 postgres
useradd -g 701 -u 701 -s /bin/bash -m postgres

vim .bashrc
export PATH=/usr/pgsql-12/bin:$PATH
export LD_LIBRARY_PATH=/usr/pgsql-12/lib:$LD_LIBRARY_PATH
export PGDATA=/home/postgres/pgdata
export PGHOST=/tmp

pg_ctl -D /home/postgres/pgdata -l logfile start

unix_socket_directories = '/tmp'
```

```sql
CREATE TABLE score (
student_name varchar(40),
chinese_score int,
math_score int,
test_date date
);

CREATE TABLE student(no int primary key, student_name varchar(40), age int);

INSERT INTO class VALUES(1,'初二(1)班');


CREATE TABLE student(no int primary key, student_name varchar(40), age int, class_no int);

INSERT INTO student VALUES(1, '张三', 14, 1);
INSERT INTO student VALUES(2, '吴二', 15, 1);
INSERT INTO student VALUES(3, '李四', 13, 2);
INSERT INTO student VALUES(4, '吴三', 15, 2);
INSERT INTO student VALUES(5, '王二', 15, 3);
INSERT INTO student VALUES(5, '王二', 15, 3);
INSERT INTO student VALUES(6, '李三', 14, 3);
INSERT INTO student VALUES(7, '吴二', 15, 4);
INSERT INTO student VALUES(8, '张四', 14, 4);



```

```sql
子查询

  当一个查询是另一个查询的条件时，称之为子查询。主要有4种语法的子查询：

  ·带有谓词IN的子查询：expression [NOT] IN (sqlstatement)。

  ·带有EXISTS谓词的子查询：[NOT] EXISTS (sqlstatement)。

  ·带有比较运算符的子查询：comparison(>,<,=,!=)(sqlstatement)。

  ·带有ANY（SOME）或ALL谓词的子查询：comparison [ANY|ALL|SOME] (sqlstatement)。

SELECT * FROM student WHERE class_no in (select no FROM class where class_name = '初二(1)班');

SELECT * FROM student s WHERE EXISTS (SELECT 1 FROM class c WHERE s.class_no=c.no AND c.class_name = '初二(1)班');

SELECT * FROM student WHERE class_no = (SELECT no FROM class c WHERE class_name = '初二(1)班');

SELECT no, class_name, (SELECT max(age) as max_age FROM student s WHERE s.no= c.no) as max_age FROM class c;

SELECT * FROM student WHERE class_no = any(SELECT no FROM class c WHERE class_name in ('初二(1)班', '初二(2)班'));


CREATE TABLE student_bak(no int primary key, student_name varchar(40), age int, class_no int);

INSERT INTO student_bak SELECT * FROM student;

```

```
使用“psql -l”命令可以查看数据库

[postgres@localhost ~]$ psql -l
                              List of databases
   Name    |  Owner   | Encoding | Collate |  Ctype  |   Access privileges
-----------+----------+----------+---------+---------+-----------------------
 postgres  | postgres | UTF8     | C.UTF-8 | C.UTF-8 |
 template0 | postgres | UTF8     | C.UTF-8 | C.UTF-8 | =c/postgres          +
           |          |          |         |         | postgres=CTc/postgres
 template1 | postgres | UTF8     | C.UTF-8 | C.UTF-8 | =c/postgres          +
           |          |          |         |         | postgres=CTc/postgres
(3 rows)
```

```
create table t(id int primary key,name varchar(40));

postgres=# CREATE DATABASE testdb;
CREATE DATABASE
postgres=# \c testdb;
You are now connected to database "testdb" as user "postgres".
testdb=#
```

```
CREATE TYPE person AS (
  name   text,
  age    integer,
sex    boolean
);
CREATE TABLE author(
id int,
person_info person,
book         text
);
insert into author values( 1, '("张三",29,TRUE)', '张三的自传');

insert into author values( 2, '("张三",,TRUE)', '张三的自传');


CREATE TYPE inetrange AS RANGE (subtype = inet);
CREATE TABLE ipdb2(
  ip_range inetrange, 
  area text, 
  sp text);
insert into ipdb2 select ('[' || ip_begin || ',' || ip_end || ']') ::inetrange, area, sp from ipdb1;

```

```sql
CREATE TABLE persons (
  name varchar(40),
  age int CHECK (age >= 0 and age <=150),
  sex boolean
);
CREATE TABLE persons (
  name varchar(40),
  age int CONSTRAINT check_age CHECK (age >= 0 and age <=150),
  sex boolean
);

CREATE TABLE books (
  book_no integer,
  name text,
  price numeric CHECK (price > 0),
  discounted_price numeric CHECK (discounted_price > 0),
  CHECK (price > discounted_price)
);

CREATE TABLE class(
      class_no int primary key, 
      class_name varchar(40)
);
CREATE TABLE student(
      student_no int primary key, 
      student_name varchar(40), 
      age int, 
      class_no int REFERENCES class(class_no)
);

ALTER TABLE class ADD COLUMN class_teacher varchar(40);

```

