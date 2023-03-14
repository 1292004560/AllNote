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

#### Math对象

```js
Math.PI  // 圆周率

Math.max(1,2,345,67);

Math.floor(); //向下取整

Math.ceil();  //向上取整

Math.random();
```

#### 日期对象

```js
var date = new Date(); // 没有跟参数，返回系统当前时间

// 获得Date总毫秒数 不是当前的毫秒数 而是距离1970年1月1号过了多少毫秒数
// 获取时间戳
console.log(date.valueOf()); 
console.log(date.getTime());
```

#### 数组对象

```js
// 检测是否为数组
var arr = [];

console.log(arr instanceof Aarry);

console.log(Array.isArray(arr));
```

#### 添加数组元素

| 方法名              | 说明                                                   | 返回值               |
| ------------------- | ------------------------------------------------------ | -------------------- |
| `push(参数1...)`    | 末尾添加一个或多个元素，注意修改原数组的长度           | 并返回新的长度       |
| `pop()`             | 删除数组最后一个元素，把数组长度减1 无参数、修改原数组 | 返回它删除元素的值   |
| `unshift(参数1...)` | 向数组的开头添加一个或更多元素，注意修改原数组         | 并返回新的长度       |
| `shift()`           | 删除数组的第一个元素，数组长度减1无参数、修改原数组    | 并返回第一个元素的值 |

#### 数组排序

| 方法名      | 说名                       | 是否修改原数组                     |
| ----------- | -------------------------- | ---------------------------------- |
| `reverse()` | 颠倒数组中元素顺序，无参数 | 该方法会改变原来的数值，返回新数组 |
| `sort()`    | 对数组的元素进行排序       | 该方法会改变原来的数值，返回新数组 |

#### 数组索引方法

| 方法名          | 说明                           | 返回值                                  |
| --------------- | ------------------------------ | --------------------------------------- |
| `indexOf()`     | 数组中查找给定元素的第一个索引 | 如果存在返回索引号 如果不存在，则返回-1 |
| `lastIndexOf()` | 在数组中的最后一个索引         | 如果存在返回索引号 如果不存在，则返回-1 |

#### 数组转换为字符串

| 方法名           | 说明                                     | 返回值         |
| ---------------- | ---------------------------------------- | -------------- |
| `toString()`     | 把数组转换成字符串，逗号分隔每一项       | 返回一个字符串 |
| `join('分割符')` | 方法永远把数组中的所有元素转换一个字符串 | 返回一个字符串 |

#### 基本包装类型

 为了方便操作基本数据类型，JavaScript还提供了三种特殊的引用类型 : `String 、Number、Boolean`。

<b style="color:red;">基本包装类型</b> 就是把简单数据类型包装成为复杂数据类型，这样基本数据类型就有了属性和方法。

#### 根据位置返回字符

| 方法名              | 说明                                | 使用               |
| ------------------- | ----------------------------------- | ------------------ |
| `charAt(index)`     | 返回指定位置的字符(index字符串索引) | str.charAt(0)      |
| `charCodeAt(index)` | 返回指定位置字符的ASCII码           | str.charCodeAt(0); |
| `str[index]`        | 获取指定位置处字符串                | HTML5 IE8+支持     |

## DOM

文档对象模型(Document Object Model，简称DOM)，是W3C组织推荐的处理可扩展标记语言(HTML或XML)的标准<span style="color:red;">编程接口</span> 。

#### 获取元素

**根据Id获取**

```html
<html lang="en">
  <head>
    <title>getElementById example</title>
  </head>
  <body>
    <p id="param">Some text here</p>
    <button onclick="changeColor('blue');">blue</button>
    <button onclick="changeColor('red');">red</button>
  </body>
</html>
```

```js
function changeColor(newColor) {
  const elem = document.getElementById('param');
  elem.style.color = newColor;
}
```

#### 根据标签名获取

```js
var li_list = document.getElementsByTagName('li');
```

还可以获取某个元素(父元素) 内部所有指定签名的子元素

```js
element.getElementsByTagName('li');
```

#### 通过HTML5新增的方法获取

```js
document.getElementsByClassName('类名'); //根据类名返回元素对象集合
```

```js
document.querySelector('选择器');// 根据选择器返回第一个元素
```

```js
document.querySelectorAll('选择器'); // 根据指定选择器返回所有
```

#### 获取特殊元素

 ```js
 bodyElement = document.body; // 返回body元素对象
 console.log(dir(bodyElement));
 
 document.documentElement(); //返回html元素对象 
 ```

## 事件

事件是可以被JavaScript侦测到的行为

事件包含三部分 : `事件源`、`事件类型`、`事件处理程序`

```js
// 获取事件
var btn = document.getElementById('btn'); // 按钮
// 绑定事件
// div.onclick()

// 添加事件处理程序
btn.onclick() = function(){
  
}

```

#### 常见的鼠标事件

| 鼠标事件      | 触发条件         |
| ------------- | ---------------- |
| `onclick`     | 鼠标点击左键触发 |
| `onmouseover` | 鼠标经过触发     |
| `onmouseout`  | 鼠标离开触发     |
| `onfocus`     | 获得鼠标焦点触发 |
| `onblur`      | 失去鼠标焦点触发 |
| `onmousemove` | 鼠标移动触发     |
| `onmouseup`   | 鼠标弹起触发     |
| `onmousedown` | 鼠标按下触发     |

