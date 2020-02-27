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
* mysql  -h localhost  -P 3306  -u root  -p123456

##### mysql的基础命令

1.  **show databases;**   显示所有数据库。
2.  **use test;** 使用test数据库。
3.  **show tables** 显示所有的表。
4.  **show tables from mysql;** 显示mysql所有的表。
5.  **create table  stu(int id,varchar(20)  name );** 创建数据库。
6.  **desc  stu;** 显示stu 数据库的详细信息。
7.  **select  vesion();** 查看数据库的版本。
8.  **mysql   -V;** 没登录时查看版本。
9.  **show index from 表名;** 查看此表中所有的索引。
10.  **select @@tx_isolation** 查看事务隔离级别。
11.  **set session transaction isolation level read  uncommitted ** 设置事务隔离级别 未 **读未提交数据** 
12.  **set global transaction isolation level read  uncommitted**  设置全局隔离级别。

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

   表级约束语法

   ​	【constraint  约束名】 约束字段(字段名);

****

###### 主键与唯一对比

|      | 保证唯一性 |     是否允许为空     | 一个表可以有多个 |  是否允许组合  |
| :--: | :--------: | :------------------: | :--------------: | :------------: |
| 主键 |     是     |          否          |     最多一个     | 是(不推荐组合) |
| 唯一 |     是     | 是(只能允许一个为空) |     可以多个     | 是(不推荐组合) |

###### 外键的特点

1. 要求在从表中设置外键关系。
2. 从表的外键列的类型和主表的关联列的类型要求一致或兼容，名称无要求。
3. 主表的关联列必须是一个key(一般是主键或唯一)。
4. 插入数据时，先插入主表，再插入从表。
5. 删除数据时，先删从表数据，再删主表数据。

###### 标识列

1. 又称自增长列。

2. 可以不用手动的插入值，系统提供默认的序列值。

3. 特点：

   1. 标识列必须与主键搭配吗？不一定，但要求是一个key。
   2. 一个表最多有一个标识列。
   3. 标识列只能是数值型。
   4. 标识列可以通过 **SET auto_increment_increment = 3;** 设置步长。
   5. 可以手动插入值，设置起始值。

   ****


#### TCL语言

1. Transaction  Control  Language 事务控制语言。
2. 一个或一组sql语句组成一个执行单元，这个执行 要全部成功，要么全不失败。
3. 事务的特性(ACID)。
   1. 原子性(Atomicity)。
   2. 一致性(Consistency)。
   3. 隔离性(Isolation):各事务执行不能相互干扰，通过隔离级别控制。
   4. 持久性(Durability)。

*******************************

##### 事务的创建

1. 隐式事务：事务没有明显的开始结束标记，比如：insert ，update，delete语句。
2. 显示事务：事务具有明显的开始和结束的标记。
   1. 前提：必须先设置自动提交功能为禁用。
   2. **set autocommit = 0** 。

```mysql
#步骤1：开启事务
set autocommit = 0;
start transaction; #可选
#步骤2：(编写sql语句 select，insert ，update，delete)
#(可以多条sql语句)
#步骤3：结束事务
commit;#提交事务
（ rollback );#回滚事务
（ savepoint name);#设置保存点

#事务执行时  turncate 不支持回滚
```

##### 数据库的隔离级别

* 对于同时运行多个事务，当这些事务访问 **数据中相同的数据** 时，如果没有采取必要的隔离机制，就会导致各种并发问题。
  1. **脏读** ：对于两个事务T1、T2，T1读取了已经被T2更新但还 **没有被提交** 的字段之后，若T2回滚，T1读取的内容就是临时无效。
  2. **不可重复读** ：对于两个事务T1、T2，T1读取了一个字段，然后T2 **更新** 了该字段之后，T1再次读取同一个字段，值就不同了。
  3. **幻读** ：对于两个事务 T1、T2，T1从一个表中读取了一个字段，然后T2在该表中 **插入** 了一些新的行之后，如果T1再次读取同一个表，就会多出几行。
* MySQL数据库提供四种隔离级别。

| 隔离级别                           |                             描述                             |
| ---------------------------------- | :----------------------------------------------------------: |
| READ UNCOMMITTED (读未提交数据)    | 允许事务读取未被其他事务提交的变更，脏读，不可重复读和幻读的问题都会出现 |
| READ COMMITTED(读已提交的数据)     | 值允许事务读取已经被其他事务提交的变更，可以避免脏读，但不课重复读和幻读的问题仍然可能出现 |
| REPEATABLE READ(可重复读 **默认**) | 确保事务可以多次从一个字段中读取相同的值，在这个事务持续期间，禁止其他事务对这个字段更新，可以避免脏读和不可重复读，但幻读的问题仍然存在 |
| SERIALIZABLE(串行化)               | 确保事务可以从一个表中读取相同的行，在这个事务事务持续期间，禁止其他事务对该表执行插入，更新和删除，所有并发问题都可以避免，但是性能十分低下 |

***

#### 视图

