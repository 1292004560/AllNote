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
10. 去重 **SELECT DISTINCT department_id FROM employees;**
11. mysql中的加号只能作为运算符。
12. **SELLECT 100 + 90;** 两个都是数值型，则两个数字相加。
13. **SELECT  '123' + 10;** 其中一方是数值型，则进行转化，转化成功继续做加法运算，转化失败为0。如果有其中一方为 **null** 则结果为 **null** 。
14. **SELECT CONCAT(last_name,first_name)  AS 姓名 FROM employees;** 拼接字符串。
15. **SELECT IFNULL(可能为null的表达式,如果为null返回结果) FROM employees;** 。

##### 条件查询

1. 语法 ：**select 查询列表  from 表名  where  筛选条件;** 。
2. 运算符 条件运算符 ** >  <  !=   <>** 。
3. 模糊查询 **like   , between  and , in, is null ** 。
4. 逻辑运算符  **and , or ,not** 。
5. **like 一般与通配符连用** 。
6. **% 任意多个字符** 。
7. **_任意单个字符** 。
8. **\ 用来转义   escape  也用来转义**  。
9. **SELECT last_name FROM employees  WHERE last_name LIKE '_$_%' ESCAPE '$';**
10. **SELECT * FROM employees WHEREemployee_id BETWEEN 100 AND 120;**
11. 查询工种编号是IT_PRIO、AD_VP、其中的员工名和工种编号 **SELECT  last_name ,job_id FROM employees WHERE job_id  IN('IT_PROT','AD_VP');** 。
12. **in 里面不能用通配符** 。
13. 查询没有奖金的员工名和奖金率 **SELECT last_name,commission_pct FROM employees WHERE  commission_pct IS NULL;** 。
14. 安全等于  **<=>** 可以用来判断null值。
15. **SELECT last_name,commission_pct
    FROM employees WHERE commission_pct <=> NULL; ** 

##### 排序查询

1. 语法 **select  查询列表 from 表名  where 筛选条件  order  by 排序列表   asc |  desc;** 。
2. 查询员工工资从高到低 **SELECT * FROM employees ORDER BY salary DESC;** 。
3. 查询部门编号>= 90的员工信息，按入职时间进行排序 **SELECT * FROM employees WHERE department_id >= 10 ORDER BY hiredate ASC;** 。
4. 按姓名字符串的长度排序 **SELECT LENGTH(last_name) 字节长度 ,last_name ,salary FROM employees ORDER BY LENGTH(last_name) DESC;** 。
5. 多字段排序 **SELECT * FROM employees ORDER BY salary ASC ,employee_id DESC;** 。
6. order by  可以支持单个字段 、多个字段、表达式、函数、别名。
7. order by 子句一般放在查询语句的最好面 **除了limit 子句** 。

##### 常见函数的学习

1. 调用  **select  函数名(实参列表)  from  表名;** 
2. 单行函数如 **concat ，length ，ifnull** 。
3. 分组函数   做统计使用 。

###### 字符函数  length

1. 查询字符串长度  **select LENGTH('join')** 。
2. 注意  是获取字节的个数。

###### 字符串拼接函数concat

1. 拼接字符串函数
2. **SELECT CONCAT(last_name,'_',first_name)  姓名 FROM  employees;** 。

###### 大小写转换函数

1. upper
2. lower

###### 字符串截断函数

1. substr
2. 注意索引从一开始。
3. 注意截取从指定的 **字符长度** 的字符。
4. 查询姓名中首字母大写，其他字符小写用 _凭借显示出来 
5. **SELECT CONCAT(UPPER(SUBSTR(last_name,1,1)),'_', LOWER(SUBSTR(last_name,2)) ) out_put FROM employees;** 。
6. **instr** 返回子串第一次出现的索引，如果找不到返回 0。

###### trim函数

* 去掉前后空格空格
* 去掉字符a **SELECT  TRIM('a' FROM '你好 aa');** 。

###### lpad用指定字符左填充字符

###### rpad用指定字符右填充

###### replace 替换

##### 数学函数

###### round四舍五入

###### ceil向上取整

1. **SELECT  CEIL(1.02)**

###### floor 向下取整

###### turncat截断

1. **SELECT TRUNCATE(1.89,1);** 保留一位小数 。

###### mod(a,b)取余。

##### 日期函数

###### now() 返回当前系统日期加时间

###### curdata() 返回但钱系统日期，不包含时间





