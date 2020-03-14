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

##### 进程优先级的调整

* 调整优先级
  * **nice**  范围从 -20 到 19 ，值越小优先级越高，抢占资源越多
    * **nice   -n  优先级数字    程序**
  * **renice**  重新设置优先级
    * **renice  -n   优先级数字   进程id** 
* 进程作业控制
  * **jobs**
    * 将后台进程调回到前台
    * **jobs**
    * **fg   jobs后的id**
  * & 符号
    * 让进程在后台运行   **程序  &**
* **ctrl  + z**  将程序调入后台 停止
  * **bg    jobs后的id** 重新运行

##### 进程通信

* 信号是进程间通信方式之一，典型用法是 ：终端用户输入中断命令，通过信号机制停止一个程序的运行
* 使用信号的常用快捷键和命令
  * **kill  -l**
    * **SIGINT** 通知前台进程终止进程  **ctrl + c**
    * **SIGKILL**   立即停止程序，不呢个被阻塞和处理 **kill -9  pid**

##### 守护进程

* 使用  **nohup** 与 **&**  符号配合运行一个命令(不是守护进程)
  * **nohup** 命令使进程忽略 hangup (挂起) 信号
* 使用 **screen** 命令
  * **screen**  进入 **screen** 环境
  * **ctrl  + a d ** 退出(detached) screen 环境
  * **screen  -ls** 查看 **screen** 会话
  * **screen  -r   seesionid**  恢复会话    

##### 系统日志

* **/var/log/**

  * 系统的常规日志
    * **message**
  * 内核日志
    * **dmesg**
  * 系统安全日志
    * **secure**
  * 计划任务日志
    * **cron**

##### 服务管理工具

* 服务(提供常见功能的守护进程)集中管理工具
  * **service**
    * 启动脚本目录  **/etc/init.d/**
  * **systemctl**
    * 启动脚本目录  **/usr/lib/systemd/system/**

###### init运行级别(cat   /etc/inittab)

0. 关机
1. 服务器出问题（单用户状态）
2. 无NFS的多用户模式
3. 完整的多用户模式
4. 无保留无使用
5. 桌面模式
6. 重新启动
   * 设置运行级别（例：init 0）

###### systemctl 常见操作

* systemctl 常见操作
  * **systemctl  start | stop  | restart | reload | enable | disable 服务名称**
  * 软件包安装的服务单元 **/usr/lib/systemd/system/**

#### SELinux简介

* MAC(强制访问控制)与 DAC (自主访问控制)
* 查看 SElinux 的命令
  * **getenforce**
  * **/usr/sbin/sestatus**
  * **ps -Z  and  ls -Z  and  id -Z**
* 关闭 SELinux
  * **setenforce  0**
  * **/etc/selinux/sysconfig**

#### 内存和磁盘管理

* 内存和磁盘使用率查看
* ext4 文件系统
* 磁盘配额的使用
* 磁盘的分求与挂载
* 交换分区(虚拟内存)的查看与创建
* 软件RAID的使用
* 逻辑卷管理
* 系统中华状态查看

##### 内存使用率查看

* 常用命令介绍
  * **free**
  * **top**

##### 磁盘使用率查看

* **fdisk**
  * **fdisk  -l**
* **df**
  * **df -h**
* **du**
* **ls  与 du  的区别**

#### 常见文件系统

* linux 支持多种文件系统，常见有
  * **ext4**
  * **xfs**
  * **NTFS** (需要安装额外软件)

##### ext4文件系统基本结构

* 超级块
* 超级副本
* i 节点  (inode)
* 数据块 (datablock)

##### 磁盘分区与挂载

* 常用命令
  * **fdisk**
  * **mkfs**
  * **parted**
  * **mount**
* 常见配置文件
  * **/etc/fstab**

##### 用户磁盘配额

* xfs 文件系统的用户磁盘配额 **quota**
* **mkdir  /mnt/disk1**
* **mount  -o  uquta | g quota /dev/sdb1   /mnt/ disk1**
* **chmod  1777  /mnt /disk1**
* **xfs_quota  -x  -c 'report  -ugibh'    /mnt/disk1**
* **xfs_quota  -x  -c  'limit  -u  isoft = 5 ihard = 10   user1 '   /mnt/disk1**

