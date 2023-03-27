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

## jQuery属性操作

####  设置或获取元素固有属性值prop()

**获取属性方法**

```js
prop("属性")
```

**设置属性语法**

```js
prop("属性", "属性值")
```

#### 设置或获取元素自定义属性值attr()

**获取属性语法**

```js
attr("属性") // 类似原生的getAtrribute()
```

**设置属性语法**

```js
attr("属性","属性值")
```

#### 数据缓存data()

`data()` 方法可以在指定的元素上存取数据，并不会修改DOM元素结构。一旦页面刷新，之前存放的数据将被移除。

**附加数据语法**

```js
data("name","value")// 向被选元素附加数据
```

**获取数据语法**

```js
data("name") //向被选元素获取数据
```

同时，还可以读取HTML5自定义属性`data-index`，得到的是数字型

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
    <a href="http://www.itcast.cn" title="都挺好">都挺好</a>
    <input type="checkbox" name="" id="" checked>
    <div index="1" data-index="2">我是div</div>
    <span>123</span>
    <script>
        $(function() {
            //1. element.prop("属性名") 获取元素固有的属性值
            console.log($("a").prop("href"));
            $("a").prop("title", "我们都挺好");
            $("input").change(function() {
                console.log($(this).prop("checked"));

            });
            // console.log($("div").prop("index"));
            // 2. 元素的自定义属性 我们通过 attr()
            console.log($("div").attr("index"));
            $("div").attr("index", 4);
            console.log($("div").attr("data-index"));
            // 3. 数据缓存 data() 这个里面的数据是存放在元素的内存里面
            $("span").data("uname", "andy");
            console.log($("span").data("uname"));
            // 这个方法获取data-index h5自定义属性 第一个 不用写data-  而且返回的是数字型
            console.log($("div").data("index"));





        })
    </script>
</body>

</html>
```

## jQuery 内容文本值

主要针对元素的内容还有表单的值操作

#### 普通元素内容html()

```js
html()  // 获取元素的内容 相当于原生innerHTML
```

```js
html("内容") //设置元素内容
```

#### 普通元素文本内容text()

```js
text() // 获取内容 相当于原生的 innerHTML
```

```js
text("内容")
```

#### 表单的值val()

```js
val() //相当于 原生value
```

```js
val("内容")
```

## jQuery 元素操作

主要是遍历、创建、添加、删除元素

#### 遍历元素

```js
$("div").each(function(index, domElement){})
```

1. `each()` 方法变量匹配的每一个元素。主要用DOM处理
2. 里面的回调函数有2个参数 : index 是每个元素的索引号，domElement 是每隔DOM元素对象，不是jQuery对象
3. 所以要使用jQuery方法，需要把这个dom对象转换为jQuery对象`$(domElement)`

```js
$.each(object, function(index, element){})
```

1. `$.each()` 方法可用于遍历任何对象。主要用于数据处理，比如数组，对象
2. 里面的函数有2个参数 : index 是每个元素的索引号；element遍历内容

#### 创建元素

```js
var li = $("<li></li>");

element.append(li); //内部添加
$("ul").append(li); // 内部添加 放在元素最后
$("ul").prepend(li); // 内部添加 放在最前面

// 外部添加
element.after("内容");
element.before("内容");
```

#### 删除元素

```js
element.remove(); //删除匹配的元素(本身)

element.empty(); //删除匹配的元素集合中所有子节点

