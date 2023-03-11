## jQuery概述

#### 常见的JavaScript库

* `jQuery`
* `Prototype`
* `YUI`
* `Dojo`
* `Ext JS`
* `移动端的zepto`

这些库都是对原生`JavaScript`的封装，内部都是使用`JavaScript` 实现的。

## jQuery基本使用

#### jQuery的入口函数

```js
$(function(){
  // 此处是页面DOM加载完成的入口
});
```

```js
$(document).ready(function(){
   // 此处是页面DOM加载完成的入口
});
```

1. 等着DOM结构渲染完毕即可执行内部代码，不必等到所有外部资源加载完成，`jQuery` 帮我们完成了封装。
2. 相当于原生`js` 中的`DOMContentLoaded`
3. 不同于原生`js` 中的 `load` 事件是页面、外部的js文件、css文件、图片加载完毕才执行内部代码。

#### jQuery的顶级对象 $

1. `$` 是 `jQuery` 的别称，在代码中可以使用`jQuery` 代替`$` ，但一般为了方便，通常都直接使用`$`。
2. `$` 是`jQuery` 的顶级对象，相当于原生`JavaScript` 中的`window` 。把元素利用`$` 包装成`jQuery` 对象，就可以调用`jQuery` 的方法。

#### jQuery 对象和DOM对象

DOM 对象与jQuery对象之间是可以相互转换的。

因为原生js比jQuery更大原生的一些属性和方法jQuery没有封装，要想使用这些属性和方法需要把jQuery对象转化为DOM对象才能使用。

1. DOM对象转换为jQuery对象 : `$(DOM对象)`

```js
$('div')
```

2. jQuery 对象转化为DOM对象(两种方式)

```js
$('div')[index] index 是索引号
```

```js
$('div').get(index)
```

## jQuery选择器

#### jQuery基础选择器

原生js获取元素方式很多很杂，而且兼容性情况不一致，因此jQuery做了封装，使获取元素统一标准。

```js
$("选择器") // 里面选择器直接写CSS选择器即可，但是要加引号
```

| 名称       | 用法              | 描述                     |
| ---------- | ----------------- | ------------------------ |
| ID选择器   | `$("#id")`        | 获取指定ID的元素         |
| 全选选择器 | `$("*")`          | 匹配所有元素             |
| 类选择器   | `$(".class")`     | 获取同一类class的元素    |
| 标签选择器 | `$("div")`        | 获取同一类标签的所有元素 |
| 并集选择器 | `$("div,p,li")`   | 选取多个元素             |
| 交集选择器 | `$("li.current")` | 交集元素                 |

#### jQuery设置样式

```js
$('div').css('属性','值');
```

#### 隐式迭代(重要)

遍历内部DOM元素(伪数组形式存储)的过程就叫做 **隐式迭代** 

简单理解 : 给匹配到的所有元素进行循环遍历，执行相应的方法，而不用我们再循环，简化操作。

#### jQuery筛选选择器

| 语法            | 描述                            |
| --------------- | ------------------------------- |
| `$("li:first")` | 获取第一个li元素                |
| `$(li:last)`    | 获取最后一个li元素              |
| `$(li:eq(2))`   | 获取到的li元素中，选择索引号为2 |
| `$(li:odd)`     | 获取奇数的li与元素              |
| `$(li:even)`    | 获取偶数的li元素                |

#### jQuery 筛选方法(重点)

