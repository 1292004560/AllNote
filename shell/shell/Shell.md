# Shell概述

本次课程主要包含内容: 

1. Shell脚本入门
2. Shell变量
3. Shell内置命令
4. Shell运算符与执行运算命令
5. 流程控制语句
6. Shell函数
7. Shell重定向
8. Shell好用的工具, cut sed awk sort
9. 大厂常见企业面试题



# Shell脚本入门：介绍

### 目标

理解Shell是什么

理解Shell脚本是什么

理解为什么学习Shell脚本(Shell脚本程序的作用)

linux系统默认的Shell解析器



### 疑问

linux系统是如何操作计算机硬件CPU,内存,磁盘,显示器等?

答: 使用linux的内核操作计算机的硬件



### Shell介绍

通过编写Shell命令发送给linux内核去执行, 操作就是计算机硬件. 所以Shell命令是用户操作计算机硬件的桥梁,

Shell是命令,  类似于windows系统Dos命令

Shell是一个门程序设计语言, Shell里面含有变量, 函数, 逻辑控制语句等等

![image-20200706134738461](assets/image-20200706134738461.png)

### Shell脚本

通过Shell命令或程序编程语言编写的Shell文本文件,  这就是Shell脚本 , 也叫Shell程序



### 为什么学习Shell脚本?

通过Shell命令与编程语言来提高linux系统的管理工作效率



### Shell的运行过程

当用户下达指令给该操作系统的时候，实际上是把指令告诉shell，经过shell解释，处理后让内核做出相应的动作。 系统的回应和输出的信息也由shell处理，然后显示在用户的屏幕上。

![image-20200313223530826](assets/image-20200313223530826.png)

### Shell解析器

查看linux系统centos支持的shell解析器

```shell
cat /etc/shells
```

效果

![image-20200313225313350](assets/image-20200313225313350.png)

介绍解析器类型

| 解析器类型                       | 介绍                                                         |
| -------------------------------- | ------------------------------------------------------------ |
| /bin/sh                          | Bourne Shell,是UNIX最初使用的shell;                          |
| <font color=red>/bin/bash</font> | <font color=red>Bourne Again Shell它是Bourne Shell的扩展，简称bash，是LinuxOS默认shell,有灵活和强大的编辑接口，同时又很友好的用户界面，交互性很强；</font> |
| /sbin/nologin                    | 未登录解析器,  shell设置为/sbin/nologin 是用于控制用户禁止登陆系统的, 有时候有些服务，比如邮件服务，大部分都是用来接收主机的邮件而已，并不需要登陆 |
| /bin/dash                        | dash（Debian Almquist Shell），也是一种 Unix shell。它比 Bash 小，只需要较少的磁盘空间，但是它的对话性功能也较少，交互性较差。 |
| /bin/csh                         | C Shell是C语言风格Shell                                      |
| /bin/tcsh                        | 是C Shell的一个扩展版本。                                    |



### Centos默认的解析器是bash

语法

```shell
echo $SHELL
```

> 含义:  打印输出当前系统环境使用的Shell解析器类型
>
> echo  用于打印输出数据到终端
>
> `$SHELL`  是全局共享的读取解析器类型环境变量, 全局环境变量时所有的Shell程序都可以读取的变量,

效果

![image-20200314234038389](assets/image-20200314234038389.png)



### 小结

1、Shell是什么

```shell
是命令, 类似windows的dos命令
又是一门程序设计语言, 里面含有变量, 函数, 逻辑控制语句等
```



2、Shell脚本是什么

```shell
是一个文本文件, 里面可以编写Shell命令或进行编程, 形成一个可重用执行的脚本文件
```



3、shell脚本的作用

```shell
通过shell编程提高对linux系统管理工作效率
```



4、linux系统默认的shell解析器

```shell
/bin/bash
```





# Shell脚本入门：编写格式与执行方式

## 目标

1、掌握shell脚本编写规范

2、掌握执行shell脚本文件的3种方式与区别



## Shell脚本文件编写规范

### 脚本文件后缀名规范

shell脚本文件就是一个文本文件,  后缀名建议使用 `.sh` 结尾

### 首行格式规范

首行需要设置Shell解析器的类型, 语法

```shell
#!/bin/bash
```

> 含义:  设置当前shell脚本文件采用bash解析器运行脚本代码

### 注释格式

单行注释, 语法

```shell
# 注释内容
```



多行注释, 语法