element.html(""); //清空匹配的元素内容
```

## jQuery 尺寸位置操作

#### jQuery尺寸

| 语法                                | 用法                                                   |
| ----------------------------------- | ------------------------------------------------------ |
| `width()/height()`                  | 取得匹配元素宽度和高度值 只算 `width/height`           |
| `innerWidth()/ innderHeight()`      | 取得匹配元素宽度和高度值包含`padding`                  |
| `outerWidth()/ outerHeight()`       | 取得匹配元素宽度和高度值包含`padding、border`          |
| `outWidth(true)/ outerHeight(true)` | 取得匹配元素宽度和高度值包含`padding、border 、margin` |

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
            width: 200px;
            height: 200px;
            background-color: pink;
            padding: 10px;
            border: 15px solid red;
            margin: 20px;
        }
    </style>
    <script src="jquery.min.js"></script>
</head>

<body>
    <div></div>
    <script>
        $(function() {
            // 1. width() / height() 获取设置元素 width和height大小 
            console.log($("div").width());
            // $("div").width(300);

            // 2. innerWidth() / innerHeight()  获取设置元素 width和height + padding 大小 
            console.log($("div").innerWidth());

            // 3. outerWidth()  / outerHeight()  获取设置元素 width和height + padding + border 大小 
            console.log($("div").outerWidth());

            // 4. outerWidth(true) / outerHeight(true) 获取设置 width和height + padding + border + margin
            console.log($("div").outerWidth(true));


        })
    </script>
</body>

</html>
```

#### jQuery位置

位置主要有三个 : `offset()、position()、scrollTop()/ scrollLeft()`

**offset() 设置或获取元素偏移**

1. `offset()` 方法设置或返回被选元素相对于文档的偏移坐标，跟父级没有关系。
2. 该方法有两个属性`left、top` ，`offset().top` 用于获取距离文档顶部的距离，`offset().left` 用于获取距离文档左侧的距离。
3. 可以设置元素的偏移 :  `offset({top:10, left:30});`

**position() 获取元素偏移**

1. `position()` 方法用于返回被选元素相对于带有定位的父级偏移坐标，如果父级都没有定位，则以文档为准。
2. 这个方法只能获取不能设置。

**scrollTop()/scroLeft() 设置或获取元素被卷曲的头部和左侧**

* `scrollTop()` 方法设置或返回被选元素被卷去的头部。

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <style>
        body {
            height: 2000px;
        }
        
        .back {
            position: fixed;
            width: 50px;
            height: 50px;
            background-color: pink;
            right: 30px;
            bottom: 100px;
            display: none;
        }
        
        .container {
            width: 900px;
            height: 500px;
            background-color: skyblue;
            margin: 400px auto;
        }
    </style>
    <script src="jquery.min.js"></script>
</head>

<body>
    <div class="back">返回顶部</div>
    <div class="container">
    </div>
    <script>
        $(function() {
            $(document).scrollTop(100);
            // 被卷去的头部 scrollTop()  / 被卷去的左侧 scrollLeft()
            // 页面滚动事件
            var boxTop = $(".container").offset().top;
            $(window).scroll(function() {
                // console.log(11);
                console.log($(document).scrollTop());
                if ($(document).scrollTop() >= boxTop) {
                    $(".back").fadeIn();
                } else {
                    $(".back").fadeOut();
                }
            });
            // 返回顶部
            $(".back").click(function() {
                // $(document).scrollTop(0);
                $("body, html").stop().animate({
                    scrollTop: 0
                });
                // $(document).stop().animate({
                //     scrollTop: 0
                // }); 不能是文档而是 html和body元素做动画
            })
        })
    </script>
</body>