##### 交换分区

* 增加交换分区的大小
  * **mkswap**
  * **swapon  | swapoff**
* 使用文件制作交换分区
  * **dd  if=/dev/zero  bs=40M  count=1024  of=/swapfile**

##### 逻辑卷管理

#### 系统综合状态查询

* 使用 **sar** 命令查看系统综合状态
* 使用第三方命令查看网络流量
  * **yum install  epel-release**
  * **yum install  iftop**
  * **iftop  -P**

#### 什么使shell

* shell 是命令解释器，用于解释用户对操作系统的操作
* shell有很多
  * **cat  /etc/shells**
* CentOS 7 默认使用 Shell 是bash

##### Linux的启动过程

* **BIOS - MBR - BootLoader(grub) - kernel - sytemd - 系统初始化 - shell**

#### shell脚本

* UNIX哲学：一条命令只做一件事
* 为了组合命令和多次执行，使脚本文件来保存需要执行的命令
* 赋予该文件执行权限(**chmod  + u+rx  filename**)

##### 标准的Shell脚本要包含哪些元素

* **Sha-Bang**
* 命令
* “#” 号开头的注释
* **chmod   u + rx  filename**  可执行权限
* 执行命令
  * **bash  ./filename.sh**
  * **./filename.sh**
  * **source  ./filename.sh**
  * **.   filename.sh**

##### 内建命令和外部命令的区别

* 内建命令不需要创建子进程
* 内建命令对当前的Shell生效

##### 重定向符号

* 一个进程默认会打开标准输入、标准输出、错误输出三个文件描述符
* 输入重定向 **<**
  * read  var  < /path/to/a/file
* 输出重定向符号  **>     >>     2>     &>**
  * echo  123  > /path/to/a/file
* 输入和输出重定向组合使用
  * cat  >  /path/to/a/file   <<  EOF
  * I  am  $USER
  * EOF

#### 变量

##### 变量的定义

* 变量的命名规则
  * 字母、下划线、数字
  * 不以数字开头

##### 变量赋值

* 为变量赋值的过程，称为变量替换
  * 变量名=变量值
    * a=123
  * 使用let 为变量赋值
    * **let  a=10+20**
  * 将命令赋值给变量
    * **l=ls**
  * 将命令结果赋值给变量，使用$()或 ``
    * **let  c=$(ls-l /etc)**
  * 变量有空格等特殊字符可以包含在 " " 或 ' ' 中 

##### 变量的引用

* **${变量名} 称作对变量的引用**
* **echo  ${变量名} 查看变量的值**
* **${变量名} 在部分情况下可以省略为 $变量名**



##### 变量的默认作用范围

* 变量的导出
  * **export**
* 变量的删除
  * **unset**

##### 系统环境变量

* 环境变量：每一个Shell打开都可以获得的变量
  * **set  和 env 命令**
  * **$?  $$  $0**
  * **$PATH**
  * **$PS1**
* 位置变量
  * **$1  $2 ....  $n**

##### 环境变量配置文件

* **/etc/profile**
* **/etc/profile.d**
* **~/.bash_profile**
* **~/.bashrc**
* **/etc/bashrc**
* 执行顺序
  * **/etc/profile -->  .bash_profile -->  .bashrc --> /etc/bashrc**

##### 数组

* 定义数组
  * **IPTS=(10.0.0.1  10.0.0.2  10.0.0.3)**
* 显示数组的所有元素
  * **echo  ${IPTS[@]}**
