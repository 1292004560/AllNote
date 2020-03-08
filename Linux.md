### linux 系统管理

#### linux的有两种定义

1. 一种式linus编写的开源操作系统内核。
2. 另一种是广义的操作系统。
3.  [内核官网](http://www.kernel.org/)

#### linux镜像下载地址

* [centos镜像](http://isoredirect.centos.org/)

#### linux常用目录介绍

* **/**  跟目录
* **/root**    root用户的家目录
* **/home/username **  普通用户的家目录
* **/etc **  配置文件目录
* **/bin**  命令目录
* **/sbin**  管理命令目录
* **/usr/bin/    /usr/sbin**  系统预装的其他命令

#### 帮助命令

##### man命令

1. 全名为manual 
2. 共有九个章节 通过  **man  【1-9】命令名称**
   1. **Command**  用户可从 shell运行的命令
   2. **System calls**  必须由内核完成的功能
   3. **Library calls**  大多数libc 函数，例如 **qsort(3)**
   4. **Special file**  /dev 目录的文件
   5. **File formats and  conventions** /etc/password 等人可读的文件个格式说明
   6. **Games**
   7. **Macro  packages and conventions **
      * 文件系统标准描述，网络协议，ASCII和其他字符集，还有你眼前这份文档以及其他的东西
   8. **System management commands** 
      * 类似munt(8) 等命令，大部分只能由root执行
   9. **Kernel  routines** 废弃章节
3. **man -a  password**

##### help命令

1. shell(命令解释器)自带的命令称为内部命令，其他的是外部命令
2. 内部命令使用help帮助
   * **help  cd** 
3. 外部命令使用help帮助
   * **ls  --help**
4. **type  ls**  用于区分内部或外部命令

##### info命令

1. info 帮助比help更详细，作为help的补充
2. **info  ls**

#### 文件命令

##### pwd 命令

1. 显示当前目录命令

##### ls命令

* ls  查看当前目录的文件
* ls  [选项，选项......]  参数 ..
* 常用参数
  * **-l**  长格式显示文件
  * **-a** 显示隐藏文件
  * **-r** 逆序显示
  * **-t** 安照时间顺序排序
  * **-R** 递归显示
  * **-h** 将文件大小按M显示

##### mkdir 命令

* mkdir   ： 建立目录
* 常用参数
  * -p  建立多级目录

##### rmdir命令

* 删除空目录

##### rm命令

* **rm ** 删除文件
* 常用参数
  * **-r** 删除目录(包括目录下的所有文件)
  * **-f** 删除文件不进行提示
* 注意：rm命令可以删除多个目录，需要谨慎使用

##### cp命令

* 复制文件和目录
* **cp  [选项]  文件路径**
* **cp [选项]  文件 ...   路径**
* 常用参数
  * **-r**  复制目录
  * **-p** 保留用户、权限、时间等文件属性
  * **-a** 等同于  **-dpR**

##### mv命令

* **mv   [选项 ]  源文件  目标文件**
* **mv  [选项]  源文件  目录**

#### 文本查看命令

* **cat**  文本内容显示到终端
* **head** 查看文件开头
* **tail** 查看文件结尾
  * 常用参数 **-f**  文件内容更新后，显示信息同步更新
* **wc** 统计文件内容信息

#### 打包与压缩

* 最早linux备份介质时磁带，使用的命令是tar
* 可以打包后的磁带进行压缩存储，压缩命令是 **gzip  和  bzip2**
* 经常使用的扩展名是 **.tar.gz    .tar.bz2    .tgz**

##### tar命令

* 打包命令
* **tar  czf**  将文件打包并以 **gzip** 压缩
* **tar  cjf**    将文件打包并以 **bzip2** 压缩
* 常用参数
  * **c** 打包
  * **x** 解包
  * **f** 指定操作类型为文件

#### 用户与权限管理

* **useradd** 新建用户
  * 可以通过 **tail  -10 /etc/shadow  和  tail -10  /etc/passwd  ** 查看是否建立用户
  * 也可以通过  **id  用户名**  这种方式查看
* **userdel** 删除用户
  * 删除用户并删除该用户的家目录
  * **user -r  用户名**
* **passwd** 修改用户密码
  * **passwd  用户名**
* **usermod**  修改用户属性
* **chage**  修改用户属性
* **groupadd** 新建用户组
* **groupdel** 删除用户组

#### 用户切换

* **su** 切换用户
  * **su  -  USERNAME** 使用 login  user 方式切换用户
* **sudo ** 以其他用户身份执行命令
  * **visudo** 设置需要使用sudo的用户(组)

#### 用户权限

* 查看用户权限
  * ![用户权限](.\imges\linux01.png)
* 字符权限表示方法
  * **r**  可读
  * **w** 可写
  * **x** 可执行
* 数字权限表示方法
  * **r = 4**
  * **w = 2**
  * **x = 1**
* 创建新文件，根据umask 值计算，属主和属组根据当前进程的用户来设定

##### 目录权限的表示方法

* **x** 进入目录
* **rx** 显示目录内的文件名
* **wx** 修改目录内的文件名

##### 修改权限命令

* **chmod** 修改文件、目录权限
  * **chmod  u+x  /tmp/testfile**
  * **chmod  755 /tmp/tesfile**
* **chown**  更改属主，属组
* **chgrp**   可以单独更改属组，不常用

##### 特殊权限

* **SUID**  用于二进制可执行文件，执行命令时取得文件属主权限
  * 如 /usr/bin/passwd
* **SGID** 用于目录，在该目录下创建新的文件和目录，权限自动更改为该目录的属组
* **SBIT**  用于目录，该目录下新建的文件和目录，仅root和自己可以删除
  * 如  /tmp

####  文件类型

* **-**  普通文件
* **d** 目录文件
* **b** 块特殊文件
* **c** 字符特殊文件
* **l** 符号链接
* **f** 命名管道
* **s** 套接字文件



 

#### 通配符

* 定义：shell 内建符号
* 用途： 操作多个相似(有简单规律)的文件
* 常用通配符
  * *****  匹配任何字符
  * **？** 配一个字符
  * **[xyz]** 匹配xyz任意一个字符
  * **[a-z]** 匹配一个范围
  * **[!xyz]或 [ ^xyz ]  ** 不匹配

#### 网络管理

* 网络状态查看
* 网络配置
* 路由命令
* 网络故障排除
* 网络服务管理
* 常用网络配置文件

##### 网络状态查看工具

###### net-tools  VS  iproute

1. **net - tools**
   * **ifconfig**
     * eth0 第一块网卡(网络接口)
     * 你的第一个网络接口可能叫做下面的名字
       * etho1  板载网卡
       * ens33  PCI-E网卡
       * enp03  无法获取物理信息的PCI-E网卡
       * CentOS7使用了一致性网络设备命名，以上都不匹配使用eth0
   * **route**
   * **netstat**
2. **iproute**
   * **ip**
   * **ss**

###### 查看网卡物理连接情况

* **mii-tool eth0**

###### 查看网关

* **route  -n**
* 使用-n参数不解析主机名

###### 网络接口命名修改

* 网卡命名规则受 **biosdevname** 和 **net.ifnames** 两个参数影响

* 编辑 **/etc/default/grub**  文件，增加 **biosdevname = 0  net.ifnames = 0**

* 更新grub

  * **grub2-mkconfig  -o  /boot/grub2/grub.cfg**

* 重启

  * **reboot**

  |       | **biosdevname** | **net.ifnames** | 网卡名 |
  | ----- | --------------- | --------------- | ------ |
  | 默认  | 0               | 1               | ens33  |
  | 组合1 | 1               | 0               | em1    |
  | 组和2 | 0               | 0               | eth0   |

##### 网络配置命令

* **ifconfig  <接口>  <IP地址>  [netmask   子网掩码]**
* **ifup <接口>**
* **ifdown <接口>**

##### 添加网关

* **route  add  default  gw <网关ip>**
* **route  add  -host <指定ip>  gw<网关ip>**
* **route  add  -net<指定网段>  netmask <子网掩码>  gw <网关ip>**

###### ip命令

* **ip addr ls**
  * 等于  **ifconfig**
* **ip  link set  dev eth0 up**
  * 等于  **ifup  eth0**
* **ip  addr add  10.0.0.1/24 dev eth0**
  * 等于 **ifconfig  eth0  10.0.0.1 netmask  255.255.255.0**
* **ip route  add  10.0.0/24  via  192.168.0.1**
  * 等于 **route  add  -net  10.0.0.0 netmask  255.255.255.0  gw 192.168.0.1**

#### 网络故障排除命令

* **ping**
* **traceroute**
* **mtr**
* **nslookup**
* **telnet**
* **tcpdump**
* **netstat**
  * **netstat -ntpl**
* **ss**
  * **ss -ntpl**

#### 网络服务管理

* 网络服务管理程序分为两种，分别是 **SysV** 和 **systemd**
  * **service  network  start | stop | restart**
  * **chkconfig  --list  network**
  * **systemctl list-unit-files NetworkManager.service**
  * **systemctl  start | stop | restart  NetworkManager **
  * **systemctl   enable | disable NetworkManager **

#### 软件安装

##### 软件包管理器

* **CentOS** 、**Redhat**  使用 **yum**  包管理器，软件安装包格式为 **rpm**
* **Debian** 、**Ubuntu** 使用 **apt** 包管理器，软件安装包格式 为 **deb**

##### rmp包

###### rpm包格式

![rpm](.\imges\linux02.png)

###### rpm命令

* **rpm** 命令常用参数
  * **-q** 查询软件包
  * **-i** 安装软件包
  * **-e** 卸载软件包

###### yum包管理器

* rpm 包的问题
  * 需要自己解决依赖问题
  * 软件包来源不可靠
*  [CentOS  yum 源](http://mirror.centos.org/cnetos/7/)
* [国内镜像源](https://mirrors.aliyun.com)

###### yum配置文件

* **/etc/yum.repos.d/CentOS-Base.repo**
* **wget -O /etc/yum.repos.d/CentOS-Base.repo**

###### yum 命令常用选项

* **install**  安装软件包
* **remove** 卸载软件包
* **lsit | grouplist**  查看软件包
* **update** 更新软件包

###### 源代码编译安装

* **wget**  软件包地址
* **tar  -zxf**  软件包名称
* **./configure  --prefix = /usr/local/名字**  配置软件安装目录
* **make  -j2** 使用2个逻辑cpu编译，加快编译速度
* **make install**

###### 升级内核

* rpm格式内核
  * 查看内核版本
    * **uname  -r**
  * 升级内核版本
    * **yum  install  kernel-3.10.0**
  * 升级已安装的其他软件包和补丁
    * **yum  update**

###### grub配置文件

* **/etc/default/grub**
* **/etc/grub.d/**
* **/boot/grub2/grub.cfg**
* **grub2-mkconfig -o /boot/grub2/grub.cfg**
* 使用单用户进入系统(忘记root密码)

#### 进程管理

* 进程的概念与查看
* 进程的控制命令
* 进程的通信方式 ——————信号
* 守护进程和系统日志
* 服务管理工具 systemctl
* SELinux简介

##### 进程概念

* 进程------运行中的程序，从程序开始运行到终止的整个生命周期
* C 程序的启动是从main 函数开始的
  * int  main (int  agrc  ,char * argv[])
* 终止的方式并不是唯一，分为正常终止和异常终止
  * 正常终止也分为从卖弄返回，带有exit等方式
  * 异常终止分为调用 abort ，接收信号等

##### 进程的查看命令

* 查看命令
  * **ps**
  * **pstree**
  * **top**
* 结论
  * 进程也是树形结构
  * 进程和权限有这密不可分的关系