</html>
```

## jQuery 事件

#### jQuery事件注册

**单个事件注册**

```js
element.事件(function(){})
```

```js
$("div").click(function(){})
```

其他事件和原生基本一致。

如`mouseover、mouseout、blur、focus、change、keydown、keyup、resize、scroll`

#### 事件处理on() 绑定事件

```js
element.on(events,[seletor], fn)
```

1. `events`  一个或多个用空格分隔的事件类型，如 `click、keydown`
2. `selector` 元素的子元素选择器
3. `fn`  回调函数 即绑定在元素身上的侦听函数

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
        
        .current {
            background-color: purple;
        }
    </style>
    <script src="jquery.min.js"></script>
</head>

<body>
    <div></div>
    <ul>
        <li>我们都是好孩子</li>
        <li>我们都是好孩子</li>
        <li>我们都是好孩子</li>
        <li>我们都是好孩子</li>
        <li>我们都是好孩子</li>
    </ul>
    <ol>

    </ol>
    <script>
        $(function() {
            // 1. 单个事件注册
            // $("div").click(function() {
            //     $(this).css("background", "purple");
            // });
            // $("div").mouseenter(function() {
            //     $(this).css("background", "skyblue");
            // });

            // 2. 事件处理on
            // (1) on可以绑定1个或者多个事件处理程序
            // $("div").on({
            //     mouseenter: function() {
            //         $(this).css("background", "skyblue");
            //     },
            //     click: function() {
            //         $(this).css("background", "purple");
            //     },
            //     mouseleave: function() {
            //         $(this).css("background", "blue");
            //     }
            // });
            $("div").on("mouseenter mouseleave", function() {
                $(this).toggleClass("current");
            });
            // (2) on可以实现事件委托（委派）
            // $("ul li").click();
            $("ul").on("click", "li", function() {
                alert(11);
            });
            // click 是绑定在ul 身上的，但是 触发的对象是 ul 里面的小li
            // (3) on可以给未来动态创建的元素绑定事件
            // $("ol li").click(function() {
            //     alert(11);
            // })
            $("ol").on("click", "li", function() {
                alert(11);
            })
            var li = $("<li>我是后来创建的</li>");
            $("ol").append(li);
        })
    </script>
</body>
</html>
```

#### 发布微博案例

```html
<!DOCTYPE html>
<html>

<head lang="en">
    <meta charset="UTF-8">
    <title></title>
    <style>
        * {
            margin: 0;
            padding: 0
        }
        
        ul {
            list-style: none
        }
        
        .box {
            width: 600px;
            margin: 100px auto;
            border: 1px solid #000;
            padding: 20px;
        }
        
        textarea {
            width: 450px;
            height: 160px;
            outline: none;
            resize: none;
        }
        
        ul {
            width: 450px;
            padding-left: 80px;
        }
        
        ul li {
            line-height: 25px;
            border-bottom: 1px dashed #cccccc;
            display: none;
        }
        
        input {
            float: right;
        }
        
        ul li a {
            float: right;
        }
    </style>
    <script src="jquery.min.js"></script>
    <script>
        $(function() {
            // 1.点击发布按钮， 动态创建一个小li，放入文本框的内容和删除按钮， 并且添加到ul 中
            $(".btn").on("click", function() {
                var li = $("<li></li>");
                li.html($(".txt").val() + "<a href='javascript:;'> 删除</a>");
                $("ul").prepend(li);
                li.slideDown();
                $(".txt").val("");
            })

            // 2.点击的删除按钮，可以删除当前的微博留言li
            // $("ul a").click(function() {  // 此时的click不能给动态创建的a添加事件
            //     alert(11);
            // })
            // on可以给动态创建的元素绑定事件
            $("ul").on("click", "a", function() {
                $(this).parent().slideUp(function() {
                    $(this).remove();
                });
            })

        })
    </script>
</head>

<body>
    <div class="box" id="weibo">
        <span>微博发布</span>
        <textarea name="" class="txt" cols="30" rows="10"></textarea>
        <button class="btn">发布</button>
        <ul>
        </ul>
    </div>
</body>

</html>
```

#### 事件处理off() 解绑事件

`off()` 方法可以移除通过 `on()` 方法添加的事件处理程序。

```js
$("p").off() //解绑p元素所有事件处理程序
$("p").off("click") //解绑p元素上面的点击事件
$("ul").off("click", "li") // 解绑事件委托
```

如果有的事件只想触发一次，可以使用`one()` 来绑定事件

#### 自动触发trigger()

有些事件希望自动触发，比如轮播图自动播放功能跟点击右侧按钮一致。可以利用定时器自动触发右侧按钮点击事件，不必鼠标点击触发。

```js
element.click() // 第一种简写形式
```

```js
element.trigger("type") // 第二种自动触发模式
```

