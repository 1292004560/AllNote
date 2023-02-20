## 初始JavaScript

### JS的组成

###### DOM 文档对象模型

<b style="color:red;">文档对象模型</b> (Document Object Model，简称DOM)，是W3C组织推荐的处理可扩展标记语言的标准编程接口。通过DOM提供的接口可以对页面上的各种元素进行(大小、位置、颜色等)。

###### BOM 浏览器对象模型

<b style="color:red;">BOM</b> (Browser Object Model)是指浏览器对象模型，它提供了独立于内容的，可以与浏览器窗口进行互动的对象结构。通过BOM可以操作浏览器窗口，比如弹出框、控制浏览器跳转、获取分辨率等。

### JS书写位置

JS有三种书写位置，分别为行内、内嵌和外部。

**行内**

```html
<input type="button" value="你好" onclick="alert('hello world')"></input>
```

* 可以将单行或者少量的JS代码写着HTML标签事件属性中 (以on开头的属性)，如: `onclick`
* 注意单双引号的使用 ：在HTML中我们推荐使用双引号，JS中我们推荐使用单引号

**内嵌**

```html
<script>
  alter('hello world')
</script>
```

**外部** 

```js
alert('hello world');
```

```html
<script src="my.js"></script>
```

### JS注释

```js
// 单行注释

/*
多行注释
*/
```

## JS输入输出语句

为了方便信息的输入输出，js中提供了一些输入输出语句，其常用的语句如下 : 

| 方法               | 说明                           | 归属   |
| ------------------ | ------------------------------ | ------ |
| `alert(msg)`       | 浏览器弹出警示框               | 浏览器 |
| `console.log(msg)` | 浏览器控制台打印输出信息       | 浏览器 |
| `prompt(info)`     | 浏览器弹出输入框，用户可以输入 | 浏览器 |

```html
<script>
  prompt('请输入内容...')
</script>
```

## 变量

##### 变量的使用

变量使用时分为两步 : 1. 声明  2. 赋值

**声明**

```js
var age;// 声明变量
```

**赋值**

```js
age=10;
```

**变量的初始化**

```js
var age = 19;
```

##### 同时声明多个变量

```js
var age = 10,name = 'zhoushuiping',sex = 'nan';
```

##### 声明变量特殊情况

| 情况                        | 说明                   | 结果        |
| --------------------------- | ---------------------- | ----------- |
| `var age;console.log(age);` | 只声明不赋值           | `undefined` |
| `console.log(age);`         | 不声明 不赋值 直接使用 | 报错        |
| `age=10;console.log(age)`   | 不声明 只赋值          | 10          |

## 数据类型

变量是用来存储值的所在处，它们有名字和数据类型。变量的数据类型决定了如何将代表这些值的位存储到计算机的内存中。<b style="color:red;">JavaScript是一种弱类型或者说动态类型语言。</b> 这意味着不用提前声明变量的类型，在程序运行过程中，类型会被自动确定。

```js
var age = 10; // 这是一个数字
var name = "zsp"
```

#### 数据类型的分类

JS把数据类型分为两类 : 

* 简单数据类型 (Number，String，Boolean，Undefined，Null)
* 复杂数据类型(object)

#### 简单数据类型

| 简单数据类型 | 说明                                        | 默认值    |
| ------------ | ------------------------------------------- | --------- |
| `Number`     | 数字型，包含 整型值和浮点型值，如 21 0.21   | 0         |
| `Boolean`    | 布尔数据类型，如true 、false、，等价于1 ，0 | false     |
| `String`     | 字符串类型，如 '张三'                       | ""        |
| `Undefined`  | var a; 声明了变量a但是没有给值              | undefined |
| `Null`       | var a = null; 生明变量a为空值               | null      |

##### 简单数据类型的范围

```js
alert(Number.MAX_VALUE);
alert(Number.MIN_VALUE);
```

##### 数字类型的三个特殊类型

```js
alert(Infinity);
alert(-Infinity);
alert(NaN);
```

