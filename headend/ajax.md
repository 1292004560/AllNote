## ajax 的特点

### 优点

1. 可以无需刷新页面而与服务器进行通信
2. 允许根据用户事件来更新部分页面内容

### 缺点

1. 没有浏览历史，不能回退
2. 存在跨域问题(同源)
3. SEO不友好

## 案例

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>get请求</title>
</head>
<style>
    #result{
        width: 200px;
        height: 100px;
        border: solid 1px #90b;
    }
</style>
<body>

<button>发送</button>
<div id="result"></div>

<script>

    const btn = document.getElementsByTagName('button')[0];
    btn.onclick = function (){
        // 创建对象
        const xhr = new XMLHttpRequest();
        // 初始化 设置请求方法和url
        xhr.open('GET','http://127.0.0.1:8000/sever');

        // 发送
        xhr.send();

        // 绑定事件 处理服务端返回结果
        // on when 当...时候
        // readystate 是xhr对象中的属性，表示状态 0 1 2 3 4
        // change 改变
        xhr.onreadystatechange = function (){

            console.log(xhr.readyState)
            // 判断 (服务端返回了所有结果)
            if (xhr.readyState == 4){
                // 判断响应状态吗200 400 403 401 500
                console.log(xhr.status)
                if (xhr.status >= 200 && xhr.status < 300){
                    // 处理结果
                    console.log(xhr.status);
                    console.log(xhr.statusText);
                    console.log(xhr.getAllResponseHeaders());
                }else {
                    console.log("error");
                }
            }
        }
    }
</script>
</body>
</html>
```

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>post</title>
</head>
<style>
  #result{
    width: 200px;
    height: 200px;
    border: solid 1px red;
  }
</style>
<body>

<div class="result"></div>

<script>


  let id = document.getElementById('result');

  id.addEventListener("mouseover", ()=>{

    let xhr = new XMLHttpRequest();

    xhr.open('POST', 'http://localhost:8080/server');

    xhr.send();

    xhr.onreadystatechange = function () {

      if (xhr.readyState == 4){
        if (xhr.status >= 200 && xhr.status < 400){
          id.innerHTML = xhr.response
        }
      }
    }

  });

</script>

</body>
</html>
```