```js
element.triggerHandler("type")
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
            width: 100px;
            height: 100px;
            background-color: pink;
        }
    </style>
    <script src="jquery.min.js"></script>
    <script>
        $(function() {
            $("div").on("click", function() {
                alert(11);
            });

            // 自动触发事件
            // 1. 元素.事件()
            // $("div").click();会触发元素的默认行为
            // 2. 元素.trigger("事件")
            // $("div").trigger("click");会触发元素的默认行为
            $("input").trigger("focus");
            // 3. 元素.triggerHandler("事件") 就是不会触发元素的默认行为
            $("div").triggerHandler("click");
            $("input").on("focus", function() {
                $(this).val("你好吗");
            });
            // $("input").triggerHandler("focus");

        });
    </script>
</head>

<body>
    <div></div>
    <input type="text">
</body>

</html>
```

#### jQuery 事件对象

事件对象被触发，就会有事件对象的产生。

```js
element.on(events,[seletor],function(event){})
```

阻止默认行为 : `evnt.preventDefault()` 或者 `return false`

阻止冒泡 : `event.stopPropagation()`

## jQuery 其他方法

#### jQuery拷贝对象

如果想要把某个对象拷贝(合并)给另一个对象使用，此时可以使用`$.extend()` 方法

```js
$.extend([deep],target,object1,[objectN])
```

1. `deep` : 如果设为true为深拷贝，默认为false浅拷贝
2. `target ` : 要拷贝的目标对象
3. `object1 `： 待拷贝到第一个对象的对象
4. `obejctN` : 待拷贝到第n个对象的对象
5. 浅拷贝是把被拷贝的对象复杂数据类型中的地址拷贝给目标对象，修改目标对象会影响被拷贝对象

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <script src="jquery.min.js"></script>
    <script>
        $(function() {
            // var targetObj = {};
            // var obj = {
            //     id: 1,
            //     name: "andy"
            // };
            // // $.extend(target, obj);
            // $.extend(targetObj, obj);
            // console.log(targetObj);
            // var targetObj = {
            //     id: 0
            // };
            // var obj = {
            //     id: 1,
            //     name: "andy"
            // };
            // // $.extend(target, obj);
            // $.extend(targetObj, obj);
            // console.log(targetObj); // 会覆盖targetObj 里面原来的数据
            var targetObj = {
                id: 0,
                msg: {
                    sex: '男'
                }
            };
            var obj = {
                id: 1,
                name: "andy",
                msg: {
                    age: 18
                }
            };
            // // $.extend(target, obj);
            // $.extend(targetObj, obj);
            // console.log(targetObj); // 会覆盖targetObj 里面原来的数据
            // // 1. 浅拷贝把原来对象里面的复杂数据类型地址拷贝给目标对象
            // targetObj.msg.age = 20;
            // console.log(targetObj);
            // console.log(obj);
            // 2. 深拷贝把里面的数据完全复制一份给目标对象 如果里面有不冲突的属性,会合并到一起 
            $.extend(true, targetObj, obj);
            // console.log(targetObj); // 会覆盖targetObj 里面原来的数据
            targetObj.msg.age = 20;
            console.log(targetObj); // msg :{sex: "男", age: 20}
            console.log(obj);




        })
    </script>
</head>

<body>

</body>

</html>
```

#### jQuery多库共存

1. 把里面的 `$` 符号统一改为`jQuery` 。比如`jQuery("div")`
2. `jQuery` 变量规定新的名称 : `$.noConflict() `

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <script src="jquery.min.js"></script>
    <script>
        $(function() {
            function $(ele) {
                return document.querySelector(ele);
            }
            console.log($("div"));
            // 1. 如果$ 符号冲突 我们就使用 jQuery
            jQuery.each();
            // 2. 让jquery 释放对$ 控制权 让用自己决定
            var suibian = jQuery.noConflict();
            console.log(suibian("span"));
            suibian.each();
        })
    </script>
</head>

<body>
    <div></div>
    <span></span>
</body>

</html>
```

#### jQuery插件

```http
1. jQuery插件库  http://www.jq22.com/
2. jQuery之家   http://www.htmlleaf.com/
```

