#### 数据库的概念

1. **DB** 数据库(database):存储数据的“仓库” 。它保存了一系列有组织的数据。
2. **DBMS** :数据库管理系统(Database Management System)。数据库是通过DBMS创建和操作的容器。
3. **SQL** 结构化查询语言(Structure Query Language),专门用来与数据库通信的语言。

##### SQL的优点

1. 不是某个特定的数据库供应商专有的语言，几乎所有的DBMS都支持SQL。
2. 简单易学。
3. 虽然简单，但实际上是一种强有力的语言，灵活使用其语言元素，可以进行非常复杂和高级的操作。

##### DBMS分为两类

* 基于共享文件系统的DBMS(Access)
* 基于客户机------服务器的DBMS(Mysql Oracle...)

##### mysql服务的启动和关闭和连接

* net start mysql 启动
* net stop  mysql 关闭
* mysql  -h localhost  -P 3306  -u root  -p 123456

##### mysql的基础命令

1.  **show databases;**   显示所有数据库。
2. **use test;** 使用test数据库。
3. **show tables** 显示所有的表。
4. **show tables from mysql;** 显示mysql所有的表。
5. **create table  stu(int id,varchar(20)  name );** 创建数据库。
6. **desc  stu;** 显示stu 数据库的详细信息。
7. **select  vesion();** 查看数据库的版本。
8. **mysql   -V;** 没登录时查看版本。

##### mysql语法规范

1. 不区分大小写，但建议关键字大写，表名 列名小写。
2. 每条命令最好用分号结尾。
3. 每条命令根据需要，可以进行缩进和换行。

##### 注释

1. 当行注释：# 文字
2. 单行注释：- - 文字
3. 多行注释 ：/* 文字 */

#### DQL(database query language)

##### 基础查询

1. 语法  select  查询列表  from  表名；

2. 查询列表可以是 ： 表中的字段、常量值、表达式、函数。

3. 查询结果是一个虚拟的表格。
4. 查询单个字段  **select  last_name from  employee;** 
5. 查询多个字段：**select  last_name,salary,email from employee;** 
6. 查询常量值  SELECT  100;
7. 查询表达式  SELECT 100%98;
8. 查询函数  SELECT  VERSION();
9. 起别名 **SELECT  100%98  AS  结果** 。
10. 