* `Infinity` ，代表无穷大，大于任何值
* `-Infinity` ，无穷小，小于任何值
* `NaN` ，not a number，代表一个非数值

##### isNaN()

```js
console.log(isNaN(12)); //false
console.log((isNaN('z')))//true
```

##### 字符串类型String

```js
var str = 'hello';
var hello="hello world"
```

因为HTML代码标签里面的属性使用的是双引号，js这里更推荐使用单引号。

 ##### 获取字符串长度

```js
var name="zhoushuiping";
console.log(name.length);
```

####  获取变量的数据类型

```javascript
var num = 10;
console.log(typeof num);
```

##### 子面量

字面量是在源代码中一个固定值的表示法，通俗来说，就是字面量表示如何表达这个值。

* 数字字面量 : 8,9,10
* 字符字面量 : "前端"
* 布尔字面量 : true, false

#### 转换为字符串类型

| 方式               | 说明                         | 案例                                 |
| ------------------ | ---------------------------- | ------------------------------------ |
| `toString()`       | 转成字符串                   | `var num = 1;alert(num.toString());` |
| `String()强制转换` | 转成字符串                   | `var num = 1;alert(String(num));`    |
| 加号拼接字符串     | 和字符串拼接的结果都是字符串 | `var num = 1;alert(num + 'zsp')`     |

#### 转换为数字类型(重点)

| 方式                     | 说明                           | 案例                 |
| ------------------------ | ------------------------------ | -------------------- |
| `parseInt(string)`函数   | 将string类型转成整数值类型     | `parseInt('76')`     |
| `parseFloat(string)`函数 | 将string类型转换成浮点数值类型 | `parseFloat('78.2')` |
| `Number()`强制转换函数   | 将string类型转换为数值类型     | `Number('12')`       |
| js隐式转换 (- * /)       | 利用算数运算隐式转换为数字型   | `'12'-0 `            |

#### 转换为布尔型

| 方式            | 说明               | 案例            |
| --------------- | ------------------ | --------------- |
| `Boolean()`函数 | 其他类型转成布尔型 | Boolean('true') |

* 代表 空、否定的值会被转换为false ，如 `0、NaN 、null 、ubdefined`
* 其余值都会转换为true

```js
console.log(Boolean(''));//false
console.log(Boolean(0));//false
console.log(Boolean(NaN));//false
console.log(Boolean(null));//false
console.log(Boolean(undefined));//false
console.log(Boolean('z'));//true
console.log(Boolean(12));//true
```



## 运算符

#### 算数运算符

| 运算符 | 描述 | 实例   |
| ------ | ---- | ------ |
| `+`    | 加   | 10 + 2 |
| `-`    | 减   | 10 -2  |
| `*`    | 乘   | 10*2   |
| `/`    | 除   | 10/2   |
| `%`    | 取模 | 10 % 2 |

####  比较运算符

| 运算符名称  | 说明                        | 案例    | 结果  |
| ----------- | --------------------------- | ------- | ----- |
| `<`         | 小于号                      | 1 < 2   | true  |
| `>`         | 大于号                      | 1>2     | false |
| `>=`        | 大于等于                    | 2>=2    | true  |
| `<=`        | 小于等于                    | 3<=2    | false |
| `==`        | 等等于                      | 3==3    | true  |
| `!=`        | 不等号                      | 37!=37  | false |
| `===` `!==` | 全等 要求值和数据类型都一致 | 2==='2' | false |

#### =小结

| 符号  | 作用 | 用法                                                         |
| ----- | ---- | ------------------------------------------------------------ |
| `=`   | 赋值 | 把右边给左边                                                 |
| `==`  | 判断 | 判断两边值是否相等(<span style="color:red;">注意此时有隐式转换</span>) |
| `===` | 全等 | 判断两边的值和数据类型是否完全相同                           |

#### 逻辑运算符