#### 改变元素内容

```js
element.innerText; //不识别html
```

从起始位置到终止位置的内容，但它会去除html标签，同时空格和换行也会去掉

```js
element.innerHTML ; //识别html
```

从起始位置到终止位置的全部内容，包括html标签，同时保留空格和换行

#### 表单元素的属性操作

利用DOM可以操作如下表单元素的属性 : 

`type` 、`value` 、`checked` 、`selected` 、`disabled`

#### 自定义属性的操作

```js
element.属性 获取属性值 //获取自带属性

element.getAttribute('属性');//主要获取自定义属性

element.属性 = '值';

element.setAttribute('属性','值');

//移除属性
element.removeAttribute('属性');
```

#### HTML5自定义属性

自定义属性获取是通过`getAttribute('属性')`获取。但是有些自定义属性很容易引起歧义，不容易判断是元素的内置属性还是自定义属性。

H5规定自定义属性`data-`开头作为属性名并且赋值

```html
<div data-index="1"></div>
或者使用JS设置
element.setAttribute('data-index',2);
```

获取H5自定义属性

```js
element.getAttribute('data-index'); // 兼容获取
element.dataset.index 或者element.dataset['index'] //html5新增获取 ie11支持
```

## 节点操作

#### 节点描述

一般地，节点至少拥有 `nodeType`(节点类型)、`nodeName` (节点名称) 和`nodeValue` (节点值) 这三个基本属性。

* 元素节点 `nodeType` 为1
* 属性节点 `nodeType`为2
* 文本节点`nodeType` 为3 (文本节点包含文字、空格、换行等)

<span style="color:red;">实际开发中，节点操作主要操作的是元素节点</span>

#### 节点层级

利用DOM树可以把节点划分为不同的层级关系，常见的是<b style="color:red;">父子层级关系</b> 。

##### 1. 父级节点

```js
node.parentNode
```

* `parentNode` 属性可返回某节点的父节点，注意是最近的一个父节点
* 如果指定的节点没有父节点则返回null

##### 2. 子节点

```js
parentNode.childNodes (标准)
返回包含指定节点的子节点的集合，该集合为即时更新的集合
得到所有节点包含文本节点和元素节点
```

 ```js
 parentNode.children(); //获取子元素节点
 ```

  ```js
  parentNode.firstChild // 获取第一个子节点，找不到则返回null。同样包含所有节点
  ```

```js
parentNode.lastChild
```

```js
parentNode.firstElementChild // 获取第一个元素节点
```

```js
parentNode.lastElementChild
```

##### 3. 兄弟节点

```js
node.nextSibling  // 获取所有节点
```

```js
node.previousSibling // 获取所有节点
```

```js
node.nextElementSibling // 获取元素节点
```

```js
node.previousElementSibling // 获取元素节点
```

#### 创建节点

```js
document.createElement('tagName');
```

#### 添加节点

```js
node.appenChild('');//后面追加元素
```

```js
node.insertBefore(child,指定元素)
```

#### 删除节点

```js
node.removeChild(child);
```

#### 复制节点

```js
node.cloneNode();
```

<b style="color:red;">注意 : </b>

1. 如果括号参数为空或者`false` ，则是浅拷贝，即只复制节点本身，不复制里面的子节点。
2. 如果括号参数为空或者`true` ，则是深拷贝。

#### 三种动态创建元素区别

* `document.write()`
* `element.innerHTML`
* `document.createElement()`

**区别 **

1. `document.write`是直接将内容写入页面的内容流，但是文档流执行完毕，则它会导致页面全部重绘
2. `innerHTML` 是将内容写入某个DOM节点，不会导致全部从绘
3. `innerHTML` 创建多个元素效率更高(不要拼接字符串，采取数组形式拼接)，结构稍微复杂
4. `createElement() ` 创建多个元素效率稍低一点点，但是结构更清晰

#### 简单留言板发布案例

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <style>
        * {
            margin: 0;
            padding: 0;
        }
        
        body {
            padding: 100px;
        }
        
        textarea {
            width: 200px;
            height: 100px;
            border: 1px solid pink;
            outline: none;
            resize: none;
        }
        
        ul {
            margin-top: 50px;
        }
        
        li {
            width: 300px;
            padding: 5px;
            background-color: rgb(245, 209, 243);
            color: red;
            font-size: 14px;
            margin: 15px 0;
        }
    </style>
</head>

<body>
    <textarea name="" id=""></textarea>
    <button>发布</button>
    <ul>

    </ul>
    <script>
        // 1. 获取元素
        var btn = document.querySelector('button');
        var text = document.querySelector('textarea');
        var ul = document.querySelector('ul');
        // 2. 注册事件
        btn.onclick = function() {
            if (text.value == '') {
                alert('您没有输入内容');
                return false;
            } else {
                // console.log(text.value);
                // (1) 创建元素
                var li = document.createElement('li');
                // 先有li 才能赋值
                li.innerHTML = text.value;
                // (2) 添加元素
                // ul.appendChild(li);
                ul.insertBefore(li, ul.children[0]);
            }
        }
    </script>
</body>