```mysql
# 一、创建视图
/*
语法：
	create view 视图名
	as
	查询语句;
*/

#创建一个包含部门名，员工名，和工种信息的视图
CREATE VIEW my_view
AS
SELECT last_name,department_name,job_title
FROM employees e
JOIN departments d ON  e.department_id = d.department_id
JOIN jobs j  ON j.job_id = e.job_id;

#使用视图
SELECT * FROM my_view;

# 视图的好处
/*
1. 重用sql语句
2. 简化复杂的sql操作，不必知道它的查询细节
3. 保护数据，提高安全性
*/

#二、视图的修改

#方式一
/*
create  or replace view 视图名
as
查询语句；
*/

#方式二
/*
语法：
alter view 视图名
as 
查询语句；
*/

#三、删除视图
/*
语法：
	drop  view  视图名、视图2；
*/

#四、查看视图
#desc  视图名；或  show  create  view  视图名；
```

##### 视图的更新

1. 可以对视图进行增删改操作，和对表的增删改的操作语法一致。
2. 具备以下关键字的视图不允许更新操作。
   1. sql语句包含分组函数、distinct 、group by、having，union、union all
   2. 常量视图。
   3. select包含子查询。
   4. 有join的sql语句。
   5. from一个不能更新的视图。
   6. where 子句的子查询引用了from子句的表。

##### 视图和表对比

|      |    创建语法    |    是否占用物理空间     |           使用           |
| :--: | :------------: | :---------------------: | :----------------------: |
| 视图 |  create  view  | 只是保存了sql语句的逻辑 | 增删改查，一般不能增删改 |
|  表  | create   table |       保存了数据        |         增删改查         |

****

#### 变量

1. 系统变量。
   1. 全局变量。
   2. 会话变量。
2. 自定义变量。
   1. 用户变量。
   2. 局部变量。

##### 系统变量

1. 说明：变量有系统提供，不是用户自定义，属于服务器层面。
2. 使用语法。
   1. 查看所有系统变量 **show  global 【seesion】variables;** 。
   2. 查看满足条件的部分系统变量 **show  global 【seesion】variables  like ‘%char%’;** 。
   3. 查看某个指定的系统变量 **select  @@global |【session】.系统变量名;** 。
   4. 为某个系统变量赋值 。
      1. **select global |【session】 系统变量名 = 值;**
      2. **set @@global | 【session 】系统变量名 = 值;**
   5. 注意：如果是全局级别，则需要加global，如果是会话级别，可加session可不写。
3. 作用域：服务器每次启动将为所有的全局变量赋初始值，针对于所有的会话(连接)有效，但不能跨重启。

##### 自定义变量

###### 用户变量

1. 作用域：针对于当前会话(连接)有效，同于会话变量的作用域。
2. 使用
   1. 声明并初始化
      1. **set @用户变量名 = 值;**
      2. **set  @用户变量名 := 值;**
      3. **select  @用户变量名 = 值;** 
   2. 赋值(更新用户变量的值)
      1. 方式一: 通过 **select** 或 **set** 
      2. 方式二 : **select  字段  into   变量名 from  表**
3. 应用在任何地方 ，可以应用在begin  end 里面。



###### 局部变量

1. 作用域 ： 仅仅在定义它的begin  end 中有效。
2. 声明
   1. **declare  变量名  类型**
   2. **declare 变量名  类型 default 值**
3. 赋值
   1. **set 局部变量名 = 值;**
   2. **set   局部变量名 := 值;**
   3. **select  @ 局部变量名 = 值;** 
   4. **select  字段  into   变量名 from  表**

###### 用户变量和局部变量对比

|          | 作用域       | 定义和使用位置                    | 语法                                            |
| -------- | ------------ | --------------------------------- | ----------------------------------------------- |
| 用户变量 | 当前会话     | 会话中的任何地方                  | 必须加@符号，不用加限定类型                     |
| 局部变量 | BEGIN END 中 | 只能在begin  end 中，且为第一句话 | 一般不加@符号(selec 赋值时要加)，需要加限定类型 |

***

#### 存储过程和函数

1. 存储过程和函数：类似于Java中的方法。
2. 好处。
   1. 提高代码的重用性。
   2. 简化操作。

##### 存储过程

1. 含义：一组预先编译好的SQL语句，理解成批处理语句。
2. 好处。
   1. 提高代码的重用性。
   2. 简化操作。
   3. 减少了编译次数并且减少了和数据库服务器连接的次数，提高了效率。

