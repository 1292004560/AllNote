## 作用域

### 局部作用域

局部作用域分为函数作用域和块级作用域。

**块作用域 : **

在JavaScript中使用 {} 包裹的代码称为代码块，代码块内部声明的变量外部<span style="color:red;">有可能</span> 无法访问。

1. `let` 声明的变量会产生块作用域，`var` 不会产生块作用域
2. `const` 声明的变量也会产生块作用域

### 全局作用域

`<script>` 标签和`.js` 文件的最外层就是所谓的全局作用域。

**注意 : **

1. 为`window`  对象动态添加的属性默认也是全局作用域，不推荐！
2. 函数中未使用任何关键字声明的变量为全局作用域，不推荐！
3. 尽可能少的声明全局变量，防止全局变量被污染

 ### 作用域链

作用域链本质上是底层的变量查找机制。

1. 在函数被执行时，会优先查找当前函数作用域中的变量
2. 如果当前作用域查找不到则会依次逐级查找父级作用域直到全局作用域

**总结 : **

1. 嵌套关系的作用域串联起来形成了作用域链
2. 子作用域能够访问父作用域，父作用域无法访问子作用域

## 垃圾回收机制

### 内存生命周期

1. 内存分配 : 当我们声明变量、函数、对象的时候，系统会自动为其分配内存
2. 内存使用 : 即读写内存，也就是使用变量、函数等
3. 内存回收 : 使用完毕，由5垃圾回收器自动回收不再使用的内存

**说明 : **

* 全局变量一般不会回收(关闭页面回收)
* 一般情况下局部变量的值，不用了，会被自动回收掉

**内存泄露 : ** 程序中分配的内存由于某种原因程序未释放叫做内存泄露

### 垃圾回收算法说明

* 引用计数法

有致命问题 : 嵌套引用

* 标记清除法

## 闭包

**概念 : ** 一个函数对周围状态的引用捆绑在一起，内层函数中访问其外层函数的作用域

**简单理解 : ** 闭包 = 内层函数 + 外层函数的变量

```js
function outer(){
  const a = 1
  function f(){
    console.log(a)
  }
  f()
}
outer()
```

### 常见闭包形式

 ```js
 function outer(){
   const a = 1
   function f(){
     console.log(a)
   }
  return fn
 }
 
 // outer() === fn === function fn(){}
 // const fun = function fn(){}
 const fun = outer()
 fun() // 调用函数
 ```

## 函数进阶

### 函数提升

```html
<script>
		fn()
  	
  	function fn(){
      console.log('函数提升')
    }
  
  
  var fun = function(){
    console.log('函数表达式')
  }
</script>
```

### 函数参数

1. 动态参数

```js
function getSum(){
  
  let sum = 0;
  for(let i = 0; i < arguments.length; i++){
    sum += arguments[i]
  }
  return sum
}
```



2. 剩余参数

```js
function getSum(...arr){
  let sum = 0;
  for(let i = 0; i < arguments.length; i++){
    sum += arr[i]
  }
  return sum
}
// 剩余参数是一个真数组
function getSum(a,b,...arr){
  
}

// 求数组最大值
const arr = [1,2,3,4,5]
console.log(Math.max(...arr))

// 合并数组
const arr1 = [1,2,3,4,5]
const arr2 = [1,2,3,4,5]
const arr = [...arr1,...arr2]
console.log(arr)

剩余参数 : 函数参数使用，得到真数组
展开运算符 : 数组中使用，数组展开
```

### 箭头函数

```js
// 箭头函数主要用作函数表达式
const fn = ()=>{
  // 只有一个参数的时候小括号可以省略
  console.log(123)
  // 只有一行代码时可省略大括号
}

const sum = x => x + x

// 箭头函数可以返回一个对象
const fn = (uname) => ({uname: uname})
fn()
// 箭头喊护士不能使用arguments
// 箭头函数不能作为构造对象 
```

### 箭头函数this

```js
const obj = {
  uname: 'z',
  sayHi:() => {
    console.log(this) //this指向window
  }
}
obj.sayHi()
```

## 解构赋值

### 数组结构

数组解构是将数组的单元值快速批量赋值给一系列变量的简洁语法。

```js
const arr = [1,2,3,4]
const [a,b,c,d] = arr

// 交换变量
let a = 1
let b = 2;
[b,a] = [a,b]
```

### 对象解构

```js
const obj = {
  uname: 'zsp',
  age: 20
}
// 要相同
const {uname, age} = obj
```

## 模版字符串

```js
// 内容可以出现换行符
let str = `<ul>
							<li></li>
						</ul>`

// 变量拼接
let people = 'zhoushuiping';
let out =`{$people} 你好`
```

## 对象简化写法

```js
const school = {
  name,
  change,
  imporve:(){
  console.log();
}
}
```