```shell
:<<!
# 注释内容1
# 注释内容2
!
```





## shell脚本HelloWord入门案例

#### 需求

创建一个Shell脚本文件helloworld.sh，输出hello world字符串

#### 效果

![image-20200401022006169](assets/image-20200401022006169.png)

#### 实现步骤

1、创建shell脚本文件

```shell
touch helloworld.sh
```

2、编辑文件

```shell
vim helloworld.sh
```

3、增加shell脚本文件内容如下，并保存退出

```shell
#!/bin/bash
echo "hello world"
```

4、执行脚本

```shell
sh helloworld.sh
```

运行效果

![image-20200314234950078](assets/image-20200314234950078.png)



## 脚本文件的常用执行3种方式

#### 介绍

1. sh解析器执行方式

   语法: `sh 脚本文件`

   介绍: 就是利用sh命令执行脚本文件,  本质就是使用Shell解析器运行脚本文件

2. bash解析器执行方式

   语法: `bash 脚本文件`

   介绍: 就是利用bash命令执行脚本文件,  本质就是使用Shell解析器运行脚本文件

3. 仅路径执行方式

   语法: `./脚本文件`

   介绍:  执行当前目录下的脚本文件

   注意:  脚本文件自己执行需要具有可执行权限, 否则无法执行



#### 3种方式的区别

​		sh或bash执行脚本文件方式是直接使用Shell解析器运行脚本文件, 不需要可执行权限

​	     仅路径方式是执行脚本文件自己, 需要可执行权限

#### 执行脚本方式1-sh命令执行

相对路径效果

```shell
sh helloworld.sh
```

![image-20200401120441693](assets/image-20200401120441693.png)

绝对路径效果

```shell
sh /root/helloworld.sh
```

![image-20200401123156588](assets/image-20200401123156588.png)



#### 执行脚本方式2-bash命令执行

相对路径效果

![image-20200401123727643](assets/image-20200401123727643.png)

绝对路径效果

![image-20200401123801116](assets/image-20200401123801116.png)



#### 执行脚本方式3-仅路径执行

##### 语法

步骤1：设置所有用户对此脚本文件增加可执行性权限

```shell
chmod a+x 脚本文件
```

步骤2：执行脚本语法

```shell
脚本文件的相对路径或绝对路径
```

##### 示例：使用仅路径方式执行helloworld.sh脚本文件

添加执行权限

```shell
chmod a+x helloworld.sh
```

![image-20200401215308369](assets/image-20200401215308369.png)

相对路径执行命令

```
./helloworld.sh
```

相对路径执行效果

![image-20200401215354868](assets/image-20200401215354868.png)

绝对路径执行命令

```shell
/root/helloworld.sh
```

绝对路径执行效果

![image-20200401215435317](assets/image-20200401215435317.png)



## 小结

1、shell脚本文件编写规范？

> ​	文件的后缀名: 建议使用 `.sh`  扩展名
>
> ​	首行需要设置解析器类型  `#!/bin/bash`
>
> ​	脚本文件中的注释
>
> ​		单行注释,  `# 注释内容`
>
> ​		多行注释   `:<<!`
>
> ​							`# 注释内容`
>
> ​							`!`

2、执行shell脚本文件有哪3种方式，并说明他们的区别？

> sh执行脚本文件
>
> bash执行脚本文件
>
> 仅路径执行脚本文件
>
> 区别:  前2种是解析器直接执行不需要可执行权限, 最后一种是脚本文件自己执行需要可执行权限





# Shell脚本入门：多命令处理

### 目标

掌握shell脚本文件中执行多命令处理



### 多命令处理介绍

就是在Shell脚本文件中编写多个Shell命令



### 案例需求

已知目录/root/itheima目录，执行batch.sh脚本，实现在/root/itheima/目录下创建一个one.txt,在one.txt文件中增加内容“Hello Shell”。

### 步骤分析

1. 使用mkdir创建/root/itheima目录

2. 创建脚本文件batch.sh

3. 编辑脚本文件

   3.1 命令1: touch创建文件, 文件名 `/root/itheima/one.txt`

   3.2 命令2: 输出数据"Hello Shell"到one.txt文件中

   > 输出数据到文件中的命令:
   >
   > `数据 >> 文件`

4. 执行脚本文件



### 实现步骤

1、进入root目录，执行创建/root/itheima目录命令

```shell
mkdir /root/itheima
```