```mysql
#一、创建语法
CREATE PROCEDURE  存储过程名(参数列表)
BEGIN
			存储过程体(一组合法的SQL语句)
		
END

/*
注意：
	1.参数列表包含三部分
	参数模式   参数名   参数类型
	
	举例 
	IN  name  VARCHAR(20)
	参数模式
	IN：该参数可以作为输入，也就是该参数需要调用方传入值
	OUT：该参数可以作为输出，也就是该参数可以作为返回值
	INOUT：该参数既可以作为输入又可以作为输出，也就是该参数即需要传入值，又可以返回值
	
	2. 如果存储过程体仅仅只有一句话，begin end 可以省略
	存储过程中每条SQL语句的结尾要求必须加分号。
	存储过程的结尾可以使用 delimiter 重新设置
	
	语法：
	delimiter 结束标记
	案例
	delimiter  $
	
	
调用语法:
call  存储过程名(实参列表);
*/

#IN模式参数存储过程
CREATE PROCEDURE mp(IN username VARCHAR(20), IN password  VARCHAR(20))
BEGIN
					DECLARE result  INT  DEFAULT 0; #声明并初始化
					SELECT COUNT(*) INTO result #赋值
					FROM admin 
					WHERE admin.username = username
					AND  admin.`password` = password;
					
					SELECT IF(result > 0,'成功','失败');#使用
END 

#OUT模式参数存储过程

CREATE PROCEDURE my(IN beautyName VARCHAR(20),OUT boyName VARCHAR(20))
BEGIN
					SELECT bo.boyName INTO boyName
					FROM boys bo
					INNER JOIN beauty b ON bo.id = b.boyfriend_id
					WHERE b.`name` = beautyName;
END
#调用
CALL my('小昭',@bname);
SELECT @bname;

#二、删除存储过程
#语法 ： drop  procedure  存储过程名;  存储过程一次只能删一个

#三、查看存储过程
SHOW CREATE PROCEDURE  存储过程名;

```

*****



##### 函数

1. 与存储过程的区别
   1. 存储过程可以有0个返回，也可以有多个返回 ，适合做批量插入，批量更新。
   2. 函数：有且仅有一个返回 ，适合做处理数据后返回一个结果。

```mysql
#一、创建语法
CREATE FUNCTION 函数名(参数名列表)  RETURNS  返回类型
BEGIN
	函数体
END
/*
注意：
	1. 参数列表包含两部分  参数名  参护士类型。
	2. 函数体：肯定会员 return语句，如果没有会报错。
	   如果return语句没有放在函数体的最后也不报错，但不建议。
	3. 函数体中仅有一句话，则可以省略begin  end。
	4. 使用 delimiter 语句设置结束标记。
*/

#二、调用语法
SELECT 函数名(参数列表)

#案例
delimiter $
CREATE  FUNCTION myf1()  RETURNS  INT
BEGIN
				DECLARE c INT DEFAULT 0;#定义变量
				SELECT COUNT(*) INTO c #赋值
				FROM employees ;
				RETURN c;
END $

#三、查看函数
SHOW CREATE FUNCTION 函数名;
#四、删除函数
DROP FUNCTION 函数名;
```

#### 流程控制结构

##### case结构

```mysql
#情况一：类似于Java中的switch语句，一般用于实现等值判断
#语法：
		case  变量 | 表达式 | 字段
		when  要判断的值1  then  返回的值1或语句1
		when  要判断的值2  then  返回的值2或语句2
		...
		else 要返回的值n
		end
#情况一：类似于Java中的多重if语句，一般用于实现区间判断
#语法：
		case 
        when  要判断的条件1  then  返回的值1或语句1
        when  要判断的条件2  then  返回的值2或语句2
        ....
        else  要返回的值n
        end  case;
        
   /*
   特点：
   		1.可以作为表达式，嵌套在其他语句中使用，可以放在任何地方，begin  and 中 或 begin 			and	外面。
   		可以作为独立的语句使用只能放在 begin and中。
   		2.如果when 中的值满足或条件成立，则执行对应的then 后面的语句，并且结束case。
   		3.else 可以省略	，如果else省略了，并且所有的when条件都不满足，则返回null。
   */
```

##### if结构

```mysql
/*
功能 ： 实现多重分支。
语法：
	if      条件1 then 语句1;
	elseif 	条件2 then 语句2;
	....
	【else  语句n】;
	end if;
只能反正begin end 中
*/

CREATE FUNCTION test_if(`score` INT) RETURNS CHAR
BEGIN 
				IF  `score` >= 90  AND `score` <= 100 THEN  RETURN 'A';
        ELSEIF  `score`  >= 80  THEN  RETURN  'B';
				ELSEIF  `score`  >= 60  THEN  RETURN 'C';
				ELSE  RETURN 'D';
				END IF;
END 

```

##### 循环结构

```mysql
/*
分类 ：
		loop  while  repeat
循环控制：
		iterate  类似于 continue ，继续，结束本次循环，继续下次循环
		leave   类似于break  ，跳出本次循环，结束当前所在的循环

1. while
语法：
	【标签 :】while 循环条件 do
					 循环体;
			  end  while  【标签】;
	
2. loop
语法：
	【标签 :】loop
			 循环体;
	end loop 【标签:】;

3.repeat
语法：
	【标签:】repeat 
			循环体;
	until 结束循环的条件
	end  repeat 【标签:】;
*/
# while 批量插入
CREATE PROCEDURE pro_while(IN insertCount INT)
BEGIN
		DECLARE  i  INT DEFAULT 1;
		WHILE i <= inserCount DO 
			INSERT INTO admin(username,password) VALUES('1'+i,'1111');
			SET i = i +1;
		END WHILE;
END

#金典案例
CREATE PROCEDURE test_randstr_insert(IN insertCount INT)
BEGIN
	DECLARE i INT DEFAULT 1;
	DECLARE str VARCHAR(26) DEFAULT 'abcdefghijklmnopqrstuvwxyz';
	DECLARE startIndex INT;#代表初始索引
	DECLARE len INT;#代表截取的字符长度
	WHILE i<=insertcount DO
		SET startIndex=FLOOR(RAND()*26+1);#代表初始索引，随机范围1-26
		SET len=FLOOR(RAND()*(20-startIndex+1)+1);#代表截取长度，随机范围1-（20-startIndex+1）
		INSERT INTO stringcontent(content) VALUES(SUBSTR(str,startIndex,len));
		SET i=i+1;
	END WHILE;

END 

CALL test_randstr_insert(10)$
```

