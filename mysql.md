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

###### curdata() 返回系统日期，但不包含时间

###### YEAR()返回年份

1. **SELECT YEAR(now());**

###### MONTH()返回月份

###### STR_TO_DATA将字符通过指定的格式转换成日期

1. ```mysql
   SELECT STR_TO_DATA('1998-3-2', ' %Y-%c-%d') AS out_put;
   ```

###### data_format将日期转换为字符

##### 其他函数

###### version();

###### database();

###### user();

##### 流程控制函数

###### if函数

1. if   else效果
2. **SELECT IF(10>5,'大','小');** 。

###### case函数

1. switch case效果。

2. 语法 。

3. ```mysql
   case  要判断的字段或表达式
   
   when  常量1  then  要显示的值1或语句1
   
   when  常量2   then  要显示的值2或语句2
   
   ....
   
   else 要显示的值n或语句n
   
   end
   ```

4. 可以当表达式和语句使用。

5. ```mysql
   SELECT salary 原始工资,department_id,
   CASE department_id
   	WHEN 30 THEN salary*1.1
   ELSE salary
   END  AS 新工资
   FROM employees;
   ```

6. ```mysql
   # case 其用法
   case  
   when  条件1  then  要显示的值或语句1
   when  条件2  then  要显示的值2或语句2
   ...
   else  要显示的值n或语句n
   end
   ```

##### 分组函数

1. 用于统计使用，又称聚合函数或统计函数。
2. sum求和。
3. avg平均值。
4. max最大值。
5. min最小值。
6. count计算个数。

```mysql
SELECT SUM(salary) 和 ,AVG(salary) 平均值 FROM employees;

#分组函数都忽略null值


#分组函数和distinct搭配使用

#去掉重复工资  并计数
SELECT COUNT(DISTINCT salary) FROM employees;

```

###### count函数

```mysql
SELECT COUNT(*) FROM employees;

SELECT COUNT(1) FROM employess;
#效率
MYISAM  存储引擎下,count(*)的效率高
INNODB  存储引擎下 ,count(1)和 count(*)差不多
```

##### 分组查询

```mysql
语法：
select  分组函数 ，列(要求出现在 group by 的后面) 
from 表
where 筛选条件
group by 分组列表
order by 子句

#注意查询列表比较特殊，要求分组函数和 group by 后出现的字段

#查询每个工种的最高工资
SELECT MAX(salary) ,job_id
FROM  employees
GROUP BY job_id;)；

#分组前的筛选
#查询邮箱中包含a字符的每个部门的平均工资
SELECT AVG(salary),department_id
FROM employees
WHERE email LIKE '%a%'
GROUP BY department_id;

#分组后筛选
#查询那个部门的员工数大于2
SELECT COUNT(*),department_id
FROM employees
GROUP BY department_id
HAVING COUNT(*)>0;

#查询每个工种有奖金的员工的最高工资>12000的工种编号和最高工资
SELECT MAX(salary),job_id
FROM employees
WHERE  commission_pct IS NOT NULL 
GROUP BY job_id
HAVING MAX(salary) > 12000;

#注意 where子句后面的条件一定式from表里面有的字段
#原始表就是可以筛选的字段放在where子句后面，分组后的结果集筛选的字段放在having子句后面

#一般分组函数做条件肯定放在having子句后面

#按多个字段进行分组
#查询每个部门每个工种的平均工资
SELECT AVG(salary),department_id,job_id
FROM employees
GROUP BY department_id,job_id;

```

##### 连接查询

```mysql
/*
含义：又称多表查询

笛卡尔乘积现象：表1有m行，表2有n行，结果  = m * n行

分类：
		按年代分类：
			sq192标准 :mysql中仅仅支持内连接
			sq199标准【推荐】：mysql中支持内连接+外连接(左外和右外) + 交叉连接
		
		按功能分类：
			内链接：
				等值连接
				非等值连接
				自连接
			
			外连接
				左外连接
				右外连接
				全外连接
			交叉连接
*/

# 一 、sq192标准
#等值连接

1. n表连接最少需要n-1个链接条件

#查询员工名对应的部门名
SELECT last_name ,department_name
FROM employees,departments
WHERE employees.department_id = departments.department_id;

#注意   如果为表起了别名，则查询的字段就不能用原来的表名去限定

# 加筛选

# 查询有奖金的员工名、部门名
SELECT last_name,department_name
FROM employees  e ,departments d
WHERE e.department_id = d.department_id
AND e.commission_pct IS NOT NULL;

#查询员工名、部门名和所在的城市
SELECT last_name,department_name ,city
FROM employees e,departments d,locations l
WHERE e.department_id = d.department_id
AND d.location_id = l.location_id;

# 2.非等值连接
# 查询员工的工资的工资级别
SELECT salary,grade_level
	FROM employees e,job_grades g
	WHERE salary BETWEEN g.lowest_sal AND g.highest_sal;
	
# 3 .自连接
# 查询 员工名  和上级名称
SELECT e.employee_id,e.last_name,m.employee_id,m.last_name
	FROM employees e,employees m
	WHERE e.manager_id = m.employee_id;
	

#sq99语法

/*

语法：
	select 查询列表
	from 表1 别名 【连接类型】
	join 表2 别名  
	on 连接条件
	【where 筛选条件】
	【group by 分组】
	【having 筛选条件】
	【order by 子句】
	
连接类型
	内链接 ：inner
	外连接
		左外 ：left 【outer】
		右外 ：right 【outer】
		全外 ：full  【outer】
    交叉连接 ：cross
*/

/*
内连接语法：

select 查询列表
from 表1 别名
inner join 表2 别名
on 连接条件

分类：
 	等值
 	非等值
 	自连接
*/
#查询员工名和部门名
SELECT last_name,department_name
FROM departments d 
INNER JOIN employees e
ON e.department_id = d.department_id;

#查询名字中包含e的员工名和工种名（添加筛选）
SELECT last_name,job_title
FROM employees e
INNER JOIN jobs j
ON e.job_id = j.job_id
WHERE e.last_name LIKE '%e%';

#查询哪个部门的员工个数>3的部门名和员工个数，并按个数排序
SELECT COUNT(*),department_name
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id
GROUP BY department_name
HAVING COUNT(*) > 3
ORDER BY COUNT(*) DESC;
#inner是可以省略

#等值连接
#查询员工的工资级别

SELECT salary ,grade_level
FROM employees e
JOIN job_grades g
ON e.salary BETWEEN g.lowest_sal AND g.highest_sal;

#自连接
#查询员工的名字、上级的名字
SELECT e.last_name,m.last_name
FROM employees e
JOIN employees m
ON e.manager_id = m.employee_id;

/*
二 、外连接

应用场景：用于查询一个表中有，另一个表没有的记录

特点：
	1.外连接结果为主表的所有记录
		如果从表中有和它匹配的则显示匹配的值
		如果从表中没有和它匹配的则显示null
		外连接的查询结果 = 内连接查询结果 + 主表中有而从表中没有的数据
	2.  左外连接，left join 左边的是主表
		右外连接，right join 右边的是主表
	3. 左外和右外交换两个表的顺序，可以实现同样的效果
	4. 全外连接 = 内链接的结果+表1中有但表二没有的 + 表2中有表1没有的（mysql不支持）
*/

#查询哪个部门没有员工
SELECT d.*,e.employee_id
FROM departments d
LEFT OUTER JOIN employees e
ON d.department_id = e.department_id
WHERE e.employee_id IS NULL;

/*
三 、交叉连接
	就是笛卡尔集
*/
```

##### 子查询