2、创建/root/batch.sh文件

```shell
touch batch.sh
```

![image-20200402205353802](assets/image-20200402205353802.png)



2、编辑batch.sh文件，编写shell命令

```shell
vim batch.sh
```



3、编写命令

命令1：创建/root/itheima/one.txt文件

命令2：输出“I love Shell”字符串数据到one.txt文件中

```shell
#!/bin/bash
cd itheima     # 切换到itheima目录
touch one.txt  # 创建文件one.txt
echo "Hello Shell">>/root/itheima/one.txt  #输出数据到one.txt文件中
```

![image-20200402221001946](assets/image-20200402221001946.png)

### 运行脚本效果

运行batch.sh脚本文件

```shell
sh batch.sh
```

查看one.txt文件内容

```shell
cat itheima/one.txt
```

![image-20200402221123997](assets/image-20200402221123997.png)



### 小结

shell脚本文件中是否可以执行多命令处理？

可以





# Shell变量：环境变量

## 目标

1、理解什么是系统环境变量？

2、掌握常用的系统环境变量都有哪些？



## Shell变量的介绍

变量用于存储管理临时的数据,    这些数据都是在运行内存中的.



## 变量类型

1. 系统环境变量
2. 自定义变量
3. 特殊符号变量



## 系统环境变量

### 介绍

是系统提供的共享变量.是linux系统加载Shell的配置文件中定义的变量共享给所有的Shell程序使用



### Shell的配置文件分类

