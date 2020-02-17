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

```mysql
/*
含义：
	出现在其他语句的select语句，称为子查询
	外部查询称为主查询或外查询
分类：
	按子查询出现的位置
		select后面
			支持（标量子查询）
		from后面
			支持表子查询
		where或having后面
			支持标量子查询 列子查询  行子查询
		exists后面（相关子查询）
			支持表子查询
	按结果集的行列数不同：
		标量子查询（结果集只有一行一列）
		列子查询（结构集自有一列多行）
		行子查询（结果集有一行多列）
		表子查询（结果集一般为多行多列）

*/
/*
一 、放在where或having后面
1、标量子查询（单行子查询）
2.列子查询（多行子查询）
3、行子查询（多行多列）

特点
1. 子查询一般放在小括号内
2. 子查询一般放在条件的右侧
3. 标量子查询一般搭配单行操作符 > ,<,=等

 4.列子查询一般搭配多行操作符使用  in ，any，some，all
*/

# 1. 标量子查询
# 谁的工资比Abel高
SELECT * 
FROM employees
WHERE salary > (
	SELECT salary
	FROM employees
	WHERE last_name = 'Abel'
);

# 返回job_id与141号员工相同，salary 比143号员工多的员工姓名，job_id和工资
SELECT last_name ,job_id,salary
FROM employees
WHERE job_id = (
		SELECT job_id 
		FROM employees
		WHERE employee_id = 141
)AND salary > (
		SELECT salary
		FROM employees
		WHERE employee_id = 143
);

#操作符的意思
# any |some 和子查询返回的某一个值比较
# all 和子查询返回的所有值比较

#2. 列子查询（多行子查询）
# 返回location_id 是1400或1700的部门的所有员工的姓名
SELECT last_name
FROM employees
WHERE department_id IN(
		SELECT DISTINCT department_id
		FROM departments
		WHERE location_id IN(1400,1700)
);

#3 . 行子查询（结果集一行或者多行）
#查询员工编号最小并且工资最高的员工信息
SELECT *
FROM employees
WHERE (employee_id,salary) = (
		SELECT MIN(employee_id),MAX(salary)
		FROM employees
);

# 二、select 后面
#查询每个部门的员工个数
SELECT d.*,(
		SELECT COUNT(*)
		FROM employees e
		WHERE e.department_id = d.department_id
)  个数
FROM departments d;

#三、from后面（将子查询的结果充当一张表要求必须起别名）
# 查询每个部门的平均工资等级

SELECT ag_dep.*,g.grade_level
FROM (
		SELECT AVG(salary) ag,department_id
		FROM employees
		GROUP BY department_id
)ag_dep
INNER JOIN job_grades g
ON ag_dep.ag BETWEEN lowest_sal AND highest_sal;

#四、exists子查询（相关子查询）
/*
	语法：
	 exists(完整的查询语句);
*/
#查询有员工的部门名
SELECT department_name
FROM departments d
WHERE EXISTS(
		SELECT *
		FROM employees e
		WHERE d.department_id = e.department_id
);

```

##### 分页查询

```mysql
/*
语法：
	select 查询列表
	from 表
	【join type join 表2
	on 连接条件
	where 筛选条件
	group by 分组字段
	having 分组后的筛选
	order by 排序字段
	limit offset，size】
	offset 起始索引（从0开始）
	szie   要显示的条数
*/

#查询前5条员工信息
SELECT * FROM employees LIMIT 0,5;
```

##### 联合查询

```mysql
/*
	union 联合 合并：将多条查询语句结果合并成一个结果
	
	语法:
		查询语句1
		union
		查询语句2
		union
		查询语句3
		......
	应用场景：
		要查询的结果来自与多个表，且多个表没有直接的连接关系，但查询的信息一般一致。
	
	特点：
		1. 要求多条查询的查询列数是一致的
		2. 要求多条查询语句的查询的每一列的类型和顺序最好一致
		3. union关键字默认去重，如果使用union all 可以包含重复项
*/
#查询部门编号>90 或邮箱包含a的员工信息
SELECT * FROM employees WHERE email LIKE  '%a%' OR department_id > 90;#不用联合查询

SELECT * FROM employees WHERE email LIKE '%a%'
UNION		#如果不想去重  加all										#用联合查询
SELECT * FROM employees WHERE department_id > 90;

```

#### DML语言

1. 数据操作语言
2. 插入 **insert** 。
3. 修改 **update** 。
4. 删除 **delete** 。

##### 插入语句

```mysql
/*

语法 一：支持插入多行，支持子查询
	insert into 表名(列名，....)values(值1,....);  
	
	1. 插入的值的类型要与列值兼容。
语法二	：不支持插入多行，不支持子查询
	insert into 表名
	set 列名=值，列名=值
*/
INSERT INTO beauty
SET id = 19,`name`='周水平',phone = '18872308870';

INSERT INTO beauty(id,`name`,phone)
SELECT 26,'宋希','11111111111';
```