* 显示数组个数
  * **echo  ${#IPTS[@]}**
* 显示数组第一个元素
  * **echo  ${IPTS[0]}**

#### 转义与引用

##### 特殊字符

* 特殊字符：一个字符不仅有字面意义，还有原因(**meta-meaning**)
* #注释
* ; 分号
* \ 转义符号
* "    和  ‘   引号

##### 转义符号

* 单个字符前的转义符号
  * **\n   \r   \t** 单个字母的转义
  * **\ $   \ "   \ \ ** 单个非字母的转义

##### 引用

* 常用的引用符号
  * “  双引号
  * ’  单引号
  * `  反引号

#### 运算符

##### 赋值运算符

* **=** 赋值运算符，用于算数赋值和字符串赋值
* 使用 **unset** 取消为变量的赋值
* **=** 除了赋值运算符还可以作为测试操作符

##### 算数运算符

* 基本运算符
  * **+  -  *  /  %  **  **
* 使用expr进行运算
  * **expr  4 + 5**

##### 数字常量

* 数字常量的使用方法

  * **let  ”变量名=变量值“**

  * 变量值使用0开头为八进制
  * 变量使用0x开头为十六进制

###### 双圆括号

* 双圆括号是let命令的简化
  * **(( a=10))**
  * **((a++))**
  * **echo  $((10+20))**

#### 退出与退出状态

* 退出程序命令
* **exit**
* **exit  10** 返回10给shell，返回值非0位不正常退出
* **$? ** 判断当前 shell 前一个进程是否正常退出

#### 测试命令test

* test 命令 用于检查文件或比较值
* test可以做以下测试：
  * 文件测试
  * 整数测试
  * 字符串测试
* test测试语句可以简化为 [  ] 符号
* [  ]  符号还有扩展写法[[ ]] 支持 &&、||、< 、>

#### 使用if-then语句

* if-then语句的基本用法
  * **if [ 测试条件成立 ]  或  命令返回值是否为0**
  * **then  执行命令**
  * **fi**  结束
* if-then-else 语句可以在条件不成立时也运行相应的命令
  * **if [ 测试条件成立 ] **
  * **then  执行相应命令**
  * **else  测试条件不成立，执行相应命令**
  * **fi  ** 结束
* if 扩展
  * **if  [ 测试条件成立 ]**
  * **then 执行相应命令**
  * **elif [ 测试条件成立 ]**
  * **then 执行相应命令**
  * **else  测试条件不成立，执行相应命令**
  * **fi** 结束

##### 嵌套if的使用

* if条件测试中可以在嵌套if条件测试
  * **if [ 测试条件成立 ]**
  * **then 执行相应命令**
    * **if [ 测试条件成立 ]**
    * **then 执行相应命令**
    * **fi**
  * **fi**  结束

#### 分支

* case 和 select 语句可以构成分支
  * **case  "$变量"  in**
    * **"情况1")**
      * **命令...;;**
    * **"情况2")**
      * **命令...;;**
      * **\*  )**
      * **命令...;;**
    * **esac**

#### for循环的语法

* **for  参数  in  列表**
* **do 执行命令**
* **done**  封闭一个循坏
  * 使用反引号或 **$()** 方式执行命令，命令的结果单作列表进行处理
  * 列表中包含多个变量，变量用空格分隔
  * 对文本处理，要使用文本查看命令取出文本内容
    * 默认逐行处理，如果文本出现空格会当做多行处理

#### C语言风格的for命令

* **for ((变量初始化;循坏判断;变量变化))**
* **do**
  * 循坏执行的命令
* **done**

#### while循坏

* **while  test测试是否成立**
* **do**
  * 命令
* **done**

#### util循坏

* until循坏与while循坏相反，循坏测试为假时，执行循环，为真时循坏停止

#### 使用循坏处理命令行参数

* **命令行参数可以使用$1  $2  $3  ....  ${10} ...... $n进行读取**
* **$0 代表脚本名称**
* **$*  和 $@ 代表所有位置参数**
* **$#代表位置参数的数量**

#### 自定义函数

* 函数用于 “"包含" 重复使用的命令集合
* 自定义函数
  * **function  fname(){**
  * 命令
  * **}**
* 函数执行
  * **fname**
* 函数作用范围的变量
  * **local  变量名**
* 函数参数
  * **$1  $2  $3   $4 .... $n**

 #### 系统脚本

*  系统自建了函数库，可以在脚本中引用
  * **/etc/init.d/functions**
* 自建函数库
  * **使用source  函数脚本文件 ”导入“ 函数**

#### 脚本优先级控制

* 可以使用 nice 和 renice 调整脚本优先级
* 避免出现” 不可控的 “ 死循坏
  * 死循坏导致cpu占用过高
  * 死循环导致死机

#### 捕获信号

* kill 默认会发送15号信号给应用程序
* ctrl + c 发送2 号信号 给应用程序
* 9 号信号不可阻塞

#### 计划任务

* 一次性计划任务
* 周期性计划任务
* 计划任务加锁flock

##### 一次性计划任务

* 计划任务：让计算机在指定的时间运行程序
* 计划任务分为：一次性计划任务  周期性计划任务
* 一次性计划任务
  * **at**

##### 周期性计划任务

* **cron**
  * 配置方式
    * **crontab  -e**
  * 查看现有的计划任务
    * **crontab  -l**
  * 配置格式
    * 分钟  小时  日期 星期  执行的命令
    * 注意命令的路径问题

##### 计划任务加锁

* 如果计算机不能安照预期时间运行
  * **anacontab 延时计划任务**
  * **flock锁文件**

#### 元字符

* **.** 匹配除换行符外的任意单个字符
* **\*** 匹配0次或多次任意一个跟在它前面的字符
* **[  ]** 匹配方括号中的字符类中的任意一个
* **^** 匹配开头
* **$** 匹配结尾
* **\\** 转义后面的特殊字符

###### 扩展元字符

* **+** 匹配前面的正则表达式最少出现一次
* **?** 匹配前面的正则表达式出现零次或一次
* **|**  匹配它前面或后面的正则表达式

#### 文件查找命令find

* **find  路径  查找条件 [ 补充条件 ]**

#### sed的替换命令

##### sed的模式空间

* sed的基本工作方式
  * 将文件一行为单位读取到内存(模式空间)
  * 使用sed的每个脚本对改行进行操作
  * 处理完成后输出该行

##### 替换命令 s

* **sed  's/old/new/'  filename**
* **sed -e  's/old/new/'  -e 's/old/new/'  filename  ....**
* **sed -i  's/old/new/'    's/old/new/'  filename .....**

###### 带正则表达式的替换命令s

* **sed  's/正则表达式/new/'   filename**
* **sed -r 's/扩展正则表达式/new/'  filename**

###### 全局替换

* **s/old/new/g**
  * g为全局替换，用于替换所有出现的次数
  * / 如果和正则匹配的内容冲突可以使用其他符号  如：
    * **s@old@new@g**

###### 标志位

* **s/old/new/标志位**
  * 数字，第几次出现才进行替换
  * g，每次出现都进行替换
  * p 大于模式空间的内容
    * **sed -n  'scrip'   filename 阻止默认输出**
  * w  file 将模式空间的内容写入到文件

###### 寻址

* 默认对每行进行操作，增加寻址后对匹配的行进行操作
  * **/正则表达式/s/old/new/g**
  * **行号s/old/new/g**
    * 行号可以式具体的行，也可以式最好一行 $ 符号
  * 可以式用两个寻址符号，也可以混合使用行号和正则地址

###### 分组

* 寻址可以匹配多条命令
* **/regular/ {s/old/new/ ; s/old/new/}**

###### 脚本文件

* 可以将选项保存为脚本文件，使用 -f加载脚本文件
* **sed  -f sedscript  file**

###### 删除命令

* **[寻址]d**
  * 删除模式空间内容，改变脚本的控制流，读取新的输入行

#### awk

##### awk和sed的区别

* awk更像式脚本语言
* awk用于 **比较规范** 的文本处理，用于统计数量并输出指定字段
* 使用sed将不规范的文本，处理为 **比较规范** 的文本

##### awk脚本的流程控制

* 输入数据前例程 **BEGIN{}**
* 主输入循环 **{}**
* 所有文件读取完成例程 **END{}**

##### 记录和字段

* 每一行称作 awk 的记录
* 使用空格、制表符分割开的单词称为字段
* 可以自己指分割的字段

##### 字段的引用

* awk中使用 $1  $2 .... $n表示每一个字段
  * **awk '{print  $1,$2,$3}' filename**
* awk 可以使用 -F 选项改变字段分割符
  * **awk  -F ','   '{print  $1,$2,$3}'  filename**
* 分割符可以使用正则表达式

##### awk的表达式

* 赋值操作符
* 算数操作符
* 系统变量
* 关系操作符
* 布尔操作符

###### 赋值操作符

* = 是最常用的赋值操作符
  * **var1 = ”name“**
  * **var2 = "hello"   "world"**
  * **var3 = $1**
* 其他赋值操作符
  * **++   --  +=   -=   *=   /=  %=  **

###### 算数运算符

* **+  -  *  /  %  **

###### 系统变量

* FS 和 OFS 字段分割符，OFS表示输出的字段分割符
* RS记录分割符
* NR和FNR行数
* NF字段数量，最后一个字段内容可以应 $NF取出

###### 关系操作符

* **>    <   <=   >=     ==   !=   ~     !~ **

###### 布尔操作符

* **&&  ||  ！**

##### 条件语句

* 条件语句使用if开头，根据表达式的结果来判断执行哪条语句
  * **if(表达式)**
  * **awk语句1**
  * **[ else**
  * **awk语句2**
  * **]**
* 如果有多个语句需要执行可以使用 { }将多个语句括起来

##### 循环

* while循环
  * **while(表达式)**
  * **awk语句**
* do循环
  * **do{**
  * **awk语句**
  * **} while(表达式)**

###### for循环

* **for(初始值;循环判断条件;累加)**
  * **awk语句**
* 影响控制的其他语句
  * **break**
  * **continue**

##### 数组

###### 数组的定义

* 数组：一组有某种关联的数据(变量)，通过下标依次访问
  * 数组名[下标] = 值
  * 下标可以使用数字也可以使用字符串

###### 数组的遍历

* for(变量  in  数组名)
  * 使用数组名[变量]的方式依次对每个数组的元素进行操作

###### 删除数组

* delete 数组[下标]

#### 防火墙

##### 防火墙分类

* 软件防火墙和硬件防火墙
* 包过滤防火墙和应用层防火墙
  * CentOS6 默认防火枪是 **iptables**
  * CentOS7 默认防火墙是 **firewallD(底层是netfilter)**

##### iptables的表和链

- 规则表
  - **filter nat  mangle raw**
- 规则链
  - **INPUT  OUTPUT   FORWARD**
  - **PREROUTING   POSTROUTING**

###### iptables的filter表

* **iptables  -t  filter  命令   规则链   规则**
  * 命令
    * **-L**  查看
    * **-A |  -I**  增加
    * **-D |  -F  | -P**  删除
    * **-N  |   -X   |   -E**  修改

###### iptables的nat表

* **iptables  -t  nat  命令  规则链  规则  **
  * **PREROUTING  目的地址转换**
  * **POSTROUTING  源地址转换**

###### iptables的配置文件

* **/etc/sysconfig/iptables**
* CentOS6
  * **service  iptables  save  | start | stop | restart**
* CentOS7
  * **yum install  iptables-services**

##### firewallD服务

* firewallD的特点
  * 支持区域 “zone” 概念
  * **firewall-cmd**
* **systemctl start | stop | enable | disable firewalld.service**

#### SSH服务

###### SSH服务配置文件

* **/etc/ssh/sshd_config**
  * port  22 默认端口
  * PermitRootLogin yes  是否允许root登陆
  * AuthorizedKeysFile.ssh/authorized_keys

###### SSH命令

* **systemctl  status| start | stop | restart | enable| disable  sshd.service**
* 客户端命令
  * **ssh  [ -p  端口 ] 用户@远程ip**

###### SSH公钥认证

* 常用命令
  * **ssh-keygen  -t rsa**
  * **ssh-copy-id**
    * **ssh-copy-id -i /root/.ssh/id_rsa.pub  root@192.168.40.131**
* 产生密钥的地方是客户端
* scp 远程拷贝命令