| 语法                             | 说明                                                   |
| -------------------------------- | ------------------------------------------------------ |
| `$("li").parent()`               | 查找父级                                               |
| `$("ul").children("li")`         | 相当于`$("ul>li")`，最近一级(亲儿子)                   |
| `$("ul").find("li")`             | 相当于`$("ul li")`，后代选择器                         |
| `$(".first").siblings(li)`       | 查找兄弟节点，不包括自己本身                           |
| `$(".first").nextAll`            | 查找当前元素之后所有的同辈元素                         |
| `$(".last").prevAll`             | 查找当前元素之前所有的同辈元素                         |
| `$("div").hasClass("protected")` | 检查当前的元素是否含有某个特定的类，如过有，则返回true |
| `$("li").eq(2)`                  | 相当于`$("li:eq(2)")`                                  |

 #### 新浪下拉

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
        
        li {
            list-style-type: none;
        }
        
        a {
            text-decoration: none;
            font-size: 14px;
        }
        
        .nav {
            margin: 100px;
        }
        
        .nav>li {
            position: relative;
            float: left;
            width: 80px;
            height: 41px;
            text-align: center;
        }
        
        .nav li a {
            display: block;
            width: 100%;
            height: 100%;
            line-height: 41px;
            color: #333;
        }
        
        .nav>li>a:hover {
            background-color: #eee;
        }
        
        .nav ul {
            display: none;
            position: absolute;
            top: 41px;
            left: 0;
            width: 100%;
            border-left: 1px solid #FECC5B;
            border-right: 1px solid #FECC5B;
        }
        
        .nav ul li {
            border-bottom: 1px solid #FECC5B;
        }
        
        .nav ul li a:hover {
            background-color: #FFF5DA;
        }
    </style>
    <script src="jquery.min.js"></script>
</head>

<body>
    <ul class="nav">
        <li>
            <a href="#">微博</a>
            <ul>
                <li>
                    <a href="">私信</a>
                </li>
                <li>
                    <a href="">评论</a>
                </li>
                <li>
                    <a href="">@我</a>
                </li>
            </ul>
        </li>
        <li>
            <a href="#">微博</a>
            <ul>
                <li>
                    <a href="">私信</a>
                </li>
                <li>
                    <a href="">评论</a>
                </li>
                <li>
                    <a href="">@我</a>
                </li>
            </ul>
        </li>
        <li>
            <a href="#">微博</a>
            <ul>
                <li>
                    <a href="">私信</a>
                </li>
                <li>
                    <a href="">评论</a>
                </li>
                <li>
                    <a href="">@我</a>
                </li>
            </ul>
        </li>
        <li>
            <a href="#">微博</a>
            <ul>
                <li>
                    <a href="">私信</a>
                </li>
                <li>
                    <a href="">评论</a>
                </li>
                <li>
                    <a href="">@我</a>
                </li>
            </ul>
        </li>
    </ul>
    <script>
        $(function() {
            // 鼠标经过
            $(".nav>li").mouseover(function() {
                // $(this) jQuery 当前元素  this不要加引号
                // show() 显示元素  hide() 隐藏元素
                $(this).children("ul").show();
            });
            // 鼠标离开
            $(".nav>li").mouseout(function() {
                $(this).children("ul").hide();
            })
        })
    </script>
</body>

</html>
```

#### jQuery排他思想

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <script src="jquery.min.js"></script>
</head>

<body>
    <button>快速</button>
    <button>快速</button>
    <button>快速</button>
    <button>快速</button>
    <button>快速</button>
    <button>快速</button>
    <button>快速</button>
    <script>
        $(function() {
            // 1. 隐式迭代 给所有的按钮都绑定了点击事件
            $("button").click(function() {
                // 2. 当前的元素变化背景颜色
                $(this).css("background", "pink");
                // 3. 其余的兄弟去掉背景颜色 隐式迭代
                $(this).siblings("button").css("background", "");
            });
        })
    </script>
</body>

</html>
```

## jQuery样式操作

#### 操作CSS方法

jQuery可以使用css方法来修改简单样式，也可以操作类，修改多个样式。

1. 参数只写属性名，则返回属性值

```js
$(this).css('color');
```

2. 参数是属性名、属性值，逗号分隔，属性必须加引号，值如果是数字可以不用跟单位和引号

```js
$(this).css('color','red');
```

3. 参数可以是对象形式，方便设置多组样式。属性名和属性值用逗号隔开，属性可以不用加引号。

```js
$("div").css({
                width: 400,
                height: 400,
                backgroundColor: "red"
                    // 如果是复合属性则必须采取驼峰命名法，如果值不是数字，则需要加引号
            });
```

#### 设置类样式方法

作用等同于以前的classList，可以操作类样式，注意操作类里面的参数不要加点。

1. 添加类

```js
$('div').addClass('current');
```

2. 移除类

```js
$('div').removeClass('current');
```

3. 切换类

