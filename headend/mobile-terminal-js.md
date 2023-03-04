## 触屏事件

#### 触屏事件概述

移动端浏览器兼容性较好，不需要考虑`JS` 的兼容问题，可以放心使用原生`JS` 书写效果，但是移动端也有自己独特的地方。如 : <span style="color:red;">触屏事件 (也称触摸事件)</span> 。

`touch` 对象代表一个触摸点。触摸点可能是一根手指，也可能是一根触摸笔。触摸事件可响应用户手指(或触控笔)对屏幕或触控板的操作。

常见触屏事件 : 

| 触屏touch事件 | 说明                          |
| ------------- | ----------------------------- |
| `touchstart`  | 手指触摸到一个DOM元素时触发   |
| `touchmove`   | 手指在一个DOM元素上滑动时触发 |
| `touchend`    | 手指从一个DOM元素上移开时触发 |

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
            width: 100px;
            height: 100px;
            background-color: pink;
        }
    </style>
</head>

<body>
    <div></div>
    <script>
        // 1. 获取元素
        // 2. 手指触摸DOM元素事件
        var div = document.querySelector('div');
        div.addEventListener('touchstart', function() {
            console.log('我摸了你');

        });
        // 3. 手指在DOM元素身上移动事件
        div.addEventListener('touchmove', function() {
            console.log('我继续摸');

        });
        // 4. 手指离开DOM元素事件
        div.addEventListener('touchend', function() {
            console.log('轻轻的我走了');

        });
    </script>
</body>

</html>
```

#### 触摸事件对象(TouchEvent)

`TouchEvent` 是一类描述手指在触摸平面的状态变化的事件。这类事件用于描述一个或多个触点，使开发者可以检测触点的移动，触点的增加和减少，等等。

`touchstart、touchmove、touchend` 三个事件都有各自的事件对象

触摸事件对象重点看三个常见对象列表 :

| 触摸列表        | 说明                                              |
| --------------- | ------------------------------------------------- |
| `touches`       | 正在触摸屏幕的所有手指的一个列表                  |
| `targetTouches` | 正在触摸当前DOM元素上的手指的一个列表             |
| `changeTouches` | 手指状态发生了改变的列表，从无导游，从有到无 变化 |

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
            width: 100px;
            height: 100px;
            background-color: pink;
        }
    </style>
</head>

<body>
    <div></div>
    <script>
        // 触摸事件对象
        // 1. 获取元素
        // 2. 手指触摸DOM元素事件
        var div = document.querySelector('div');
        div.addEventListener('touchstart', function(e) {
            // console.log(e);
            // touches 正在触摸屏幕的所有手指的列表 
            // targetTouches 正在触摸当前DOM元素的手指列表
            // 如果侦听的是一个DOM元素，他们两个是一样的
            // changedTouches 手指状态发生了改变的列表 从无到有 或者 从有到无
            // 因为我们一般都是触摸元素 所以最经常使用的是 targetTouches
            console.log(e.targetTouches[0]);
            // targetTouches[0] 就可以得到正在触摸dom元素的第一个手指的相关信息比如 手指的坐标等等


        });
        // 3. 手指在DOM元素身上移动事件
        div.addEventListener('touchmove', function() {


        });
        // 4. 手指离开DOM元素事件
        div.addEventListener('touchend', function(e) {
            // console.log(e);
            // 当我们手指离开屏幕的时候，就没有了 touches 和 targetTouches 列表
            // 但是会有 changedTouches


        });
    </script>
</body>

</html>
```

#### 移动端拖动元素

1. `touchstart、touchmove、touchend ` 可以实现拖动元素
2. 拖动元素需要当前手指的坐标值，可以使用`targetTouch[0]` 里面的`pageX` 和 `pageY`
3. 移动端拖动原理 : 手指移动中，计算出手指移动的距离。然后用盒子原来的位置 + 手指移动的距离
4. 手指移动的距离 : 手指滑动中的位置减去手指刚触摸的位置

触摸元素三部曲 :

1⃣️ : 触摸元素`touchstart` : 获取手指初始坐标，同时获得盒子原来的位置

2⃣️ : 移动手指`touchmove` : 计算手指滑动距离，并且移动盒子

3⃣️ : 离开手指`touched` :

<span style="color:red;">注意  : 手指移动也会触发滚动屏幕所有这里要阻止默认的屏幕滚动`e.preventDefault()`</span>

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
    </style>
</head>

<body>
    <div></div>
    <script>
        // （1） 触摸元素 touchstart：  获取手指初始坐标，同时获得盒子原来的位置
        // （2） 移动手指 touchmove：  计算手指的滑动距离，并且移动盒子
        // （3） 离开手指 touchend:
        var div = document.querySelector('div');
        var startX = 0; //获取手指初始坐标
        var startY = 0;
        var x = 0; //获得盒子原来的位置
        var y = 0;
        div.addEventListener('touchstart', function(e) {
            //  获取手指初始坐标
            startX = e.targetTouches[0].pageX;
            startY = e.targetTouches[0].pageY;
            x = this.offsetLeft;
            y = this.offsetTop;
        });

        div.addEventListener('touchmove', function(e) {
            //  计算手指的移动距离： 手指移动之后的坐标减去手指初始的坐标
            var moveX = e.targetTouches[0].pageX - startX;
            var moveY = e.targetTouches[0].pageY - startY;
            // 移动我们的盒子 盒子原来的位置 + 手指移动的距离
            this.style.left = x + moveX + 'px';
            this.style.top = y + moveY + 'px';
            e.preventDefault(); // 阻止屏幕滚动的默认行为
        });
    </script>
</body>

</html>
```

#### classList属性

`classList` 属性是HTML5新增的一个属性，返回元素的类名。但是`ie10` 以上版本支持。

该属性用于在元素中添加，移除及切换css类。

**添加类**

```js
element.classList.add('类名');
```

**移除类**

```js
element.classList.remove('类名');
```

**切换类**

```js
element.classList.toggle('类名');
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
        .bg {
            background-color: black;
        }
    </style>
</head>

<body>
    <div class="one two"></div>
    <button> 开关灯</button>
    <script>
        // classList 返回元素的类名
        var div = document.querySelector('div');
        // console.log(div.classList[1]);
        // 1. 添加类名  是在后面追加类名不会覆盖以前的类名 注意前面不需要加.
        div.classList.add('three');
        // 2. 删除类名
        div.classList.remove('one');
        // 3. 切换类
        var btn = document.querySelector('button');
        btn.addEventListener('click', function() {
            document.body.classList.toggle('bg');
        })
    </script>
</body>

</html>
```



 