| 逻辑运算符 | 说明                     | 案例            |
| ---------- | ------------------------ | --------------- |
| `&&`       | "逻辑与" ，简称"与" and  | true&&flase     |
| `||`       | "逻辑或"，简称"或" or    | true \|\| false |
| `!`        | "逻辑非" ，简称 "非" not | !true           |

#### 运算符优先级

| 优先级 | 运算符     | 顺序              |
| ------ | ---------- | ----------------- |
| 1      | 小括号     | `()`              |
| 2      | 一元运算符 | `++ -- !`         |
| 3      | 算数运算符 | `先* / 后 + -`    |
| 4      | 关系运算符 | `> >= < <=`       |
| 5      | 相等运算符 | `== !=. ===. !==` |
| 6      | 逻辑运算符 | `先 && 后 ||`     |
| 7      | 赋值运算符 | `=`               |
| 8      | 逗号运算符 | `,`               |

## 流程控制

流程控制主要有三种结构 ，分别是顺序结构、分枝结构和循环结构 ，这三种结构代表代码的执行顺序。

#### if分支流程控制

```js
if (条件表达式){
  
}else if (条件表达式){
  
}else{
  
}
```

#### 三元运算符

```js
var result =  3 > 5 ? 4:5;
```

#### switch表达式

```js
switch(表达式){
  case value1:
    执行语句1;
    break;
  case value2:
    执行语句2;
    break;
  default:
    执行最后的语句;
}
```

#### 循环

**for循环**

```js
for (var i = 0; i <= 100; i++){}
```

**while循环**

```js
var i = 0;
while (i < 100){
  i++;
}
```

**do..while循环**

```js
var i = 0;
do {
  i++;
}while(i < 100);
```

#### continue关键字

continue关键字用于立即跳出本次循环，继续下一次循环。

```js
for(var i = 0; i <= 5; i++){
  if (i == 3){
    continue;
  }
  console.log(i);
}
```

#### break关键字

break关键字用于立即跳出循环

```js
for(var i = 0; i <= 5; i++){
  if (i == 3){
    break;
  }
  console.log(i);
}
```

## 数组

 #### 创建数组

```js
var arr = new Array();//创建一个空数组

// 使用字面量方式创建空的数组
var arr = ['小白','小黑']
```

#### 访问数组元素

```js
var arr = ['小白','小黑']
console.log(arr[1]);
```

#### 数组长度

```js
var arr = ['小白','小黑']
console.log(arr.length);
```

#### 数组中新增元素

```js
// 通过修改length长度心中数组元素
// 可以通过修改length长度来实现数组扩容的目的
//length属性是可写的
var arr = ['red','green', 'blue'];
arr.length = 6;

// 新增数组元素，修改索引号
arr[3] = 'pink';
```

## 函数

```js
function getSum(num1, num2){
  return num1 + num2;
}
```

#### 函数使用

**声明函数和调用函数**

```js
function getSum(num1, num2){
  return num1 + num2;
}//声明函数

getSum(1, 2); //调用函数
```

**注意 : ** 如果函数实参的个数多于形参的个数，不会报错，有几个形参，就会取几个实参。

#### arguments的使用

当我们不确定有多少个参数传递的时候可以用<span style="color:red;">arguments</span> 来获取。在JavaScript中，arguments实际上它是当前函数的一个<span style="color:red;">内置对象</span>。所有函数都内置了一个arguments对象，arguments对象中存储了传递的所有实参。

```js
function fn(){
  console.log(arguments);
}
fn(1,2,3);
```

 <b style="color:red;">arguments展示形式是一个伪数组</b> ，因此可以遍历。伪数组具有以下特点：

* 具有length属性
* 按索引方式存储数据
* 不具有数组的push、pop等方法

**利用函数求任意个数的最大值**

```js
 function getMax() {
            var max = arguments[0];
            for (var i = 0; i < arguments.length; i++) {
                if (arguments[i] > max) {
                    max = arguments[i];
                }
            }
            return max;
  }

 console.log(getMax(1, 2, 3, 4, 5));
 console.log(getMax(1, 2, 6));
```