```js
$('div').toggleClass('current');
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
        div {
            width: 150px;
            height: 150px;
            background-color: pink;
            margin: 100px auto;
            transition: all 0.5s;
        }
        
        .current {
            background-color: red;
            transform: rotate(360deg);
        }
    </style>
    <script src="jquery.min.js"></script>
</head>

<body>
    <div class="current"></div>
    <script>
        $(function() {
            // 1. 添加类 addClass()
            // $("div").click(function() {
            //     // $(this).addClass("current");
            // });
            // 2. 删除类 removeClass()
            // $("div").click(function() {
            //     $(this).removeClass("current");
            // });
            // 3. 切换类 toggleClass()
            $("div").click(function() {
                $(this).toggleClass("current");
            });
        })
    </script>
</body>

</html>
```

#### tab栏案例

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
        
        li {
            list-style-type: none;
        }
        
        .tab {
            width: 978px;
            margin: 100px auto;
        }
        
        .tab_list {
            height: 39px;
            border: 1px solid #ccc;
            background-color: #f1f1f1;
        }
        
        .tab_list li {
            float: left;
            height: 39px;
            line-height: 39px;
            padding: 0 20px;
            text-align: center;
            cursor: pointer;
        }
        
        .tab_list .current {
            background-color: #c81623;
            color: #fff;
        }
        
        .item_info {
            padding: 20px 0 0 20px;
        }
        
        .item {
            display: none;
        }
    </style>
    <script src="jquery.min.js"></script>
</head>

<body>
    <div class="tab">
        <div class="tab_list">
            <ul>
                <li class="current">商品介绍</li>
                <li>规格与包装</li>
                <li>售后保障</li>
                <li>商品评价（50000）</li>
                <li>手机社区</li>
            </ul>
        </div>
        <div class="tab_con">
            <div class="item" style="display: block;">
                商品介绍模块内容
            </div>
            <div class="item">
                规格与包装模块内容
            </div>
            <div class="item">
                售后保障模块内容
            </div>
            <div class="item">
                商品评价（50000）模块内容
            </div>
            <div class="item">
                手机社区模块内容
            </div>

        </div>
    </div>
    <script>
        $(function() {
            // 1.点击上部的li，当前li 添加current类，其余兄弟移除类
            $(".tab_list li").click(function() {
                // 链式编程操作
                $(this).addClass("current").siblings().removeClass("current");
                // 2.点击的同时，得到当前li 的索引号
                var index = $(this).index();
                console.log(index);
                // 3.让下部里面相应索引号的item显示，其余的item隐藏
                $(".tab_con .item").eq(index).show().siblings().hide();
            });
        })
    </script>
</body>