1.全局配置文件
/etc/profile
/etc/profile.d/*.sh
/etc/bashrc

2.个人配置文件
当前用户/.bash_profile
当前用户/.bashrc

一般情况下，我们都是直接针对全局配置进行操作。



### 环境变量分类

在Linux系统中，环境变量按照其作用范围不同大致可以分为系统级环境变量和用户级环境变量。

系统级环境变量：Shell环境加载全局配置文件中的变量共享给所有用户所有Shell程序使用, 全局共享
用户级环境变量：Shell环境加载个人配置文件中的变量共享给当前用户的Shell程序使用, 登录用户使用





### 查看当前Shell系统环境变量

查看命令

```shell
env
```

效果

![image-20200405222654722](assets/image-20200405222654722.png)



### 查看Shell变量(系统环境变量+自定义变量+函数)

命令

```shell
set
```



效果

![image-20200610154848860](assets/image-20200610154848860.png)

### 常用系统环境变量

| 变量名称     | 含义                                                         |
| ------------ | ------------------------------------------------------------ |
| ==PATH==     | 与windows环境变量PATH功能一样，设置命令的搜索路径，以冒号为分割 |
| HOME         | 当前用户主目录：/root                                        |
| SHELL        | 当前shell解析器类型：/bin/bash                               |
| ==HISTFILE== | 显示当前用户执行命令的历史列表文件：/root/.bash_history      |
| PWD          | 显示当前所在路径：/root                                      |
| OLDPWD       | 显示之前的路径                                               |
| HOSTNAME     | 显示当前主机名：itheima                                      |
| HOSTTYPE     | 显示主机的架构，是i386、i686、还是x86、x64等：x86_64         |
| ==LANG==     | 设置当前系统语言环境：zh_CN.UTF-8                            |

### 环境变量输出演示

![image-20200608093116302](assets/image-20200608093116302.png)

![image-20200608094455008](assets/image-20200608094455008.png)

![image-20200608094638283](assets/image-20200608094638283.png)

## 小结

1.系统环境变量是什么?

> 是系统提供的环境变量, 通过加载Shell配置文件中变量数据共享给Shell程序使用

2.环境变量的分类?

> 系统级环境变量,  Shell环境加载全局配置文件中定义的变量
>
> 用户级环境变量,  Shell环境加载个人配置文件中定义的变量

3.env与set区别

> env用于查看系统环境变量
>
> set用于查看系统环境变量+自定义变量+函数

4.常用环境变量

| 变量名称 | 含义                                                |
| -------- | --------------------------------------------------- |
| PATH     | 命令搜索的目录路径, 与windows的环境变量PATH功能一样 |
| LANG     | 查询系统的字符集                                    |
| HISTFILE | 查询当前用户执行命令的历史列表                      |





# Shell变量：自定义变量

## 目标

理解自定义变量的分类

能够自定义变量进行增\删\改\查



## 自定义变量介绍

就是自己定义的变量



## 分类

1. 自定义局部变量
2. 自定义常量
3. 自定义全局变量



## 自定义局部变量

### 介绍

就是定义在一个脚本文件中的变量, 只能在这个脚本文件中使用的变量, 就是局部变量



### 定义与使用

定义语法

```shell
var_name=value
```

变量定义规则

1. 变量名称可以有字母,数字和下划线组成, 但是不能以数字开头
2. 等号两侧不能有空格
3. 在bash环境中, 变量的默认类型都是字符串类型, 无法直接进行数值运算
4. 变量的值如果有空格, 必须使用双引号括起来
5. 不能使用Shell的关键字作为变量名称

演示

![image-20200608170754770](assets/image-20200608170754770.png)

查询变量值语法

```Shell
# 语法1: 直接使用变量名查询
$var_name
# 语法2: 使用花括号
${var_name}
# 区别: 花括号方式适合拼接字符串
```

演示

![image-20200608170830515](assets/image-20200608170830515.png)

![image-20200608170854466](assets/image-20200608170854466.png)

注意: 如果`"My name is ${var2}Style"` 中 `$var2` 不带花括号, 系统会认为获取`$var2Style` 变量数据, 这个变量不存在就获取不到数据,执行效果如下

![image-20200608170953503](assets/image-20200608170953503.png)

结论:  推荐大家使用花括号才是编程好习惯

### 变量删除

语法

```shell
unset var_name
```

演示

![image-20200608182219303](assets/image-20200608182219303.png)



## 自定义常量

介绍

> 就是变量设置值以后不可以修改的变量叫常量, 也叫只读变量

语法

```shell
readonly var_name
```

演示

![image-20200608193930236](assets/image-20200608193930236.png)

## 自定义全局变量

### 父子Shell环境介绍

例如:  有2个Shell脚本文件 A.sh 和 B.sh

如果 在A.sh脚本文件中执行了B.sh脚本文件, 那么A.sh就是父Shell环境, B.sh就是子Shell环境

### 自定义全局变量介绍

> 就是在当前脚本文件中定义全局变量, 这个全局变量可以在当前Shell环境与子Shell环境中都可以使用

### 自定义全局变量语法

```Shell
export var_name1 var_name2
```

### 案例需求

测试全局变量在子Shell中是否可用,  在父Shell中是否可用

### 案例实现步骤

1. 创建2个脚本文件 demo2.sh 和 demo3.sh

2. 编辑demo2.sh 

   命令1:定义全局变量VAR4

   命令2: 执行demo3.sh脚本文件

3. 编辑demo3.sh

   输出全局变量VAR4

4. 执行demo2.sh脚本文件

### 案例演示

1. 创建demo2.sh和demo3.sh文件

   ![image-20200608223429822](assets/image-20200608223429822.png)

2. 编辑demo2.sh, 里面定义变量VAR4并设置为全局, 并里面执行demo3.sh脚本文件

   ```shell
   vim demo2.sh
   ```

   ![image-20200608224144481](assets/image-20200608224144481.png)

3. 编辑demo3.sh,  里面打印VAR4

   ```shell
   vim demo3.sh
   ```

   ![image-20200608224326159](assets/image-20200608224326159.png)

4. 执行脚本文件demo2.sh,  观察打印VAR4效果

   ![image-20200608224400106](assets/image-20200608224400106.png)

5. 执行脚本文件后, 在交互式Shell环境打印VAR4,  观察打印VAR4效果

   ![image-20200608224459074](assets/image-20200608224459074.png)

### 结论

全局变量在当前Shell环境与子Shell环境中可用, 父Shell环境中不可用



## 小结

自定义变量的分类

> 自定义局部变量:  就是在一个脚本文件内部使用 `var_name=value`
>
> 自定义常量: 不可以修改值的变量, `readonly var_name`
>
> 自定义全局变量:  设置变量在当前脚本文件中与子Shell环境可以使用的变量, `export var_name`

自定义变量进行增\删\改\查

> 定义和修改: `var_name=value`
>
> 查询:`${var_name} 或 $var_name`
>
> 删除: `unset var_name`



# Shell变量：特殊变量

## 目标

能够说出常用的特殊变量有哪些



## 特殊变量：$n

### 语法

```shell
$n
```

### 含义

```shell
用于接收脚本文件执行时传入的参数
$0 用于获取当前脚本文件名称的
$1~$9, 代表获取第一输入参数到第9个输入参数
第10个以上的输入参数获取参数的格式: ${数字}, 否则无法获取
```

### 执行脚本文件传入参数语法

```shell
sh 脚本文件 输入参数1 输入参数2 ...
```



### 案例需求

创建脚本文件demo4.sh文件, 并在脚本文件内部执行打印脚本文件名字, 第一个输入参数, 第二个输入参数

### 实现步骤

1. 创建脚本文件demo4.sh

2. 编辑demo4.sh的文件内容

   ```shell
   # 命令1: 打印当前脚本文件名字
   # 命令2: 打印第1个输入参数
   # 命令3: 打印第2个输入参数
   # 命令4: 打印第10个输入参数
   ```

3. 执行脚本文件demo4.sh

### 演示

1. 创建demo4.sh文件

   ![image-20200610092956575](assets/image-20200610092956575.png)

2. 编辑demo4.sh文件, 输出脚本文件名称\第一个输入参数\第二个输入参数

   ![image-20200610093208439](assets/image-20200610093208439.png)

   ![image-20200610093227100](assets/image-20200610093227100.png)

3. 执行demo4.sh文件,输入输出参数itcast  itheima的2个输入参数, 观察效果

   ![image-20200610093253173](assets/image-20200610093253173.png)



## 特殊变量：$#

### 语法

 ```shell
$#
 ```

### 含义

获取所有输入参数的个数




### 案例需求

在demo4.sh中输出输入参数个数

### 演示

编辑demo4.sh, 输出输入参数个数

![image-20200610093208439](assets/image-20200610093208439.png)

![image-20200610094814031](assets/image-20200610094814031.png)

执行demo4.sh传入参数itcast, itheima, 播仔 看效果

![image-20200610094657175](assets/image-20200610094657175.png)



## 特殊变量：`$*`、`$@`

### 语法

```shell
$*
$@
# 含义都是获取所有输入参数, 用于以后输出所有参数
```

`$*`与`$@`区别

```shell
1.不使用双引号括起来, 功能一样
  $*和$@获取所有输入参数,格式为: $1 $2 ... $n
2.使用双引号括起来
  "$*"获取的所有参数拼接为一个字符串, 格式为: "$1 $2 ... $n"
  "$@"获取一组参数列表对象, 格式为: "$1" "$2" ... "$n"
  使用循环打印所有输入参数可以看出区别
```

循环语法

```shell
for var in 列表变量
do		# 循环开始
   命令  # 循环体
done    # 循环结束
```



### 案例需求

在demo4.sh中循环打印输出所有输入参数, 体验`$*`与`$@`的区别

### 实现步骤

编辑demo4.sh脚本文件

```shell
# 增加命令: 实现直接输出所有输入后参数
# 增加命令: 使用循环打印输出所有输入参数
```



### 演示

1. 编辑demo4.sh文件

   ![image-20200610093208439](assets/image-20200610093208439.png)

2. 直接输出所有输入参数, 与循环方式输出所有输入参数(使用双引号包含 `$*` 与 `$@`  )

   ```shell
   #!/bin/bash
   # 命令1: 打印当前脚本文件名字
   echo "当前脚本文件名称:$0"
   
   # 命令2: 打印第1个输入参数
   echo "第一个输入参数:$1"
   
   # 命令3: 打印第2个输入参数
   echo "第二个输入参数:$2"
   
   # 命令4: 打印第10个输入参数
   echo "第十个输入参数不带花括号获取:$10"
   echo "第十个输入参数带花括号获取:${10}"
   
   # 命令5 打印所有输入参数的个数
   echo "所有输入参数个数:${#}"
   
   
   # 增加命令: 实现直接输出所有输入后参数
   echo '使用$*直接输出:'$*
   echo '使用$@直接输出:'$@
   
   # 增加命令: 使用循环打印输出所有输入参数
   echo '循环遍历输出$*所有参数'
   for item in "$*"
   do
      echo $item
   done
   echo '循环遍历输出$@所有参数'
   for item in "$@"
   do
      echo $item
   done
   ```

3. 运行观察区别

   ![image-20200707090439984](assets/image-20200707090439984.png)

## 特殊变量：$？

### 语法

```shell
$?
```

### 含义

用于获取上一个Shell命令的退出状态码, 或者是函数的返回值

> 每个Shell命令的执行都有一个返回值, 这个返回值用于说明命令执行是否成功
>
> 一般来说, 返回0代表命令执行成功, 非0代表执行失败

### 演示

输入一个正确命令, 再输出`$?`

![image-20200610114421826](assets/image-20200610114421826.png)

输入一个错误命令, 在输出`$?`

![image-20200610114445468](assets/image-20200610114445468.png)



## 特殊变量：$

### 语法

```shell
$$
```

### 含义

用于获取当前Shell环境的进程ID号

### 演示

查看当前Shell环境进程编号

```Shell
ps -aux|grep bash
```

![image-20200610114834462](assets/image-20200610114834462.png)

输出 $$  显示当前shell环境进程编号

![image-20200610114956474](assets/image-20200610114956474.png)



## 小结

常用的特殊符号变量如下

| 特殊变量     | 含义                                                         |
| ------------ | ------------------------------------------------------------ |
| `$n`         | 获取输入参数的<br>`$0`,  获取当前Shell脚本文件名字<br>`$1~$9`, 获取第一个输入参数到第九个输入参数<br>`${10}`  获取10和10以上的参数需要使用花括号 |
| `$#`         | 获取所有输入参数的个数                                       |
| `$*` 与 `$@` | 获取所有输入参数数据<br>区别: 如果不使用双引号, 功能一样, <br>获取所有参数数据为一个字符串, 如果使用了双引号, <br>`$@`获取的就是参数列表对象, 每个参数都是一个独立字符串, |
| `$?`         | 获取上一个命令的退出状态码, 一般;来说0代表命令成功, 非0代表执行失败 |
| `$$`         | 获取当前shell环境进程的ID号                                  |



# Shell环境变量深入：自定义系统环境变量

## 目标

能够自定义系统级环境变量



## 全局配置文件/etc/profile应用场景

当前用户进入Shell环境初始化的时候会加载全局配置文件/etc/profile里面的环境变量, 供给所有Shell程序使用

以后只要是所有Shell程序或命令使用的变量, 就可以定义在这个文件中



## 案例演示

### 需求

/etc/profile定义存储自定义系统级环境变量数据



### 创建环境变量步骤

1. 编辑/etc/profile全局配置文件

   ```shell
   # 增加命令: 定义变量VAR1=VAR1 并导出为环境变量
   # 扩展: vim里面的命令模式使用G快速定位到文件末尾位置, 使用gg定位到文件首行位置
   ```

2. 重载配置文件/etc/profile, 因为配置文件修改后要立刻加载里面的数据就需要重载, 语法

   ```shell
   source /etc/profile
   ```

3. 在Shell环境中读取系统级环境变量VAR1



### 创建环境变量演示

编辑/etc/profile文件

```shell
vim /etc/profile
```



添加设置变量VAR1=VAR1并导出成为环境变量, 在/etc/profile文件末尾添加如下命令

```shell
# 创建环境变量
VAR1=VAR1
export VAR1
```

![image-20200409124318865](assets/image-20200409124318865.png)

3、保存/etc/profile退出

4、重新加载/etc/profile文件数据更新系统环境变量

```shell
source /etc/profile
```

> 注意：如果这一步不执行，无法读取更新的环境变量

3、输出环境变量VAR1

```shell
echo $VAR1
```

![image-20200409124934898](assets/image-20200409124934898.png)

## 小结

如何自定义系统级环境变量

> 1. 系统级全局配置文件: /etc/profile
> 2. 设置环境变量: `export var_name=value`,  注意环境变量建议变量名全部大写
> 3. 修改了/etc/profile文件后, 要立刻加载修改的数据需要重载配置文件: `source /etc/profile`





# Shell环境变量深入：加载流程原理介绍

## 目标

1. 能够说出交互式Shell与非交互式Shell
2. 能够说出登录Shell与非登录Shell环境



## Shell工作环境介绍

用户进入linux系统就会初始化Shell环境, 这个环境会加载全局配置文件和用户个人配置文件中环境变量.每个脚本文件都有自己的Shell环境



## shell工作环境分类

### 交互式与非交互式shell

交互式Shell

> 与用户进行交互, 互动. 效果就是用户输入一个命令, Shell环境立刻反馈响应.

非交互式Shell

> 不需要用户参与就可以执行多个命令. 比如一个脚本文件含有多个命令,直接执行并给出结果



### 登录Shell与非登录Shell环境

| 类型名称        | 含义                                             |
| --------------- | ------------------------------------------------ |
| shell登录环境   | 需要用户名\密码登录的Shell环境                   |
| shell非登录环境 | 不需要用户名,密码进入的Shell环境 或 执行脚本文件 |

> 注意：不同的工作环境加载环境变量流程不一样



## 环境变量初始化流程

1.全局配置文件
/etc/profile
/etc/profile.d/*.sh
/etc/bashrc

2.个人配置文件
当前用户/.bash_profile
当前用户/.bashrc



环境变量加载初始化过程

![image-20200707120357693](assets/image-20200707120357693.png)

## 小结

1. 能够说出交互式Shell与非交互式Shell

   > 交互式Shell:  就是需要用户参与互动的Shell环境, 效果用户输入一个命令, 环境就立刻响应结果
   >
   > 非交互式Shell:  只执行命令, 不需要用户的参与

2. 能够说出登录Shell与非登录Shell环境

   > 登录Shell环境:  要以用户名与密码登录到系统默认采用登录Shell环境
   >
   > 非登录Shell环境: 不使用用户名与密码进入linux系统的Shell环境



# Shell环境变量深入：加载流程测试

## 目标

理解Shell环境变量的加载流程测试

能够知道环境变量应该配置在哪里



## 切换Shell环境执行脚本文件介绍

在执行一个脚本文件时可以指定具体Shell环境进行执行脚本文件, 这个就是切换Shell环境执行脚本



## Shell登录环境执行脚本文件语法

```shell
sh/bash -l/--login 脚本文件
```

> 含义: 先加载Shell登录环境流程初始化环境变量, 再执行脚本文件

## Shell非登录环境变量执行脚本文件语法

```shell
bash # 加载Shell非登录环境
sh/bash 脚本文件 # 直接执行脚本文件
```

> 含义: 先执行加载Shell非登录环境流程初始化环境变量, 再执行脚本文件



## 测试案例

### 需求

Shell登录环境会运行/etc/profile

Shell非登录环境会运行/.bashrc

在/etc/profile与/当前用户/.bashrc文件分别设置环境变量数据，然后在shell脚本文件中输出环境变量数据，最后切换不同环境执行shell脚本文件观察验证上面的流程运行

### 分析

1. 清理工作, 清理/etc/profile文件中VAR1环境变量进行删除, 并且重载这个配置文件

2. 编辑/etc/profile, 增加环境变量VAR1=VAR1

3. 编辑/root/.bashrc, 增加环境变量VAR2=VAR2

4. 创建demo1.sh文件, 读取环境变量数据进行打印

   ```shell
   # 输出环境变量VAR1
   # 输出环境变量VAR2
   ```

5. 以Shell非登录环境执行demo1.sh脚本文件, 观察只会输出VAR2, 不会输出VAR1
6. 以Shell登录环境执行demo1.sh脚本文件, 观察会输出VAR2和VAR1

### 演示

编辑/etc/profile文件

```Shell
vim /etc/profile
```

编辑添加如下内容，保存退出

![image-20200608180928458](assets/image-20200608180928458.png)

在root目录下,编辑.bashrc文件

```shell
vim .bashrc
```

![image-20200608180131769](assets/image-20200608180131769.png)

编辑添加如下最后2行内容，保存退出

![image-20200608181029028](assets/image-20200608181029028.png)

创建文件demo1.sh

```shell
touch demo1.sh
```

编辑文件demo1.sh，添加如下内容

![image-20200608180411557](assets/image-20200608180411557.png)

直接执行脚本文件

```shell
bash demo1.sh
```

![image-20200608180453317](assets/image-20200608180453317.png)

> 直接执行脚本文件, 即没有加载登录Shell环境变量, 也没有加载非登录Shell环境变量

先加载非登录Shell环境变量, 然后执行脚本文件

```shell
bash
bash demo1.sh
```

![image-20200608181127345](assets/image-20200608181127345.png)

> Shell非登录环境会加载文件 `当前用户/.bashrc`  的环境变量数据
>
> 所以这里会输出VAR2的环境变量数据

先加载登录Shell环境变量, 然后执行脚本文件

```shell
bash -l demo1.sh
```

![image-20200608181329353](assets/image-20200608181329353.png)

> Shell登录环境会加载文件 `etc/profile`和`当前用户/.bashrc`  的环境变量数据
>
> 所以这里会输出VAR1和VAR2的环境变量数据

## 小结

1、Shell环境变量初始化加载原理过程

| 分类                      | 初始化环境变量过程执行文件顺序                               |
| ------------------------- | ------------------------------------------------------------ |
| shell登录环境初始化过程   | /etc/profile--》/etc/profile.d/*.sh--》~/.bash_profile--》~/.bashrc--》/etc/bashrc |
| shell非登录环境初始化过程 | ~/.bashrc--》/etc/bashrc--》/etc/profile.d/*.sh              |

2、那么以到底将环境变量定义到哪里呢？/etc/profile与/etc/bashrc的区别？

需要登录的执行的shell脚本读取的环境变量配置在：/etc/profile、/当前用户/.bash_profile

不需要登录的用户执行的shell脚本读取的环境变量配置在：/当前用户/.bashrc、/etc/bashrc



# Shell环境变量深入：识别Shell环境类型

## 目标

理解如何识别shell登录环境与非登录环境



## 语法

使用$0识别环境语法

```shell
echo $0
```

> 输出 `-bash` 代表：shell登录环境
>
> 输出 `bash` 代表：  shell非登录环境
>
> 注意：这个 `$0` 环境变量如果用在子shell中(shell脚本文件)输出Shell脚本本身的文件名 

bash命令语法

```shell
bash
```

> bash命令：用于切换为Shell非登录环境

### 分析

1、直接登录系统为shell登录环境输出 $0 观察输出信息效果

2、使用 bash 命令切换为shell非登录环境输出 $0 观察输出信息效果

3、创建test.sh脚本文件，编辑添加输出 $0 ,编程保存完成后执行test.sh脚本文件观察输出信息效果

### 演示

直接登录linux系统使用如下命令效果

![image-20200408201336071](assets/image-20200408201336071.png)

> bash命令将当前环境转换为Shell非登录环境



## 小结

1、如何识别shell登录环境与非登录环境？

```shell
$0 用于获取当前Shell环境的类型,  bash代表Shell非登录环境, -bash 代表Shell登录环境
# $0不可以在脚本文件中使用, 因为代表获取脚本文件名字
```





# Shell环境变量深入：详细切换Shell环境

## 目标

理解切换shell环境的命令



## 切换shell环境命令介绍

1. 直接登录加载shell登录环境

2. su切换用户加载Shell登录与Shell非登录环境
3. bash加载Shell登录与Shell非登录环境



## 切换Shell环境命令演示

### 切换环境方式1：直接登录系统

##### 介绍

直接在虚拟机上使用用户名与密码登录linux系统或使用客户端直接连接远程linux系统

##### 演示

虚拟机本地直接登录演示

![image-20200408235243772](assets/image-20200408235243772.png)

客户端远程采用SSH登录演示

![image-20200408235629776](assets/image-20200408235629776.png)



### 切换环境方式2：su切换用户登录

##### 命令

语法1

```shell
su 用户名 --login 
或
su 用户名 -l
 # 切换到指定用户, 加载Shell登录环境变量
```

语法2

```shell
su 用户名  
# 切换到指定用户,  加Shell非登录环境变量
```



##### 分析步骤

1、创建普通用户userA

2、切换到用户userA，使用-l加载Shell登录环境变量  ,  输出环境变量$0，观察输出-bash

4、使用exit退出userA

5、切换到用户userA，加载Shell非登录环境变量，输出环境变量$0，观察输出bash



##### 演示

创建普通用户userA

```shell
useradd -m userA
```

![image-20200409162546096](assets/image-20200409162546096.png)

以Shell登录环境执行切换到用户userA，输出环境变量$0，输出 -bash 说明当前为Shell登录环境

![image-20200409162630366](assets/image-20200409162630366.png)

使用exit退出userA

![image-20200409162938320](assets/image-20200409162938320.png)

以Shell非登录环境执行切换到用户userA，输出环境变量$0，输出 bash  说明当前为Shell非登录环境

![image-20200409162957086](assets/image-20200409162957086.png)

### 切换环境方式3：bash切换

##### 命令

语法1:

```shell
bash  # 加载【Shell非登录环境】
```

语法2：

```shell
bash -l  Shell脚本文件 /  bash --login shell脚本文件
sh -l shell脚本文件 / sh --login shell脚本文件
# 先加载【Shell登录环境】然后运行指定Shell脚本文件
```

##### 分析

使用bash执行test.sh脚本文件，发生错误说明当前环境为Shell非登录环境

##### 演示

![image-20200409165207091](assets/image-20200409165207091.png)

##### 