</html>
```



## 事件高级

#### 注册事件(绑定事件)

给元素添加事件，称为<span style="color:red;">注册事件</span> 或者 <span style="color:red;">绑定事件</span>

注册事件有两种方式 : <span style="color:red;">传统方式和方法监听注册方式</span>

**传统方式 : **

* 利用on开头的事件`onclick`
* `<button onclick="alert('hi')"></button>`
* 特点 : 注册事件的唯一性
* 同一元素同一事件只能设置一个处理函数，最后注册的处理函数将会覆盖前面的处理函数

**方法监听注册方式**

* `addEventListener()` 
* IE9之前的IE不支持此方法，可食用`attachEvent()`
* 特点 : 同一元素同一事件可以注册多个监听器
* 按注册顺序依次执行

#### addEventListener事件监听方式

```js
eventTarget.addEventListener(type,listener[,userCapture])
```

`eventTarget.addEventListener()` 方法将指定的监听器注册到`eventTarget` (目标对象) 上，当该对象触发指定的事件时，就会执行事件处理函数。

该方法有三个参数 : 

* `type` : 事件类型字符串，比如 `click 、mouseover`，注意不要带on
* `listener` : 事件处理函数，事件发生时，会调用该监听函数
* `useCapture`: 可选参数，是一个布尔值，默认fase

#### 删除事件

**传统注册方式**

`eventTarget.onclick = null`

```js
let buttons = document.querySelectorAll('button');
buttons[0].onclik = function(){
  alert(11);//只弹一次
  this.onclick = null;
}
```

**方法监听注册方式 **

`eventTarget.removeEventListener(type,listener[,useCapture]);`

```js
let buttons = document.querySelectorAll('button');
buttons[0].addEventListener('click', fn);

function fn(){
  alert(11);
  buttons[0].removeEventListener('click',fn);
}

```

#### DOM事件流

事件流描述的是从页面中接受事件的顺序。

事件发生时会在元素节点之间按照特定的顺序传播，这个传播过程即DOM事件流。

**注意 : **

1. JS代码中只执行捕获或者冒泡其中一个阶段。
2. `onclick`和 `attachEvent` 只能得到冒泡阶段。
3. `addEventListener(type,listener[,userCapture])` 第三个参数如果是 `true` ，表示在事件捕获阶段调用事件处理程序；如果是`false` (不写默认为`false`) ，表示在事件冒泡阶段调用事件处理程序。

4. <span style="color:red;">实际开发中更关注事件冒泡。</span>
5. <span style="color:red;">有些事件是没有冒泡的，比如 `onblur、onfocus 、onmouseenter、onmouseleave。`</span>
6. 事件冒泡有时候会带来麻烦。

#### 事件对象

```js
eventTarget.onclick = function(event){}
eventTarget.addEventListener('click',function(event){})
// 这个event就是事件对象，开发中一般写成e或evt
```

官方解释 : event对象代表事件的状态，比如键盘按键的状态、鼠标的位置、鼠标按钮的状态。

简单解释 : 事件发生后，跟事件相关的一系列信息数据的集合都放到这个对象里面。这个对象就是事件对象event，有很多属性和方法。

#### 事件对象的常见属性和方法

| 事件对象属性方法    | 说明                                                     |
| ------------------- | -------------------------------------------------------- |
| `e.target`          | 返回触发事件对象     标准                                |
| `e.srcElement`      | 返回触发事件对象     非标准                              |
| `e.type`            | 返回事件的类型 比如 click 、mouseover 不带 on            |
| `e.cancelBubble`    | 该属性阻止事件冒泡 非标准                                |
| `e.returnValue`     | 该属性阻止默认事件 (默认行为) 非标准    比如不让链接跳转 |
| `e.preventDefault`  | 该方法阻止默认事件 标准                                  |
| `e.stopPropagation` | 阻止冒泡  标准                                           |

**this 和 target的区别**

1. `e.target` 返回的是触发事件的对象
2. `this` 返回的是绑定事件的对象

#### 事件委托(代理、委派)

事件冒泡本身特性，会带来坏处，也会带来<b style="color:red;">好处</b>。

事件委托也称事件代理，在`jQuery` 里面称事件委派。

**事件委托原理**

<span style="color:red;">不是每个节点单独设置事件监听器，而是事件监听器设置在其父节点上，然后利用冒泡原来影响设置每个子节点。</span>

如 : 给 `ul` 注册点击事件，然后利用事件对象的`target`来找到当前点击的`li` ，因为点击`li`，事件会冒泡到`ul`上，`ul`有注册事件，就会触发事件监听器。

**事件委托的作用**

只操作了一次DOM，提高了程序的性能。

#### 常用的鼠标事件

1.  禁止鼠标右键菜单

`contextmenu` 主要控制应该何时显示上下文菜单，主要用于程序取消默认的上下文菜单

```js
document.addEventListener('contextmenu',function(e){
  e.preventDefault();
})
```

2. 禁止鼠标选中(`selectstart` 开始选中)

```js
document.addEventListener('selectstart',function(e){
  e.preventDefault();
})
```

#### 鼠标事件对象

`event` 对象代表事件状态，跟事件相关的一系列信息的集合。现阶段我们主要是用鼠标事件对象`MoseEvent` 和键盘事件对象 `KeyboardEvent`。

| 鼠标事件对象 | 说明                                         |
| ------------ | -------------------------------------------- |
| `e.clientX`  | 返回鼠标相对于浏览器窗口可视区的`X`     坐标 |
| `e.clientY`  | 返回鼠标相对于浏览器窗口可视区的`Y`   坐标   |
| `e.pageX`    | 返回相当于文档页面的 `X` 坐标 IE+9支持       |
| `e.pageY`    | 返回相当于文档页面的 `Y` 坐标 IE+9支持       |
| `e.screenX`  | 返回鼠标相对于电脑屏幕的`X` 坐标             |
| `e.screenY`  | 返回鼠标相对于电脑屏幕的`Y` 坐标             |

```js
document.addEventListener('click',function(e){
  console.log(e.clientX);
  console.log(e.clientY);
})
```



#### 案例

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <style>
        img {
            position: absolute;
            top: 2px;
        }
    </style>
</head>

<body>
    <img src="images/angel.gif" alt="">
    <script>
        var pic = document.querySelector('img');
        document.addEventListener('mousemove', function(e) {
            // 1. mousemove只要我们鼠标移动1px 就会触发这个事件
            // console.log(1);
            // 2.核心原理： 每次鼠标移动，我们都会获得最新的鼠标坐标， 把这个x和y坐标做为图片的top和left 值就可以移动图片
            var x = e.pageX;
            var y = e.pageY;
            console.log('x坐标是' + x, 'y坐标是' + y);
            //3 . 千万不要忘记给left 和top 添加px 单位
            pic.style.left = x - 50 + 'px';
            pic.style.top = y - 40 + 'px';


        });
    </script>
</body>

</html>
```

