## requests库说明

```python
requests.get(url, params=None, **kwargs)
requests.post(url, data=None, json=None, **kwargs)
requests.delete(url, **kwargs)
requests.put(url, data=None, **kwargs)
requests.request(method, url, **kwargs)

session.request(method=method, url=url, **kwargs)# 这个方法能够自动化的关联cookie的接口

session.request(
        method, # 请求方式
        url,  # 请求路径
        params=None, # get请求参数
        data=None,   # post或者put请求穿参
        headers=None, # 请求头
        cookies=None,  # cookie
        files=None, # 文件上传
        auth=None,  # 鉴权
        timeout=None, # 超时
        allow_redirects=True,  # 是否允许从定向
        proxies=None,   # 设置代理
        hooks=None,
        stream=None,    # 文件下载
        verify=None,    # 证书验证
        cert=None,    #CA证书
        json=None,  # post 请求传参
    )
```

## 面试题 : 接口自动化实现接口关联的三种方式以及提取变量的两种方式

### 实现接口关联的三种方式:

1.  通过类变量保存中间变量实现接口关联
2. 通过单独的文件保存中间变量实现接口关联
3. 极限封装成和工具一样只需通过表达式就可以实现接口关联

### 提取变量的两种方式 : 

1. 正则表达式提取
2. JsonPath提取

      ```
      $ 根节点
      . 子节点
      .. 下层子节点
      [] 代表取列表中的值，下表从零开始
      ```

## `from-data  x-www-form-urlencoded  raw    binary`

```
from-data  表单和文件上传
x-www-form-urlencoded 纯表单
raw   json
binary   把文件转换成二进制传输
```

## pytest

```python
作用：
1. 找到用例
  模块名必须以test_开头或者_test结尾
  类名必须以Test开头，并且不能有init方法
  用例方法必须以test开头
2. 执行用例
3. 判断结果
4. 生成报告

插件
pytest 本身
pytest-html 简单html报告
pytest-xdist 多线程执行
pytest-ordering 控制用例执行顺序
pytest-rerunfailures 失败用例重跑
pytest-base-url 设置基础路径(并发，测试，生产，预发布）
allure-pytest 生成allure报告


运行
1. 命令行
  pytest -v 输出更详细的信息
         -s 输出调试信息
2. 主函数
import pytest

if __name__ == '__main__:
        pytest.main()
  
3. 结合pytest.ini 全局配置文件执行
```

```ini
[pytest]
# 命令行参数
# addopts = -vs --html=./reports/report.html --reruns 2
addopts = -vs -m somke
# 配置执行的用例位置
testpaths = ./testcase
# 配置修改默认模块规则
python_files = test_*.py
# 配置修改默认的类规则
python_classes = Test*
# 配置修改用例规则
python_functions = test_*
# 配置基础路径
base_url = http://www.baidu.com
# 标记
markers =
      smoke:冒烟测试用例
      
```

```python
自动探测
class TestApi(object):
    
    每个用例之前和之后
    def setup(self):
        pass

    def teardown(self):
        pass
    每个类之前和之后
    def setup_class(self):
        pass

    def teardown_class(self):
        pass
```

## 使用fixtrue固件结合contest.py实现

1. 装饰器

​     `@pytest.fixtrue(scope="作用范围")`

​      scope:class，function，module，session

​    在文件中设置的固件fixture 只能在当前文件起作用，如果希望对所有py文件起作用，需要将固件写在conftest.py 文件上



## 接口自动化测试框架封装通过文件保存中间变量

* 原因 : 类变量不能跨py文件使用
* 统一管理中间变量
* 什么时候清空：