</html>
```

#### 类操作与className区别

原生JS中className会覆盖元素原先里面的类名。

jQuery里面类操作只是对指定类进行操作，不影响原先的类名。

## jQuery效果

jQuery封装了很多动画效果，最常见的如下 :

**显示隐藏**

```js
show()
hide()
toggle()
```

**滑动**

```js
slideDown()
slideUp()
slideToggle()
```

**淡入淡出**

```js
fadeIn()
fadeOut()
fadeToggle()
fadeTo()
```

**自定义动画**

```js
animate()
```

#### 显示隐藏效果

**显示语法规范**

```js
show([speed,[easing],[fn]])
```

**显示隐藏参数**

1⃣️ 参数可以省略，无动画显示

2⃣️ speed : 三种预定速度之一的字符串`("show", "normal", "fast")` 或表示动画时长的毫秒数(如 : 100)

3⃣️ easing : (Optional) 用来指定切换效果 ，默认`"swing"` ，可用 `"linear"`

4⃣️ fn : 回调函数，在动画执行完成时执行的函数，每隔元素执行一次



#### 滑动效果

```js
slideDown([speed,[easing],[fn]]);
```

#### 事件切换

```js
hover([over,]out)
```

1. `over` : 鼠标移到元素上要触发的函数(相当于`mouseenter`)
2. `out` : 鼠标移出元素要触发的函数(相当于 `mouselevave`)

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
            width: 150px;
            height: 300px;
            background-color: pink;
            display: none;
        }
    </style>
    <script src="jquery.min.js"></script>
</head>

<body>
    <button>下拉滑动</button>
    <button>上拉滑动</button>
    <button>切换滑动</button>
    <div></div>
    <script>
        $(function() {
            $("button").eq(0).click(function() {
                // 下滑动 slideDown()
                $("div").slideDown();
            })
            $("button").eq(1).click(function() {
                // 上滑动 slideUp()
                $("div").slideUp(500);


            })
            $("button").eq(2).click(function() {
                // 滑动切换 slideToggle()

                $("div").slideToggle(500);

            });

        });
    </script>
</body>

</html>
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
        * {
            margin: 0;
            padding: 0;
        }
        
        li {
            list-style-type: none;
        }
        
        a {
            text-decoration: none;
            font-size: 14px;
        }
        
        .nav {
            margin: 100px;
        }
        
        .nav>li {
            position: relative;
            float: left;
            width: 80px;
            height: 41px;
            text-align: center;
        }
        
        .nav li a {
            display: block;
            width: 100%;
            height: 100%;
            line-height: 41px;
            color: #333;
        }
        
        .nav>li>a:hover {
            background-color: #eee;
        }
        
        .nav ul {
            display: none;
            position: absolute;
            top: 41px;
            left: 0;
            width: 100%;
            border-left: 1px solid #FECC5B;
            border-right: 1px solid #FECC5B;
        }
        
        .nav ul li {
            border-bottom: 1px solid #FECC5B;
        }
        
        .nav ul li a:hover {
            background-color: #FFF5DA;
        }
    </style>
    <script src="jquery.min.js"></script>
</head>

<body>
    <ul class="nav">
        <li>
            <a href="#">微博</a>
            <ul>
                <li>
                    <a href="">私信</a>
                </li>
                <li>
                    <a href="">评论</a>
                </li>
                <li>
                    <a href="">@我</a>
                </li>
            </ul>
        </li>
        <li>
            <a href="#">微博</a>
            <ul>
                <li>
                    <a href="">私信</a>
                </li>
                <li>
                    <a href="">评论</a>
                </li>
                <li>
                    <a href="">@我</a>
                </li>
            </ul>
        </li>
        <li>
            <a href="#">微博</a>
            <ul>
                <li>
                    <a href="">私信</a>
                </li>
                <li>
                    <a href="">评论</a>
                </li>
                <li>
                    <a href="">@我</a>
                </li>
            </ul>
        </li>
        <li>
            <a href="#">微博</a>
            <ul>
                <li>
                    <a href="">私信</a>
                </li>
                <li>
                    <a href="">评论</a>
                </li>
                <li>
                    <a href="">@我</a>
                </li>
            </ul>
        </li>
    </ul>
    <script>
        $(function() {
            // 鼠标经过
            // $(".nav>li").mouseover(function() {
            //     // $(this) jQuery 当前元素  this不要加引号
            //     // show() 显示元素  hide() 隐藏元素
            //     $(this).children("ul").slideDown(200);
            // });
            // // 鼠标离开
            // $(".nav>li").mouseout(function() {
            //     $(this).children("ul").slideUp(200);
            // });
            // 1. 事件切换 hover 就是鼠标经过和离开的复合写法
            // $(".nav>li").hover(function() {
            //     $(this).children("ul").slideDown(200);
            // }, function() {
            //     $(this).children("ul").slideUp(200);
            // });
            // 2. 事件切换 hover  如果只写一个函数，那么鼠标经过和鼠标离开都会触发这个函数
            $(".nav>li").hover(function() {
                $(this).children("ul").slideToggle();
            });
        })
    </script>
</body>

</html>
```

#### 动画队列及其停止排队方法

**动画或效果队列**

动画或效果一旦触发就会执行，如果多次触发，就会造成多个动画或者效果排队执行。

**停止排队**

```js
stop()
```

1. `stop` 方法用于停止动画或者效果
2. 注意 : `stop()` 写到动画或者效果的前面，相当于停止结束上一次的动画。

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
        
        li {
            list-style-type: none;
        }
        
        a {
            text-decoration: none;
            font-size: 14px;
        }
        
        .nav {
            margin: 100px;
        }
        
        .nav>li {
            position: relative;
            float: left;
            width: 80px;
            height: 41px;
            text-align: center;
        }
        
        .nav li a {
            display: block;
            width: 100%;
            height: 100%;
            line-height: 41px;
            color: #333;
        }
        
        .nav>li>a:hover {
            background-color: #eee;
        }
        
        .nav ul {
            display: none;
            position: absolute;
            top: 41px;
            left: 0;
            width: 100%;
            border-left: 1px solid #FECC5B;
            border-right: 1px solid #FECC5B;
        }
        
        .nav ul li {
            border-bottom: 1px solid #FECC5B;
        }
        
        .nav ul li a:hover {
            background-color: #FFF5DA;
        }
    </style>
    <script src="jquery.min.js"></script>