#### 常用键盘事件

| 键盘事件     | 触发条件                                                     |
| ------------ | ------------------------------------------------------------ |
| `onkeyup`    | 某个键盘按键被松开是触发                                     |
| `onkeydown`  | 某个键盘按键被按下时触发                                     |
| `onkeypress` | 某个键盘按键被按下时 触发 <b style="color:red;">但是它不识别功能按键 比如 ctrl shift. 箭头等</b> |

<b style="color:red;">注意 : </b>

1. 如果使用 `addEventListener` 不需要加 `on`
2. 三个事件的执行顺序是 : `keydown-- keypress--keyup` 

#### 键盘事件对象

| 键盘事件对象属性 | 说明               |
| ---------------- | ------------------ |
| `keyCode`        | 返回该键的ASCII 值 |

<b style="color:red;">注意 : </b>  `onkeydown` 和 `onkeyup` 不区分字母大小写，`onkeypress` 区分字母大小写。在实际开发中，更多使用 `keydown` 和 `keyup` ，它能识别所有的键(包括功能键) `keypress` 不识别功能键，但是 `keyCode` 属性能区分大小写，返回不同的 ASCII值

#### 模拟京东快递单号查询

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <style>
        * {
            margin: 0;
            padding: 0;
        }

        .search {
            position: relative;
            width: 178px;
            margin: 100px;
        }

        .con {
            display: none;
            position: absolute;
            top: -40px;
            width: 171px;
            border: 1px solid rgba(0, 0, 0, .2);
            box-shadow: 0 2px 4px rgba(0, 0, 0, .2);
            padding: 5px 0;
            font-size: 18px;
            line-height: 20px;
            color: #333;
        }

        .con::before {
            content: '';
            width: 0;
            height: 0;
            position: absolute;
            top: 28px;
            left: 18px;
            border: 8px solid #000;
            border-style: solid dashed dashed;
            border-color: #fff transparent transparent;
        }
    </style>
</head>

<body>
    <div class="search">
        <div class="con">123</div>
        <input type="text" placeholder="请输入您的快递单号" class="jd">
    </div>
    <script>
        // 快递单号输入内容时， 上面的大号字体盒子（con）显示(这里面的字号更大）
        // 表单检测用户输入： 给表单添加键盘事件
        // 同时把快递单号里面的值（value）获取过来赋值给 con盒子（innerText）做为内容
        // 如果快递单号里面内容为空，则隐藏大号字体盒子(con)盒子
        var con = document.querySelector('.con');
        var jd_input = document.querySelector('.jd');
        jd_input.addEventListener('keyup', function () {
            // console.log('输入内容啦');
            if (this.value == '') {
                con.style.display = 'none';
            } else {
                con.style.display = 'block';
                con.innerText = this.value;
            }
        })
        // 当我们失去焦点，就隐藏这个con盒子
        jd_input.addEventListener('blur', function () {
            con.style.display = 'none';
        })
        // 当我们获得焦点，就显示这个con盒子
        jd_input.addEventListener('focus', function () {
            if (this.value !== '') {
                con.style.display = 'block';
            }
        })
    </script>
</body>
```



## BOM

 #### 什么是BOM

BOM(Browser Object. Model) 即 浏览器对象模型，它提供了独立于内容而与浏览器窗口进行交互的对象，其核心对象是 `window` 。

#### BOM的构成

BOM 比DOM更大，它包含DOM

|    window    |
| :----------: |
|  `document`  |
|  `location`  |
| `navigation` |
|   `screen`   |
|  `history`   |

<b style="color:red;">window是浏览器的顶级对象，</b>它具有双重角色。

1. 它是js访问浏览器窗口的一个接口。
2. 它是一个全局对象。定义在全局作用域中的变量、函数都会变成`window` 对象的属性和方法。

在调用的时候可以省略`window` ，前面学习的对话框都属于`window` 对象方法，如 `alert()  、prompt() `等。

```js
alert('hello world');