##### 修改语句

```mysql
/*
1. 修改单表记录。
	
	语法：
		update 表名
		set 列=新值，列=新值，、、、、
		where 筛选条件
2. 修改多表记录。
	sq92语法：
		update 表1  别名,表2 别名
		set 列=值.....
		where 连接条件
		and 筛选条件;
		
	sq99语法：
		update 表1  别名
		inner|left|right  join 表2  别名
		on 连接条件
		set  列 = 值....
		where 筛选条件;
		

*/
```

##### 删除语句

```mysql
/*
	方式一：delete
	语法：
	1. 单表删除
	delete from 表名 where 筛选条件
	2.多表删除
	
	sq92语法
		delete  表1的别名，表2的别名
		from 表1 别名，表2 别名
		where 连接条件
		and 筛选条件
	
	sq99语法
		delete  表1的别名，表2的别名
		from 表1 别名
		inner | left | right join 表2  别名
		on 连接条件
		where 筛选条件
	
	方式二：turncate
	语法：
		turncate table 表名；清空数据
	
	turncat与delete比较
	1.turncat不支持where子句
	2.turn比delete高
	3.假如删除的表中有自增长列，
	如果用delete删除后，在插入数据，自增长列的值从断点开始，
	而turncat删除后在插入数据，自增张列从1开始
	4.turncat删除没有返回值，delete删除有返回值。
	5.turncate删除不能回滚，delete删除可以回滚。
*/
```

#### DDL语言

```mysql
/*
数据定义语言
库和表的管理

一、库的管理
创建、修改、删除
二、表的管理
创建、修改、删除

创建：create
修改：alter
删除：drop

*/
```

##### 库的管理

```mysql
/*
1.库的创建
语法：
create database 【if not exists】 库名；

更改字符集
	ALTER DATABASE 库名 CHARACTER SET 字符集;

库的删除
drop database 【if 农田exists】 库名；
*/
```

###### 库的表管理

````mysql
/*

1.表的创建

语法：

create table 表名(
	列名 列的类型 【（长度） 约束】，
	。。。
)
2 .表的修改
语法：
	alter table 表名 add | drop | modify | change  column  列名 【列类型 约束】；

修改列名  ALTER TABLE 表名  CHANGE COLUMN 旧列名  新列名 DATETIME;



*/
````

###### 表的删除

* **drop table  【if  not exists】 表名;** .

###### 表的复制

```mysql
#仅仅复制表的结果
CREATE TABLE 表名 LIKE 被复制的表名;
#复制表的结构和数据
CREATE TABLE 表名
SELECT * FROM 要复制的表名;
```

###### 常见的数据类型

1. 数值型
   1. 整形
   2. 小数形
      1. 定点数
      2. 浮点数
2. 字符型
   1. 较短的文本：char ，varchar
   2. 较长的文本：text，blob(较长的二进制数据)
3. 日期型

```mysql
#整型
#分类
tinyint, smallint,mediumint ,int / integer, bigint #保存的数据越来越大

#小数
#1.浮点型
float(M,D) double(M,D)
#定点型
dec(M,D)  decimal(M,D)

#特点
1. M :小数不为 + 整数部位
   D ：小数部位
2.M D都可以省略
如果是 decimal 。则 M 默认为 10，D 默认为 0
如果是 float 和 double ，则会根据插入的数值的精度来决定精度

3. 定点型的精确度高，若干要求插入的数值的精度较高如货币运算等则考虑使用

#字符型
	
char  char(M)  M是最大字符数，M可以省略，默认为1，固定长度  比较耗费空间  效率高   

varchar varchar(M) M不可省略 ，可变字符长度  比较节省空间  效率低

```

###### 常见约束

1. **NOT NULL** :非空，用于保证该字段的值不能为空。

2. **DEFAULT**  : 默认约束，用于保证该字段有默认值。

3. **PRIMARY KEY**: 主键约束，用于保证该字段具有唯一性，并且非空。

4. **UNIQUE** : 唯一，用于保证该字段的值具有唯一性，可以为空。

5. **CHECK** : 检查约束【mysql不支持】。

6. **FOREIGN KEY** :外键约束，用于限制两个表的关系，用于保证该字段的值必须来自于主表的关联列的值，在从表添加外键约束，用于引用主表中某列的值。

7. 约束添加分类

   1. 列级约束

      ​	六大约束语法上都支持，但外键约束没有效果。

   2. 表级约束

      ​	除了非空约束、默认，其他的都支持。

   **CREATE TABLE 表名(**

   ​	字段名 字段类型  列级约束,

   ​	表级约束

   **)**

****