****

#### mysql的架构介绍

#####  linux版的mysql安装

1. 查看mysql是否安装 **rmp  -qa| grep -i mysql**
2. 安装mysql服务端和服务端 **rpm -ivh   rmp软件包名称**
3. 查看mysql是否安装 **ps -ef | grep mysql**
4. 查看mysql用户组  **cat /etc/group  | grep mysql**
5. 查看mysql 版本 **mysqladmin -version**
6. 启动mysql 服务 **service mysql start**
7. 关闭mysql服务 **service mysql stop**
8. 设置mysql密码 **/usr/bin/mysqladmin  -uroot  password  123456**
9. 连接mysql  **mysql  -u root -p 123456**
10. 设置mysql开机自启动 **chkconfig mysql on**
11. 查看mysql运行级别  **chkconfig --list  | grep mysql**
12. 查看运行级别的含义 **cat /etc/inittab**
13. 查看mysql是否开机自启动 **ntsysv**

###### 在Linux下查看mysql安装目录 **ps -ef | grep mysql**

| 路经              | 解释                    | 备注                         |
| ----------------- | ----------------------- | ---------------------------- |
| /var/lib/mysql/   | mysql数据文件的存放路径 | 数据库的数据存放磁盘位置     |
| /usr/share/mysql  | 配置文件目录            | mysqld.service命令及配置文件 |
| /etc/init.d/mysql | 启停相关脚本            |                              |

###### mysql各种文件介绍

1. 二进制日志文件 **log-bin** 主要用于主从复制。
2. 错误日志文件 :**log-err** 默认关闭的，记录严重的警告和错误信息，每次启动和关闭的详细信息等。
3. 查询日志 **log**  : 默认关闭，记录查询的sql语句，如果开启会减低mysql的性能，因为记录日志也是要消耗系统资源。
4. **frm文件** 存放表结构。
5. **myd文件** 存放表数据。
6. **myi** 存放表索引。

###### mysql逻辑架构介绍

1.  **连接层** : 最上层是一些客户端和连接服务，包含本地sock通信和大多数基于客户端/服务端工具实现的类似于tcp/ip的通信。主要完成一些类似于连接处理、授权认证、及相关的安全方案。在该层上引入了线程池的概念，为通过认证安全接入的客户端提供线程。同样在该层上可以实现基于SSL的安全链接。服务器也会为安全接入的每个客户端验证它所具有的操作权限。
2. **服务层** :  第二层架构主要完成大多少的核心服务功能，如SQL接口，并完成缓存的查询，SQL的分析和优化及部分内置函数的执行。所有跨存储引擎的功能也在这一层实现，如过程、函数等。在该层，服务器会解析查询并创建相应的内部解析树，并对其完成相应的优化如确定查询表的顺序，是否利用索引等，最后生成相应的执行操作。如果是select语句，服务器还会查询内部的缓存。如果缓存空间足够大，这样在解决大量读操作的环境中能够很好的提升系统的性能。
3. **引擎层** :   存储引擎层，存储引擎真正的负责了MySQL中数据的存储和提取，服务器通过API与存储引擎进行通信。不同的存储引擎具有的功能不同，这样我们可以根据自己的实际需要进行选取。
4. **存储层** ：数据存储层，主要是将数据存储在运行于裸设备的文件系统之上，并完成与存储引擎的交互。

###### mysql存储引擎

1.  **查看mysql现在已提供什么存储引擎  show engines;** 。
2. **查看mysql当前默认的存储引擎  show variables like '%storage_engine%';**。
3. **MyISAM 与InnoDB对比**

| 对比项   |                         MyISAM                         |                            InnoDB                            |
| -------- | :----------------------------------------------------: | :----------------------------------------------------------: |
| 主外键   |                         不支持                         |                             支持                             |
| 事务     |                         不支持                         |                             支持                             |
| 行表锁   | 表锁，即使操作一条记录也会锁住整个表，不适合高并发操作 | 行锁，操作时只锁某一行，部队其他行有影响，**适合高并发操作** |
| 缓存     |               只缓存索引，不缓存真实数据               | 不仅缓存索引，还要缓存真实数据，对内存要求较高，而且内存大小对性能有决定性的影响 |
| 表空间   |                           小                           |                              大                              |
| 关注点   |                          性能                          |                             事务                             |
| 默认安装 |                           Y                            |                              Y                               |

***



#### 索引优化分析

##### 性能下降SQL，慢执行时间长，等待时间长