window.alert('hello world');
```

#### 窗口加载事件

```js
window.onload = function(){}
或者
window.addEventListener('load',function(){})
```

`window.onload` 是窗口(页面) 加载事件，当文档内容完全加载完成会触发该事件(包括图像、脚本文件、CSS 文件呢等)，就调用的处理函数。

<b style="color:red;">注意 : </b>

1. 有了 `window.onload` 就可以把JS代码写到页面元素的上方，因为`onload` 是等页面内容全部加载完毕，再去执行处理函数。
2. `window.onload` 传统注册事件只能写一次，如果有多个，会以最后一个`window.onload` 为准。
3. `window.addEventListener('load',function(){})` 这这种写法没有限制。

```js
document.addEventListener('DOMContentLoaded',function(){})
```

`DOMContentLoaded` 事件触发时，仅当 `DOM` 加载完成，不包括样式表、图片、flash等。(IE9以上支持)

如果页面的图片很多的话，从用户访问到`onload` 触发可能需要很长的时间，交互效果就不能实现，必然会影响用户体验，此时用 `DOMContentLoaded` 事件比较合适。

#### 调整窗口大小事件

```js
window.onresize = function(){}
或者 
window.addEventListener('resize',function(){});
```

`window.onresize` 时调整窗口大小加载事件，当触发时就调用处理函数。

<b style="color:red;">注意 : </b>

1. 只要窗口大小发生变化，就会触发这个事件。
2. 我们经常利用这个事件完成响应式布局 。 `window.innerWidth` 当前屏幕宽度。

#### 两种定时器

`window` 对象给我们提供了2个非常好用的方法-`定时器`

* `setTimeout()`
* `setInterval()`

```js
window.setTimeout(调用函数,[延迟的毫秒树]);
```

`setTimeout() ` 方法用于设置一个定时器，该定时器在定时器到期后执行调用函数。

1. `window` 可以省略。
2. 这个调用函数可以直接写函数。
3. 延迟的毫秒数省略默认是0，如果写，必须是毫秒。
4. 因为定时器可能有很多，所以经常给定时器赋值一个标识符。

`setTimeout()` 这个函数称为回调函数 `callback`

#### 停止setTimeout()定时器

```js
window.clearTimeout(timeoutID);
```

#### setInterval() 定时器

```js
window.setInterval(回调函数,[间隔的毫秒数]);
```

`setInterval()` 方法重复调用一个函数，每隔这个时间，就去调用一次回调函数。

#### 停止setInterval() 定时器

```js
window.clearInterval(intervalID);
```

`clearInterval()` 方法取消了先前通过调用`setInterval()` 建立的定时器。

#### JS是单线程

`JavaScript` 语言的一大特点就是单线程也就是说，同一时间只能做一件事。这是因为`JavaScriptt`这门脚本语言诞生的使命所致---`JavaScript` 是为处理页面中用户的交互，以及操作DOM而诞生的。比如我们对某个DOM元素进行添加和删除操作，不能同时进行。应该先进行添加，之后在删除。

单线程就意味着，所有任务需要排队，前一个任务结束，才会执行后一个任务。这样所导致的问题是: 如果JS执行的时间过长，这样就会造成页面的渲染不连贯，导致页面渲染加载阻塞的感觉。

为了解决这个问题，利用多核CPU的计算能力，HTML5提出了`Web Worker` 标准，允许`JavaScript` 脚本创建多个线程。于是，JS出现了同步和异步。

#### 同步和异步

**同步任务 **

同步任务都在主线程上执行形成一个<b style="color:red;">执行栈。</b>

**异步任务**

JS的异步是通过回调函数实现的。

一般而言，异步任务有一下三种类型 : 

1. 普通时间，如 `click、resize` 等
2. 资源加载，如 `load、error`等
3. 定时器，包括`setInterval、setTimeout` 等

异步任务相关<span style="color:red;">回调函数</span>添加到<span style="color:red;">任务队列中</span>(任务队列也称为消息队列)。

#### JS执行机制

1. 先执行执行栈中的同步任务。
2. 异步任务(回调函数)放入任务队列中。
3. 一旦执行栈中的所有同步任务执行完毕，系统就会按次序读取任务队列中的异步任务，于是被读取的异步任务结束等待状态，进入执行栈，开始执行。

由于主线程不断的重复获得任务、执行任务、再获取任务、再执行，所以这种机制被称为<span style="color:red;">事件循环(event loop)</span>

 #### location对象

`window` 对象给我们提供了一个 `location` 属性用于获取或设置窗体的URL，并且可以用于解析URL。

#### URL

URL的一般语法格式为:

```http
protocol://host[:port]/path/[?query]#fragment

