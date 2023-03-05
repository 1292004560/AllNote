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
3.  