1. 查询语句写的烂
2. 索引失效
   1. 单值索引
   2. 复合索引
3. 关联查询太多join（设计缺陷或不得已的需求）
4. 服务器调优及各个参数设置（缓冲、线程数等）

##### 常见通用的Join查询

​	**mysql对sql的执行顺序**![1](.\imges\sql 执行路线.png)

***

###### join图

![1](.\imges\各种join连接.png)

##### 索引的简介

###### 是什么

1. MySQL官方对索引的定义为：索引（Index）是帮助MySQL高效获取数据的数据结构。
   可以得到索引的本质：索引是数据结构。
2. 可以简单理解为  **排好序的快速查找结构**。
3. 一般来说索引本身也很大，不可能全部存储在内存中，因此索引往往以索引文件的形式存储的磁盘上。
4. 我们平常所说的索引，如果没有特别指明，都是指B+树结构组织的索引。其中聚集索引，次要索引，覆盖索引，
   复合索引，前缀索引，唯一索引默认都是使用B+树索引，统称索引。当然，除了B+树这种类型的索引之外，还有哈稀索引(hash index)等。

###### 优势

1. 类似大学图书馆建书目索引，提高数据检索的效率，降低数据库的IO成本。
2. 通过索引列对数据进行排序，降低数据排序的成本，降低了CPU的消耗。

###### 劣势

1. 实际上索引也是一张表，该表保存了主键与索引字段，并指向实体表的记录，所以索引列也是要占用空间的。
2. 虽然索引大大提高了查询速度，同时却会降低更新表的速度，如对表进行INSERT、UPDATE和DELETE。因为更新表时，MySQL不仅要保存数据，还要保存一下索引文件每次更新添加了索引列的字段，都会调整因为更新所带来的键值变化后的索引信息。
3. 索引只是提高效率的一个因素，如果你的MySQL有大数据量的表，就需要花时间研究建立最优秀的索引，或优化查询语句。

###### mysql索引分类

1. 单值索引

   1. 即一个索引只包含单个列，一个表可以有多个单列索引。

2. 唯一索引

   1. 索引列的值必须唯一，但允许有空值。

3. 复合索引

   1. 即一个索包含多个列。