http://www.taobao.com/index.html?name=zhou&age=18#link
```

| 组成       | 说明                           |
| ---------- | ------------------------------ |
| `protocol` | 通信协议                       |
| `host`     | 域名                           |
| `port`     | 端口号                         |
| `path`     | 路径                           |
| `query`    | 参数                           |
| `fragment` | 片段 # 后面内容 常见于链接锚点 |

##### location对象的属性

| location对象        | 返回值                                 |
| ------------------- | -------------------------------------- |
| `location.href`     | 获取或者设置整个URL                    |
| `location.host`     | 返回主机(域名) `www.taobao.com`        |
| `location.port`     | 返回端口号 如果未写 返回空字符串       |
| `location.pathname` | 返回路径                               |
| `location.search`   | 返回参数                               |
| `location.hash`     | 返回片段     # 后面内容 常见于链接锚点 |

##### location对象的方法

| location对象方法     | 返回值                                                       |
| -------------------- | ------------------------------------------------------------ |
| `location.assign()`  | 跟 `href` 一样，可以跳转页面(也称重定向页面)                 |
| `location.replace()` | 替换当前页面，因为不记录历史，所以不能后退页面               |
| `location.reload()`  | 重新加载页面，相当于刷新按钮或者 F5 如果参数为true 强制刷新 ctrl + f5 |

#### navigator 对象

可以判断用户是使用PC端浏览器还是移动端浏览器。

#### history 对象

`window` 对象提供了一个`history` 对象，与浏览器历史记录进行交互。该对象包含用户(在浏览器窗口中) 访问过的URL。

| hostory 对象方法 | 作用                                                      |
| ---------------- | --------------------------------------------------------- |
| `back() `        | 后退                                                      |
| `forward()`      | 前进功能                                                  |
| `go(参数)`       | 前进后退功能 参数如果是1 前进1个页面 如果是-1后退一个页面 |

##  元素偏移量offset 系列

#### offset概述

使用`offset` 系列相关属性可以动态的得到该元素的位置(偏移)、大小等。

*  获得元素距离带有定位父元素的位置
* 获得元素自身大小(宽度、高度)
* 注意 : 返回的数值都不带单位

| offset系列属性         | 作用                                                         |
| ---------------------- | ------------------------------------------------------------ |
| `element.offsetParent` | 返回作为该元素带有定位的父级元素 如果父级元素都没有定位则返回body |
| `element.offsetTop`    | 返回元素相对带有定位父元素上方的偏移                         |
| `element.offsetLeft`   | 返回元素相对带有定位父元素左方的偏移                         |
| `element.offsetWidth`  | 返回自身包括`padding`、边框、内容区的宽度，返回数值不带单位  |
| `element.offsetHeight` | 返回自身包括`padding`、边框、内容区的高度，返回数值不带单位  |

#### offset与style 区别

<b style="color:red;">offset</b>

* `offset` 可以得到任意样式表中的样式值
* `offset` 系列获得的数值是没有单位的
* `offsetWidth` 包含`padding + border+width`
* `offsetWidth` 等属性是只读属性，只能获取不能赋值
*  <span style="color:red;">所以，想要获取元素大小位置，用offset更合适</span>

<b style="color:red;">style</b>

* `style` 只能行内样式表中的样式值
* `style.width` 获得的是带有单位的字符串
* `style.width` 获得不包含`padding` 和 `border` 的值
*  `style.width` 是可写属性，可以获取也可以赋值
* <span style="color:red;">所以，想要给元素更改值，用style更合适</span>

## 元素可视区client系列

`client` 系列相关属性可以获取元素可视区的相关信息，通过`client` 的相关属性可以动态得到该元素的边框大小、元素大小等。

#### client 系列相关属性

| client系列属性         | 作用                                                         |
| ---------------------- | ------------------------------------------------------------ |
| `element.clientTop`    | 返回元素上边框的大小                                         |
| `element.clientLeft`   | 返回元素做左边框的大小                                       |
| `element.clientWidth`  | 返回自身包括padding、内容区的宽度，不含边框，返回数值不带单位 |
| `element.clientHeight` | 返回自身包括padding、内容区的高度，不含边框，返回数值不带单位 |

#### 立即执行函数

不需要调用，立马能够自己执行的函数，也可以传递参数，多个立即执行函数，用逗号隔开。

```js
(function(){})() /*或者*/ (function(){}())