#### 函数声明两种方式

```js
// 1. 利用函数关键字自定义函数(命名函数)
function fn(){}

// 2. 函数表达式(匿名函数)
var fun = function(){
  console.log("hello world");
}
// fun 是变量名
fun(); // 调用函数
```

## JavaScript 预解析

#### 预解析

JavaScript代码是由浏览器中的JavaScript解析器来执行的。JavaScript解析器在运行JavaScript代码的时候分为两步 : 预解析和代码执行。

* 预解析 JS引擎会把JS代码 里面所有的var 还有function提升到当前作用域的最前面
* 代码执行 按照代码书写的顺序从下往上执行

预解析分为变量预解析(变量提升) 和函数预解析(函数提升)

* 变量提升 就是把所有的变量提升到当前的作用域最前面，不提升赋值操作
* 函数提升 就是把所有的函数声明提升到当前作用域 ，不调用函数

#### 预解析案例

```js
 var num = 10;
        fun();

        function fun() {
            console.log(num);
            var num = 20;
        }

        // 相当于执行了以下操作
        var num;

        function fun() {
            var num;
            console.log(num);
            num = 20;
        }
num = 10;
fun();
```

## 对象

#### 创建对象的三种方式

在JavaScript中，现阶段可以采用三种方式创建对象(object)：

* 利用字面量创建对象
* 利用new Object 创建对象
* 利用构造函数创建对象

###### 利用字面量创建对象

<b style="color:red;">对象字面量 : </b> 就是花括号 `{}` 里面包含了表达这个具体事物(对象)的属性和方法。

```js
var obj = {}; //创建一个空对象

 var obj1 = {
            name: 'zs',
            age: 18,
            sex: 'nan',

            sayHi: function () {
                console.log('hi');
            }
        }
 console.log(obj1.age);
 obj1.sayHi();
 console.log(obj1['age']);
// 调用对象的属性名采取 对象名.属性名 或 对象名['属性名']

// 调用对象的方法 
```

###### 利用new Object()创建对象

```js
var obj = new Object();//创建一个空对象
obj.name = 'zs';
obj.age = 18;
obj.sayHi = function(){
  console.log('hi');
}
```

###### 利用构造函数创建对象

前面两种创建对象的方式一次只能创建一个对象

因为创建一个对象，里面很多的属性和方法大量相同，因此可以用函数的方法，重复这些相同的代码。

<b style="color:red;">构造函数 : </b> 是一种特殊的函数，主要用来初始化对象，即为对象成员变量赋初始值，它总是与 `new` 运算符一起使用。可以把对象中一些公共属性和方法抽取出来，然后封装到这个函数里面。

```js
 function 构造函数名(){
            this.属性 = 值;
            this.方法 = function(){}
        }
new 构造函数名();

1. 构造函数首字母大写

function Star(name, age, sex){
  this.name = name;
  this.age = age;
  this.sex = sex;
  this.sing = function () {
      console.log('hi');
   }
}
new Star('刘德华',18, '男');

// new 关键字执行流程
// 1. new 构造函数可以在内存中创建了一个空对象
// 2. this 就会指向刚才创建的空对象
// 3. 执行构造函数里面的代码 给这个空对象添加属性和方法
```

 #### 遍历对象

```js
// for .. in 语句用于对数组或者对象属性进行循环操作
var obj = {
  name : 'zsp',
  age : 18
}
for (var k in obj){
  console.log(k + " : " + obj[k] ); 
}
```

## 内置对象

* JavaScript中对象分为3中 : 自定义对象、内置对象、浏览器对象
* 前面两种对象是JS基础内容属于EMCMAScript ； 第三个浏览器对象属于JS层独有
* 内置对象就是指JS语言自带的一些对象，这些对象供开发者使用，并提供了一些常用的或最基本而必要的功能(属性和方法)
* JavaScript提供了多个内置对象 : `Math 、 Date 、Array、String等`