4. 创建
   1. **CREATE  [UNIQUE ] INDEX indexName ON mytable(columnname(length)); **。
   2. **ALTER mytable ADD  [UNIQUE ]  INDEX [indexName (columnname(length))**。
   3. 注意：如果是CHAR，VARCHAR类型，length可以小于字段实际长度；如果是BLOB和TEXT类型，必须指定length。

5. 删除

   1. **DROP INDEX [indexName] ON mytable; ** 。

6. 查看

   1. **SHOW INDEX FROM table_name\G** 。

7. 使用ALTER命令

   ```mysql
   #有四种方式来添加数据表的索引：
   ALTER TABLE tbl_name ADD PRIMARY KEY (column_list):
   #该语句添加一个主键，这意味着索引值必须是唯一的，且不能为NULL。
   
   
   ALTER TABLE tbl_name ADD UNIQUE index_name (column_list): 
   #这条语句创建索引的值必须是唯一的（除了NULL外，NULL可能会出现多次）。
   
   
   ALTER TABLE tbl_name ADD INDEX index_name (column_list): 
   #添加普通索引，索引值可出现多次。
   
   
   ALTER TABLE tbl_name ADD FULLTEXT index_name (column_list):
   #该语句指定了索引为 FULLTEXT ，用于全文索引。
    
   ```

###### mysql索引结构

1. **BTree索引**
2. **Hash索引**
3. **full-text全文索引**
4. **R-Tree索引**

###### 哪些情况需要创建索引

1. 主键自动建立唯一索引。
2. 频繁作为查询条件的字段应该创建索引。
3. 查询中与其它表关联的字段，外键关系建立索引。
4. 频繁更新的字段 **不适合** 创建索引。
   1. 因为每次更新不单单是更新了记录还会更新索引，加重了IO负担。
5. Where条件里用不到的字段不创建索引。
6. 单键/组合索引的选择问题，who？(在高并发下倾向创建组合索引)。
7. 查询中排序的字段，排序字段若通过索引去访问将大大提高排序速度。
8. 查询中统计或者分组字段。

###### 哪些情况不要创建索引

1. 表记录太少。
2. 经常增删改的表。
   1. **Why:提高了查询速度，同时却会降低更新表的速度，如对表进行INSERT、UPDATE DELETE。因为更新表时，MySQL不仅要保存数据，还要保存一下索引文件**
3. 数据重复且分布平均的表字段，因此应该只为最经常查询和最经常排序的数据列建立索引。注意，**如果某个数据列包含许多重复的内容，为它建立索引就没有太大的实际效果** 。

****

##### 性能分析

###### MySql Query Optimizer

* Mysql中有专门负责优化SELECT语句的优化器模块，主要功能：通过计算分析系统中收集到的统计信息，为客户端请求的Query提供他认为最优的执行计划（他认为最优的数据检索方式，但不见得是DBA认为是最优的，这部分最耗费时间）
*  当客户端向MySQL 请求一条Query，命令解析器模块完成请求分类，区别出是 SELECT 并转发给MySQL Query Optimizer时，MySQL Query Optimizer 首先会对整条Query进行优化，处理掉一些常量表达式的预算，直接换算成常量值。并对 Query 中的查询条件进行简化和转换，如去掉一些无用或显而易见的条件、结构调整等。然后分析 Query 中的 Hint 信息（如果有），看显示Hint信息是否可以完全确定该Query 的执行计划。如果没有 Hint 或Hint 信息还不足以完全确定执行计划，则会读取所涉及对象的统计信息，根据 Query 进行写相应的计算分析，然后再得出最后的执行计划。

###### MySQL常见瓶颈

1. CPU：CPU在饱和的时候一般发生在数据装入内存或从磁盘上读取数据时候
2. IO：磁盘I/O瓶颈发生在装入数据远大于内存容量的时候
3. 服务器硬件的性能瓶颈：top,free, iostat和vmstat来查看系统的性能状态

###### Explain

1. 是什么(查看执行计划)

   * 使用EXPLAIN关键字可以模拟优化器执行SQL查询语句，从而知道MySQL是
     如何处理你的SQL语句的。分析你的查询语句或是表结构的性能瓶颈

2. 能干嘛

   * 表的读取顺序
   * 数据读取操作的操作类型
   * 哪些索引可以使用
   * 哪些索引被实际使用
   * 表之间的引用
   * 每张表有多少行被优化器查询

3. 怎么玩

   * Explain + SQL语句

4. 各字段解释

   * **id** 
     1. id相同，执行顺序由上至下
     2. id不同，如果是子查询，id的序号会递增，id值越大优先级越高，越先被执行
     3. id相同不同，同时存在
   * **select_type** : 查询的类型，主要是用于区别 普通查询、联合查询、子查询等的复杂查询
     1. **SIMPLE** : 简单的 select 查询,查询中不包含子查询或者UNION
     2. **PRIMARY** : 查询中若包含任何复杂的子部分，最外层查询则被标记为
     3. **SUBQUERY** : 在SELECT或WHERE列表中包含了子查询
     4. **DERIVED** : 在FROM列表中包含的子查询被标记为DERIVED(衍生)
        MySQL会递归执行这些子查询, 把结果放在临时表里。
     5. **UNION** : 若第二个SELECT出现在UNION之后，则被标记为UNION；
        若UNION包含在FROM子句的子查询中,外层SELECT将被标记为：DERIVED
     6. **UNION RESULT** : 从UNION表获取结果的SELECT
   * **table** : 显示这一行的数据是关于哪张表的
   * **type** : 显示查询使用了何种类型，从最好到最差依次是:
     system>const>eq_ref>ref>range>index>ALL
     1. **system** : 表只有一行记录（等于系统表），这是const类型的特列，平时不会出现，这个也可以忽略不计
     2. **const** : 表示通过索引一次就找到了,const用于比较primary key或者unique索引。因为只匹配一行数据，所以很快如将主键置于where列表中，MySQL就能将该查询转换为一个常量
     3. **eq_ref** : 唯一性索引扫描，对于每个索引键，表中只有一条记录与之匹配。常见于主键或唯一索引扫描
     4. **ref** : 非唯一性索引扫描，返回匹配某个单独值的所有行.
        本质上也是一种索引访问，它返回所有匹配某个单独值的行，然而，
        它可能会找到多个符合条件的行，所以他应该属于查找和扫描的混合体
     5. **range** : 只检索给定范围的行,使用一个索引来选择行。key 列显示使用了哪个索引
        一般就是在你的where语句中出现了between、<、>、in等的查询
        这种范围扫描索引扫描比全表扫描要好，因为它只需要开始于索引的某一点，而结束语另一点，不用扫描全部索引。
     6. **index** : Full Index Scan，index与ALL区别为index类型只遍历索引树。这通常比ALL快，因为索引文件通常比数据文件小。
        （也就是说虽然all和Index都是读全表，但index是从索引中读取的，而all是从硬盘中读的）
     7. **all** : Full Table Scan，将遍历全表以找到匹配的行
     8. **备注：一般来说，得保证查询至少达到range级别，最好能达到ref。**
   * **possible_keys** 
     1. 显示可能应用在这张表中的索引，一个或多个。
        查询涉及到的字段上若存在索引，则该索引将被列出，但不一定被查询实际使用
   * **key**
     1. 实际使用的索引。如果为NULL，则没有使用索引
     2. 查询中若使用了覆盖索引，则该索引仅出现在key列表中
   * **key_len** 
     1. 表示索引中使用的字节数，可通过该列计算查询中使用的索引的长度。在不损失精确性的情况下，长度越短越好
     2. key_len显示的值为索引字段的最大可能长度，并非实际使用长度，即key_len是根据表定义计算而得，不是通过表内检索出的
   * **ref** ：显示索引的哪一列被使用了，如果可能的话，是一个常数。哪些列或常量被用于查找索引列上的值
   * **rows** ：根据表统计信息及索引选用情况，大致估算出找到所需的记录所需要读取的行数
   * **Extra** ：包含不适合在其他列中显示但十分重要的额外信息
     1. **Using filesort ** ：说明mysql会对数据使用一个外部的索引排序，而不是按照表内的索引顺序进行读取。MySQL中无法利用索引完成的排序操作称为“文件排序”
     2. **Using temporary ** ：使了用临时表保存中间结果,MySQL在对查询结果排序时使用临时表。常见于排序 order by 和分组查询 group by。
     3. **USING index** ：表示相应的select操作中使用了覆盖索引(Covering Index)，避免访问了表的数据行，效率不错！
        如果同时出现using where，表明索引被用来执行索引键值的查找;
        如果没有同时出现using where，表明索引用来读取数据而非执行查找动作。
        * **覆盖索引(Covering Index)** ：就是select的数据列只用从索引中就能够取得，不必读取数据行，MySQL可以利用索引返回select列表中的字段，而不必根据索引再次读取数据文件,换句话说查询列要被所建的索引覆盖。
     4. **Using where** ：表明使用了where过滤
     5. **using join buffer** ：使用了连接缓存：
     6. **impossible where** ：where子句的值总是false，不能用来获取任何元组
     7. **select tables optimized away** ：在没有GROUPBY子句的情况下，基于索引优化MIN/MAX操作或者对于MyISAM存储引擎优化COUNT(*)操作，不必等到执行阶段再进行计算，查询执行计划生成的阶段即完成优化。
     8. **distinct** ：优化distinct操作，在找到第一匹配的元组后即停止找同样值的动作


###### 索引优化

1. 索引分析

   1. 单表

      ```mysql
      #建表SQL
      CREATE TABLE IF NOT EXISTS `article` (
      `id` INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
      `author_id` INT(10) UNSIGNED NOT NULL,
      `category_id` INT(10) UNSIGNED NOT NULL,
      `views` INT(10) UNSIGNED NOT NULL,
      `comments` INT(10) UNSIGNED NOT NULL,
      `title` VARBINARY(255) NOT NULL,
      `content` TEXT NOT NULL
      );
      
      
      INSERT INTO `article`(`author_id`, `category_id`, `views`, `comments`, `title`, `content`) VALUES
      (1, 1, 1, 1, '1', '1'),
      (2, 2, 2, 2, '2', '2'),
      (1, 1, 3, 3, '3', '3');
      
      
      SELECT * FROM article;
      #案例
      #查询 category_id 为 1 且 comments 大于 1 的情况下,views 最多的 article_id。 
      EXPLAIN SELECT id,author_id FROM article WHERE category_id = 1 AND comments > 1 ORDER BY views DESC LIMIT 1;
      #结论：很显然,type 是 ALL,即最坏的情况。Extra 里还出现了 Using filesort,也是最坏的情况。优化是必须的。
      
      #开始优化：
      # 1.1 新建索引+删除索引
      #ALTER TABLE `article` ADD INDEX idx_article_ccv ( `category_id` , `comments`, `views` );
      create index idx_article_ccv on article(category_id,comments,views);
      DROP INDEX idx_article_ccv ON article
      
      
      # 1.2 第2次EXPLAIN
      EXPLAIN SELECT id,author_id FROM `article` WHERE category_id = 1 AND comments >1 ORDER BY views DESC LIMIT 1;
      EXPLAIN SELECT id,author_id FROM `article` WHERE category_id = 1 AND comments =3 ORDER BY views DESC LIMIT 1
      #结论：
      #type 变成了 range,这是可以忍受的。但是 extra 里使用 Using filesort 仍是无法接受的。
      #但是我们已经建立了索引,为啥没用呢?
      #这是因为按照 BTree 索引的工作原理,
      # 先排序 category_id,
      # 如果遇到相同的 category_id 则再排序 comments,如果遇到相同的 comments 则再排序 views。
      #当 comments 字段在联合索引里处于中间位置时,
      #因comments > 1 条件是一个范围值(所谓 range),
      #MySQL 无法利用索引再对后面的 views 部分进行检索,即 range 类型查询字段后面的索引无效。
      
      
      # 1.3 删除第一次建立的索引
      DROP INDEX idx_article_ccv ON article;
      
      # 1.4 第2次新建索引
      #ALTER TABLE `article` ADD INDEX idx_article_cv ( `category_id` , `views` ) ;
      create index idx_article_cv on article(category_id,views);
      
      # 1.5 第3次EXPLAIN
      EXPLAIN SELECT id,author_id FROM article WHERE category_id = 1 AND comments > 1 ORDER BY views DESC LIMIT 1;
      #结论：可以看到,type 变为了 ref,Extra 中的 Using filesort 也消失了,结果非常理想。
      DROP INDEX idx_article_cv ON article;
      
      ```

   2. 两表

      ```mysql
      #建表SQL
      
      CREATE TABLE IF NOT EXISTS `class` (
      `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
      `card` INT(10) UNSIGNED NOT NULL,
      PRIMARY KEY (`id`)
      );
      CREATE TABLE IF NOT EXISTS `book` (
      `bookid` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
      `card` INT(10) UNSIGNED NOT NULL,
      PRIMARY KEY (`bookid`)
      );
      
      
      INSERT INTO class(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO class(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO class(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO class(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO class(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO class(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO class(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO class(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO class(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO class(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO class(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO class(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO class(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO class(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO class(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO class(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO class(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO class(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO class(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO class(card) VALUES(FLOOR(1 + (RAND() * 20)));
      
      
      INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
      
      #案例
      
      
      # 下面开始explain分析
      EXPLAIN SELECT * FROM class LEFT JOIN book ON class.card = book.card;
      #结论：type 有All
      
      
      # 添加索引优化
      ALTER TABLE `book` ADD INDEX Y ( `card`);
      
      
      # 第2次explain
      EXPLAIN SELECT * FROM class LEFT JOIN book ON class.card = book.card;
      #可以看到第二行的 type 变为了 ref,rows 也变成了优化比较明显。
      #这是由左连接特性决定的。LEFT JOIN 条件用于确定如何从右表搜索行,左边一定都有,
      #所以右边是我们的关键点,一定需要建立索引。
      
      
      # 删除旧索引 + 新建 + 第3次explain
      DROP INDEX Y ON book;
      ALTER TABLE class ADD INDEX X (card);
      EXPLAIN SELECT * FROM class LEFT JOIN book ON class.card = book.card;
      
      
      
      
      # 然后来看一个右连接查询:
      #优化较明显。这是因为 RIGHT JOIN 条件用于确定如何从左表搜索行,右边一定都有,所以左边是我们的关键点,一定需要建立索引。
      EXPLAIN SELECT * FROM class RIGHT JOIN book ON class.card = book.card;
      DROP INDEX X ON class;
      ALTER TABLE book ADD INDEX Y (card);
      # 右连接，基本无变化
      EXPLAIN SELECT * FROM class RIGHT JOIN book ON class.card = book.card;
       
      
      
       
      ```

   3. 三表

      ```mysql
      #建表SQL
      
      
      CREATE TABLE IF NOT EXISTS `phone` (
      `phoneid` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
      `card` INT(10) UNSIGNED NOT NULL,
      PRIMARY KEY (`phoneid`)
      ) ENGINE = INNODB;
      
      
      INSERT INTO phone(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO phone(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO phone(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO phone(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO phone(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO phone(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO phone(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO phone(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO phone(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO phone(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO phone(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO phone(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO phone(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO phone(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO phone(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO phone(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO phone(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO phone(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO phone(card) VALUES(FLOOR(1 + (RAND() * 20)));
      INSERT INTO phone(card) VALUES(FLOOR(1 + (RAND() * 20)));
      
      #案例
      
      
      
      
      ALTER TABLE `phone` ADD INDEX z ( `card`);
      
      
      ALTER TABLE `book` ADD INDEX Y ( `card`);#上一个case建过一个同样的
      
      
      
      
      EXPLAIN SELECT * FROM class LEFT JOIN book ON class.card=book.card LEFT JOIN phone ON book.card = phone.card;
      
      
      # 后 2 行的 type 都是 ref 且总 rows 优化很好,效果不错。因此索引最好设置在需要经常查询的字段中。
      ==================================================================================
      【结论】
      Join语句的优化
      
      尽可能减少Join语句中的NestedLoop的循环总次数；“永远用小结果集驱动大的结果集”。
      优先优化NestedLoop的内层循环；
      保证Join语句中被驱动表上Join条件字段已经被索引；
      当无法保证被驱动表的Join条件字段被索引且内存资源充足的前提下，不要太吝惜JoinBuffer的设置；
      ```

2. 索引失效(应该避免)

   1. 全值匹配我最爱
   2. 最佳左前缀法则 : 如果索引了多列，要遵守最左前缀法则。指的是查询从索引的最左前列开始并且不跳过索引中的列。
   3. 不在索引列上做任何操作（计算、函数、(自动or手动)类型转换），会导致索引失效而转向全表扫描
   4. 存储引擎不能使用索引中范围条件右边的列
   5. 尽量使用覆盖索引(只访问索引的查询(索引列和查询列一致))，减少select *
   6. mysql 在使用不等于(!= 或者<>)的时候无法使用索引会导致全表扫描
   7. is null ,is not null 也无法使用索引
   8. like以通配符开头('%abc...')mysql索引失效会变成全表扫描的操作
   9. 字符串不加单引号索引失效
   10. 少用or,用它来连接时会索引失效

3. 小总结

   | 假设index(a,b,c)                       | Where语句索引是否被使用          |
   | -------------------------------------- | -------------------------------- |
   | where a = 3Y                           | 使用到a                          |
   | where a = 3 and b = 5Y                 | 使用到a，b                       |
   | where a = 3 and b = 5 and c = 4Y       | 使用到a,b,c                      |
   | where b = 3                            | 没有使用                         |
   | where b = 3 and c = 4                  | 没有                             |
   | where c = 4N                           | 没有使用                         |
   | where a = 3 and c = 5                  | 使用到a，  但是C不可以，中间断了 |
   | where a = 3 and b > 4 and c = 7        | 使用到a和b， c在范围之后，断了   |
   | where a = 3 and b like 'kk%' and c = 4 | 同上                             |