// 第二个小括号可以看做是调用函数
(function(a,b){
  console.log(a+b);
})(1,2)
```

<b style="color:red;">主要作用 : </b> 创建一个独立的作用域，避免了命名冲突的问题。

#### flexible.js源码分析

```js
(function flexible(window, document) {
  // 获取的html 的根元素
  var docEl = document.documentElement;
  // dpr 物理像素比
  var dpr = window.devicePixelRatio || 1;

  // adjust body font size    设置body 的字体大小
  function setBodyFontSize() {
    // 如果页面中有body 这一个元素，就设置body大小
    if (document.body) {
      document.body.style.fontSize = 12 * dpr + "px";
    } else {
      // 如果页面中没有body 这个元素，则等页面中主要的DOM元素加载完毕后，再设置body的字体大小
      document.addEventListener("DOMContentLoaded", setBodyFontSize);
    }
  }
  setBodyFontSize();

  // set 1rem = viewWidth / 10    设置html 元素的字体大小
  function setRemUnit() {
    // rem  把html分成24等份
    var rem = docEl.clientWidth / 24;
    docEl.style.fontSize = rem + "px";
  }

  setRemUnit();

  // reset rem unit on page resize    当页面尺寸大小发生变化的时候，要重新设置一下rem 的大小
  window.addEventListener("resize", setRemUnit);
  // pageshow 重新加载页面触发的事件
  window.addEventListener("pageshow", function(e) {
    // e.persisted 返回的事true 就是说如果这个页面事从缓存取过来的页面，也需要重新计算一下rem 的大小
    if (e.persisted) {
      setRemUnit();
    }
  });

  // detect 0.5px supports    用来处理有些移动端的浏览器不支持0.5像素的写法
  if (dpr >= 2) {
    var fakeBody = document.createElement("body");
    var testElement = document.createElement("div");
    testElement.style.border = ".5px solid transparent";
    fakeBody.appendChild(testElement);
    docEl.appendChild(fakeBody);
    if (testElement.offsetHeight === 1) {
      docEl.classList.add("hairlines");
    }
    docEl.removeChild(fakeBody);
  }
})(window, document);
```

## 元素滚动scroll 系列

使用`scroll` 系列的相关属性可以动态的得到该元素的大小、滚动距离等。

#### scroll 属性

| scroll系列属性         | 作用                                           |
| ---------------------- | ---------------------------------------------- |
| `element.scrollTop`    | 返回被卷上去的上侧距离，返回数值不带单位       |
| `element.scrollLeft`   | 返回被卷上去的左侧距离，返回数值不带单位       |
| `element.scrollWidth`  | 返回自身实际的宽度不含边框，返回数值不带单位   |
| `element.scrollHeight` | 返回自身实际的高度，不含边框，返回数值不带单位 |

##### 仿淘宝侧边栏

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <style>
        .slider-bar {
            position: absolute;
            left: 50%;
            top: 300px;
            margin-left: 600px;
            width: 45px;
            height: 130px;
            background-color: pink;
        }
        
        .w {
            width: 1200px;
            margin: 10px auto;
        }
        
        .header {
            height: 150px;
            background-color: purple;
        }
        
        .banner {
            height: 250px;
            background-color: skyblue;
        }
        
        .main {
            height: 1000px;
            background-color: yellowgreen;
        }
        
        span {
            display: none;
            position: absolute;
            bottom: 0;
        }
    </style>
</head>

<body>
    <div class="slider-bar">
        <span class="goBack">返回顶部</span>
    </div>
    <div class="header w">头部区域</div>
    <div class="banner w">banner区域</div>
    <div class="main w">主体部分</div>
    <script>
        //1. 获取元素
        var sliderbar = document.querySelector('.slider-bar');
        var banner = document.querySelector('.banner');
        // banner.offestTop 就是被卷去头部的大小 一定要写到滚动的外面
        var bannerTop = banner.offsetTop
            // 当我们侧边栏固定定位之后应该变化的数值
        var sliderbarTop = sliderbar.offsetTop - bannerTop;
        // 获取main 主体元素
        var main = document.querySelector('.main');
        var goBack = document.querySelector('.goBack');
        var mainTop = main.offsetTop;
        // 2. 页面滚动事件 scroll
        document.addEventListener('scroll', function() {
            // console.log(11);
            // window.pageYOffset 页面被卷去的头部
            // console.log(window.pageYOffset);
            // 3 .当我们页面被卷去的头部大于等于了 172 此时 侧边栏就要改为固定定位
            if (window.pageYOffset >= bannerTop) {
                sliderbar.style.position = 'fixed';
                sliderbar.style.top = sliderbarTop + 'px';
            } else {
                sliderbar.style.position = 'absolute';
                sliderbar.style.top = '300px';
            }
            // 4. 当我们页面滚动到main盒子，就显示 goback模块
            if (window.pageYOffset >= mainTop) {
                goBack.style.display = 'block';
            } else {
                goBack.style.display = 'none';
            }

        })
    </script>
</body>

</html>
```

#### mouseenter和mouseover的区别

* 当鼠标移动到元素上时就会触发`mouseenter` 事件
* 类似`mouseover` 
* `mouseover` 鼠标经过自身盒子会被触发，经过子盒子还会被触发，`mouseenter` 只经过自身盒子才会被触发
* 之所以这样，是因为`mouseenter` 不会冒泡

## 动画函数封装

#### 动画实现原理

<b style="color:red;">核心原理 : </b> 通过定时器`setInterval()` 不断移动盒子位置。

实现步骤 : 

1. 获取盒子当前位置
2. 让盒子在当前位置加上1个移动距离
3. 利用定时器不断重复这个操作
4. 加一个结束定时器条件
5. 注意此元素需要添加定位，才能使用 `element.style.left`

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <style>
        div {
            position: absolute;
            left: 0;
            width: 100px;
            height: 100px;
            background-color: pink;
        }
        
        span {
            position: absolute;
            left: 0;
            top: 200px;
            display: block;
            width: 150px;
            height: 150px;
            background-color: purple;
        }
    </style>
</head>

<body>
    <button>点击夏雨荷才走</button>
    <div></div>
    <span>夏雨荷</span>
    <script>
        // var obj = {};
        // obj.name = 'andy';
        // 简单动画函数封装obj目标对象 target 目标位置
        // 给不同的元素指定了不同的定时器
        function animate(obj, target) {
            // 当我们不断的点击按钮，这个元素的速度会越来越快，因为开启了太多的定时器
            // 解决方案就是 让我们元素只有一个定时器执行
            // 先清除以前的定时器，只保留当前的一个定时器执行
            clearInterval(obj.timer);
            obj.timer = setInterval(function() {
                if (obj.offsetLeft >= target) {
                    // 停止动画 本质是停止定时器
                    clearInterval(obj.timer);
                }
                obj.style.left = obj.offsetLeft + 1 + 'px';

            }, 30);
        }

        var div = document.querySelector('div');
        var span = document.querySelector('span');
        var btn = document.querySelector('button');
        // 调用函数
        animate(div, 300);
        btn.addEventListener('click', function() {
            animate(span, 200);
        })
    </script>
</body>

