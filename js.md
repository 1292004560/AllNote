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
node.cloneNode()
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
5. <span style="color:red;">有些事件是没有冒泡的，比如 `onblur、onfocus 、onmouseenter、onmouselevave。`</span>
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