</head>

<body>
    <ul class="nav">
        <li>
            <a href="#">微博</a>
            <ul>
                <li>
                    <a href="">私信</a>
                </li>
                <li>
                    <a href="">评论</a>
                </li>
                <li>
                    <a href="">@我</a>
                </li>
            </ul>
        </li>
        <li>
            <a href="#">微博</a>
            <ul>
                <li>
                    <a href="">私信</a>
                </li>
                <li>
                    <a href="">评论</a>
                </li>
                <li>
                    <a href="">@我</a>
                </li>
            </ul>
        </li>
        <li>
            <a href="#">微博</a>
            <ul>
                <li>
                    <a href="">私信</a>
                </li>
                <li>
                    <a href="">评论</a>
                </li>
                <li>
                    <a href="">@我</a>
                </li>
            </ul>
        </li>
        <li>
            <a href="#">微博</a>
            <ul>
                <li>
                    <a href="">私信</a>
                </li>
                <li>
                    <a href="">评论</a>
                </li>
                <li>
                    <a href="">@我</a>
                </li>
            </ul>
        </li>
    </ul>
    <script>
        $(function() {
            // 鼠标经过
            // $(".nav>li").mouseover(function() {
            //     // $(this) jQuery 当前元素  this不要加引号
            //     // show() 显示元素  hide() 隐藏元素
            //     $(this).children("ul").slideDown(200);
            // });
            // // 鼠标离开
            // $(".nav>li").mouseout(function() {
            //     $(this).children("ul").slideUp(200);
            // });
            // 1. 事件切换 hover 就是鼠标经过和离开的复合写法
            // $(".nav>li").hover(function() {
            //     $(this).children("ul").slideDown(200);
            // }, function() {
            //     $(this).children("ul").slideUp(200);
            // });
            // 2. 事件切换 hover  如果只写一个函数，那么鼠标经过和鼠标离开都会触发这个函数
            $(".nav>li").hover(function() {
                // stop 方法必须写到动画的前面
                $(this).children("ul").stop().slideToggle();
            });
        })
    </script>
</body>

</html>
```

#### 淡入淡出效果

**渐进方式调整到指定的不透明度**

```js
fadeTo([[speed],opacity, [easing], [fn]])
```

* `opacity` 透明度必须写，取值0-1之间

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
            width: 150px;
            height: 300px;
            background-color: pink;
            display: none;
        }
    </style>
    <script src="jquery.min.js"></script>
</head>

<body>
    <button>淡入效果</button>
    <button>淡出效果</button>
    <button>淡入淡出切换</button>
    <button>修改透明度</button>
    <div></div>
    <script>
        $(function() {
            $("button").eq(0).click(function() {
                // 淡入 fadeIn()
                $("div").fadeIn(1000);
            })
            $("button").eq(1).click(function() {
                // 淡出 fadeOut()
                $("div").fadeOut(1000);

            })
            $("button").eq(2).click(function() {
                // 淡入淡出切换 fadeToggle()
                $("div").fadeToggle(1000);

            });
            $("button").eq(3).click(function() {
                //  修改透明度 fadeTo() 这个速度和透明度要必须写
                $("div").fadeTo(1000, 0.5);

            });


        });
    </script>
</body>

</html>
```

#### 自定义动画 animate

```js
animate(params,[speed],[easing],[fn])
```

* `params` : 想要更改的样式属性，以对象形式传递，必须写。属性名可以不带引号，如果是复合属性则采取驼峰命名法 。其余参数可以省略。

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <script src="jquery.min.js"></script>
    <style>
        div {
            position: absolute;
            width: 200px;
            height: 200px;
            background-color: pink;
        }
    </style>
</head>

<body>
    <button>动起来</button>
    <div></div>
    <script>
        $(function() {
            $("button").click(function() {
                $("div").animate({
                    left: 500,
                    top: 300,
                    opacity: .4,
                    width: 500
                }, 500);
            })
        })
    </script>
</body>

</html>
```