</html>
```

#### 动画函数封装

注意函数需要传递两个参数，<span style="color:red;">动画对象</span> 和 <span style="color:red;">移动的距离</span> 

```js
function animate(obj, target, callback) {
    // console.log(callback);  callback = function() {}  调用的时候 callback()

    // 先清除以前的定时器，只保留当前的一个定时器执行
    clearInterval(obj.timer);
    obj.timer = setInterval(function() {
        // 步长值写到定时器的里面
        // 把我们步长值改为整数 不要出现小数的问题
        // var step = Math.ceil((target - obj.offsetLeft) / 10);
        var step = (target - obj.offsetLeft) / 10;
        step = step > 0 ? Math.ceil(step) : Math.floor(step);
        if (obj.offsetLeft == target) {
            // 停止动画 本质是停止定时器
            clearInterval(obj.timer);
            // 回调函数写到定时器结束里面
            // if (callback) {
            //     // 调用函数
            //     callback();
            // }
            callback && callback();
        }
        // 把每次加1 这个步长值改为一个慢慢变小的值  步长公式：(目标值 - 现在的位置) / 10
        obj.style.left = obj.offsetLeft + step + 'px';

    }, 15);
}
```

#### 缓动动画原理

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <style>
        div {
            position: absolute;
            left: 0;
            width: 100px;
            height: 100px;
            background-color: pink;
        }
        
        span {
            position: absolute;
            left: 0;
            top: 200px;
            display: block;
            width: 150px;
            height: 150px;
            background-color: purple;
        }
    </style>
</head>

<body>
    <button>点击夏雨荷才走</button>
    <span>夏雨荷</span>
    <script>
        // 缓动动画函数封装obj目标对象 target 目标位置
        // 思路：
        // 1. 让盒子每次移动的距离慢慢变小， 速度就会慢慢落下来。
        // 2. 核心算法：(目标值 - 现在的位置) / 10 做为每次移动的距离 步长
        // 3. 停止的条件是： 让当前盒子位置等于目标位置就停止定时器
        function animate(obj, target) {
            // 先清除以前的定时器，只保留当前的一个定时器执行
            clearInterval(obj.timer);
            obj.timer = setInterval(function() {
                // 步长值写到定时器的里面
                var step = (target - obj.offsetLeft) / 10;
                if (obj.offsetLeft == target) {
                    // 停止动画 本质是停止定时器
                    clearInterval(obj.timer);
                }
                // 把每次加1 这个步长值改为一个慢慢变小的值  步长公式：(目标值 - 现在的位置) / 10
                obj.style.left = obj.offsetLeft + step + 'px';

            }, 15);
        }
        var span = document.querySelector('span');
        var btn = document.querySelector('button');

        btn.addEventListener('click', function() {
                // 调用函数
                animate(span, 500);
            })
            // 匀速动画 就是 盒子是当前的位置 +  固定的值 10 
            // 缓动动画就是  盒子当前的位置 + 变化的值(目标值 - 现在的位置) / 10）
    </script>
</body>

</html>
```

 #### 缓动动画添加回调函数

```js
function animate(obj, target, callback) {
    // console.log(callback);  callback = function() {}  调用的时候 callback()

    // 先清除以前的定时器，只保留当前的一个定时器执行
    clearInterval(obj.timer);
    obj.timer = setInterval(function() {
        // 步长值写到定时器的里面
        // 把我们步长值改为整数 不要出现小数的问题
        // var step = Math.ceil((target - obj.offsetLeft) / 10);
        var step = (target - obj.offsetLeft) / 10;
        step = step > 0 ? Math.ceil(step) : Math.floor(step);
        if (obj.offsetLeft == target) {
            // 停止动画 本质是停止定时器
            clearInterval(obj.timer);
            // 回调函数写到定时器结束里面
            // if (callback) {
            //     // 调用函数
            //     callback();
            // }
            callback && callback();
        }
        // 把每次加1 这个步长值改为一个慢慢变小的值  步长公式：(目标值 - 现在的位置) / 10
        obj.style.left = obj.offsetLeft + step + 'px';

    }, 15);
}
```

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <style>
        .sliderbar {
            position: fixed;
            right: 0;
            bottom: 100px;
            width: 40px;
            height: 40px;
            text-align: center;
            line-height: 40px;
            cursor: pointer;
            color: #fff;
        }
        
        .con {
            position: absolute;
            left: 0;
            top: 0;
            width: 200px;
            height: 40px;
            background-color: purple;
            z-index: -1;
        }
    </style>
    <script src="animate.js"></script>
</head>

<body>
    <div class="sliderbar">
        <span>←</span>
        <div class="con">问题反馈</div>
    </div>

    <script>
        // 1. 获取元素
        var sliderbar = document.querySelector('.sliderbar');
        var con = document.querySelector('.con');
        // 当我们鼠标经过 sliderbar 就会让 con这个盒子滑动到左侧
        // 当我们鼠标离开 sliderbar 就会让 con这个盒子滑动到右侧
        sliderbar.addEventListener('mouseenter', function() {
            // animate(obj, target, callback);
            animate(con, -160, function() {
                // 当我们动画执行完毕，就把 ← 改为 →
                sliderbar.children[0].innerHTML = '→';
            });

        })
        sliderbar.addEventListener('mouseleave', function() {
            // animate(obj, target, callback);
            animate(con, 0, function() {
                sliderbar.children[0].innerHTML = '←';
            });
        })
    </script>
</body>

</html>
```



