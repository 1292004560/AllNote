## 什么是 Systemd

systemd 是 Linux 系统的一组基本构建块。于 2010 年首次推出，用于取代传统的 System V init 系统。它旨在提高启动速度，更有效地管理系统服务。如今，systemd 已成为许多流行 Linux 发行版的默认系统，包括 Ubuntu、Fedora 和 Red Hat Enterprise Linux等。

几乎所有版本的 Linux 都自带 systemd，但如果你的系统没有自带 systemd，可以通过运行以下命令安装：

```sh
sudo apt-get install -y systemd
```

查看 systemd 的版本：`systemd --version`

```sh
root@VM-4-10-ubuntu:~# systemd --version
systemd 249 (249.11-0ubuntu3.9)
+PAM +AUDIT +SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY -P11KIT -QRENCODE +BZIP2 +LZ4 +XZ +ZLIB +ZSTD -XKBCOMMON +UTMP +SYSVINIT default-hierarchy=unified
```

在 systemd 之前，Linux 的启动一直采用 init 进程，如用下面的命令启动服务：

```sh
sudo /etc/init.d/apache2 start
service apache2 start
```

这种方法有两个缺点：

- 一、是启动时间长：init 进程是串行启动，只有前一个进程启动完，才会启动下一个进程。
- 二、是启动脚本复杂：init 进程只是执行启动脚本，不管其他事情，脚本需要自己处理各种情况，这往往使得脚本变得很长。

## Systemd 是守护进程吗

systemd 并不是一个守护进程。相反，它是一个为 Linux 提供大量系统组件的软件套件。其中主要组件是一个 "系统和服务管理器"，可作为引导用户空间和管理用户进程的系统。还能替代各种守护进程和实用程序，从设备、登录管理以及网络连接管理和事件记录。

设计目标：在不同的 Linux 发行版中实现服务配置和行为的标准化，为系统的启动和管理提供一套完整的解决方案。根据 Linux 惯例，字母 d 是守护进程（daemon）的缩写。Systemd 这个名字的含义，就是它要守护整个系统。使用了 Systemd，就不需要再用 init 了。Systemd 取代了 initd，成为系统的第一个进程（PID 等于 1），其他进程都是它的子进程。

## Systemd 的主要功能

systemd 有很多功能，比如: 积极并行化操作、方便按需启动守护进程、使用 Linux 控制组监控进程、管理挂载点和自动挂载点，以及实现复杂的基于事务依赖关系的服务控制逻辑。

此外，还支持 SysV 和 LSB 启动脚本，可替代 SysVinit，提供一个日志守护进程和用于管理基本系统配置的实用程序。

## systemctl命令

systemd 的主要命令，用于管理系统

```shell
sudo systemctl reboot       # 重启系统
sudo systemctl poweroff     # 关闭系统，切断电源
sudo systemctl halt         # CPU 停止工作
sudo systemctl suspend      # 暂停系统
sudo systemctl hibernate    # 让系统进入冬眠状态
sudo systemctl hybrid-sleep # 让系统进入交互式休眠状态
sudo systemctl rescue       # 启动进入救援状态（单用户状态）
```

## systemd-analyze命令

用于查看启动耗时

```shell
systemd-analyze                             # 查看启动耗时
systemd-analyze blame                       # 查看每个服务的启动耗时
systemd-analyze critical-chain              # 显示瀑布状的启动过程流
systemd-analyze critical-chain docker.service  # 显示指定服务的启动流
```

## hostnamectl 命令

查看当前主机的信息

```shell
hostnamectl                         # 显示当前主机的信息
sudo hostnamectl set-hostname xxx   # 设置主机名
```

## localectl 命令

查看本地化设置

```sh
localectl                                   # 查看本地化设置
sudo localectl set-locale LANG=en_GB.utf8   # 设置本地化参数
sudo localectl set-keymap en_GB
```

## timedatectl 命令

查看当前时区设置

```sh
timedatectl                                     # 查看当前时区设置
timedatectl list-timezones                      # 显示所有可用的时区
sudo timedatectl set-timezone America/New_York  # 设置当前时区
sudo timedatectl set-time YYYY-MM-DD
sudo timedatectl set-time HH:MM:SS
```

## loginctl 命令

查看当前登录的用户

```shell
loginctl list-sessions      # 列出当前 session
loginctl list-users         # 列出当前登录用户
loginctl show-user root   # 列出显示指定用户的信息
```

## Unit

Systemd 可以管理所有系统资源，不同的资源统称为 Unit（单位）；

1. Unit 种类(12种)

```shell
Service unit    # 系统服务
Target unit     # 多个 Unit 构成的一个组
Device Unit     # 硬件设备
Mount Unit      # 文件系统的挂载点
Automount Unit  # 自动挂载点
Path Unit       # 文件或路径
Scope Unit      # 不是由 Systemd 启动的外部进程
Slice Unit      # 进程组
Snapshot Unit   # Systemd 快照，可以切回某个快照
Socket Unit     # 进程间通信的 socket
Swap Unit       # swap 文件
Timer Unit      # 定时器
```

2. `systemctl list-units` 命令

可以查看当前系统的所有 Unit

```shell
systemctl list-units                        # 列出正在运行的 Unit
systemctl list-units --all                  # 列出所有 Unit，包括没有找到配置文件的或者启动失败的
systemctl list-units --all --state=inactive # 列出所有没有运行的 Unit
systemctl list-units --failed               # 列出所有加载失败的 Unit
systemctl list-units --type=service         # 列出所有正在运行的、类型为 service 的 Unit
```

3. Unit 状态

systemctl status 命令用于查看系统状态和单个 Unit 的状态；

```sh
systemctl status                                            # 显示系统状态
sysystemctl status docker.service                           # 显示单个 Unit 的状态
systemctl -H root@192.168.92.131 status docker.service      # 显示远程主机的某个 Unit 的状态 
```

除了 systemctl 命令，status 还提供了三个查询状态的简单方法，主要供脚本内部的判断语句使用。

```sh
sudo systemctl is-active docker.service    # 显示某个 Unit 是否正在运行
sudo systemctl is-failed docker.service    # 显示某个 Unit 是否处于启动失败状态
sudo systemctl is-enabled docker.service   # 显示某个 Unit 服务是否建立了启动链接
```

4. Unit 管理

对于用户来说，最常用的是下面这些命令，用于启动和停止 Unit（主要是 service）;

```sh
sudo systemctl start docker.service                     # 立即启动一个服务
sudo systemctl stop docker.service                      # 立即停止一个服务
sudo systemctl restart docker.service                   # 重启一个服务
sudo systemctl kill docker.service                      # 杀死一个服务的所有子进程
sudo systemctl reload docker.service                    # 重新加载一个服务的配置文件
sudo systemctl daemon-reload                            # 重载所有修改过的配置文件
sudo systemctl show docker.service                      # 显示某个 Unit 的所有底层参数
sudo systemctl show -p CPUShares docker.service         # 显示某个 Unit 的指定属性的值
sudo systemctl set-propertydocker.service CPUShares=500 # 设置某个 Unit 的指定属性
```

5. 依赖关系

Unit 之间存在依赖关系：A 依赖于 B，就意味着 Systemd 在启动 A 的时候，同时会去启动 B。有些依赖是 Target 类型（详见下文），默认不会展开显示。如果要展开 Target，就需要使用 –all 参数；

```sh
systemctl list-dependencies --all xxx # 命令列出一个 Unit 的所有依赖。
```

## Target

启动操作系统时，需要启动大量的 Unit。如果每一次启动，都要一一写明本次启动需要哪些 Unit，显然非常不方便。Systemd 的解决方案就是 Target。简单说，Target 就是一个 Unit 组，包含许多相关的 Unit 。启动某个 Target 的时候，Systemd 就会启动里面所有的 Unit。从这个意义上说，Target 这个概念类似于"状态点"，启动某个 Target 就好比启动到某种状态。传统的 init 启动模式里面，有 RunLevel 的概念，跟 Target 的作用很类似。不同的是，RunLevel 是互斥的，不可能多个 RunLevel 同时启动，但是多个 Target 可以同时启动。

```shell
systemctl list-unit-files --type=target         # 查看当前系统的所有 Target
systemctl list-dependencies multi-user.target   # 查看一个 Target 包含的所有 Unit
systemctl get-default                           # 查看启动时的默认 Target
sudo systemctl set-default multi-user.target    # 设置启动时的默认 Target

# 切换 Target 时，默认不关闭前一个 Target 启动的进程
# systemctl isolate 命令改变这种行为
sudo systemctl isolate multi-user.target        # 关闭前一个 Target 里面所有不属于后一个 Target 的进程
```

## 日志管理

Systemd 统一管理所有 Unit 的启动日志。带来的好处就是，可以只用` journalctl` 一个命令，查看所有日志（内核日志和应用日志），日志的配置文件是
`/etc/systemd/journald.conf`，`journalctl` 功能强大，用法非常多。

```shell
sudo journalctl                                         # 查看所有日志（默认情况下 ，只保存本次启动的日志）
sudo journalctl -k                                      # 查看内核日志（不显示应用日志）
sudo journalctl -b                                      # 查看系统本次启动的日志
sudo journalctl -b -0
sudo journalctl -b -1                                   # 查看上一次启动的日志（需更改设置）
sudo journalctl --since="2024-03-20 18:17:16"           # 查看指定时间的日志
sudo journalctl --since "20 min ago"
sudo journalctl --since yesterday
sudo journalctl --since "2024-03-10" --until "2024-03-30 03:00"
sudo journalctl --since 09:00 --until "1 hour ago"
sudo journalctl -n                                      # 显示尾部的最新 10 行日志
sudo journalctl -n 20                                   # 显示尾部指定行数的日志
sudo journalctl -f                                      # 实时滚动显示最新日志
sudo journalctl /usr/lib/systemd/systemd                # 查看指定服务的日志
sudo journalctl _PID=1                                  # 查看指定进程的日志
sudo journalctl /usr/bin/bash                           # 查看某个路径的脚本的日志
sudo journalctl _UID=33 --since today                   # 查看指定用户的日志
sudo journalctl -u docker.service                        # 查看某个 Unit 的日志
sudo journalctl -u docker.service --since today
sudo journalctl -u docker.service -f                     # 实时滚动显示某个 Unit 的最新日志
sudo journalctl -u docker.service -u atd.service --since today    # 合并显示多个 Unit 的日志
# 查看指定优先级（及其以上级别）的日志，共有 8 级
# 0: emerg
# 1: alert
# 2: crit
# 3: err
# 4: warning
# 5: notice
# 6: info
# 7: debug
sudo journalctl -p err -b
sudo journalctl --no-pager                              # 日志默认分页输出，--no-pager 改为正常的标准输出
sudo journalctl -b -u docker.service -o json             # 以 JSON 格式（单行）输出
sudo journalctl -b -u docker.serviceqq -o json-pretty    # 以 JSON 格式（多行）输出，可读性更好
sudo journalctl --disk-usage                            # 显示日志占据的硬盘空间
sudo journalctl --vacuum-size=1G                        # 指定日志文件占据的最大空间
sudo journalctl --vacuum-time=1years                    # 指定日志文件保存多久
```

## 在 Linux 中创建 Systemd 服务

systemd 服务在 unit 文件中定义（unit 是服务和系统资源，如设备、套接字、挂载点等的表示形式）。自定义服务 unit 文件应存储在 /etc/systemd/system/ 目录中，扩展名必须是 .service。例如，自定义 test-app 服务使用
`/etc/systemd/system/test-app.service unit`文件。

unit 文件是一种纯文本 ini-style 文件，以 .service 结尾，由 Unit、Service 和 Install 三部分组成；

- [Unit] => 启动顺序与依赖关系;
- [Service] => 启动行为定义;
- [Install] => 服务安装定义;

例如：

```shell
[Unit]   
Description=test        # 简单描述服务
After=network.target    # 描述服务类别，表示本服务需要在network服务启动后在启动
Before=xxx.service      # 表示需要在某些服务启动之前启动，After和Before字段只涉及启动顺序，不涉及依赖关系

[Service] 
Type=forking            # 设置服务的启动方式
User=USER               # 设置服务运行的用户
Group=USER              # 设置服务运行的用户组
WorkingDirectory=/PATH  # 设置服务运行的路径(cwd)
KillMode=control-group  # 定义systemd如何停止服务
Restart=no              # 定义服务进程退出后，systemd的重启方式，默认是不重启
ExecStart=/start.sh     # 服务启动命令，命令需要绝对路径（采用sh脚本启动其他进程时Type须为forking）

[Install]   
WantedBy=multi-user.target  # 多用户
```

## 自定义Systemd服务案例

要在 systemd 下以服务形式运行应用程序、或脚本，可以按如下方法创建一个新的 systemd 服务。

首先，在 /etc/systemd/system/ 下创建名为 django-myapps.service 的服务 unit 文件（切记用服务或应用程序的实际名称替换 django-myapps）：

创建 django 应用：django-admin、 startproject 、myapps

`/etc/systemd/system/django-myapps.service`:

```shell
[Unit]
Description=Gunicorn daemon for serving myapps
After=network.target

[Service]
User=root
Group=root
WorkingDirectory=/home/workspace/examples/myapps
Environment="PATH=/home/workspace/py-env/py3.11-dev-env/bin"
ExecStart=/home/workspace/py-env/py3.11-dev-env/bin/gunicorn --worker-class=gevent -w 2 -b 0.0.0.0:8000 myapps.wsgi:application --log-level=info --access-logfile=/tmp/gunicorn/access.log --error-logfile=/tmp/gunicorn/error.log
ExecReload=/bin/kill -s HUP $MAINPID
RestartSec=5

[Install]
WantedBy=multi-user.target
```

简要介绍上述配置指令：

- Description: 指定服务的描述;
- After: 定义了与 network.target 的关系, 在这种情况下，django-myapps.service 会在 network.target 启动后启动；
- User: 指定服务运行用户；
- Group: 指定服务运行组；
- WorkingDirectory: 设置执行服务的工作目录；
- Environment: 设置执行服务环境变量；
- ExecStart: 定义启动该服务时要执行的命令及其参数；
- ExecReload: 定义触发服务配置重载时要执行的命令；
- WantedBy: 当使用 systemctl enable 命令启用 django-myapps.service unit时，在列出的每个unit的 .wants/ 或 .requires/ 目录中创建一个符号链接，本例中为 multi-user.target；

保存 django-myapps.service 文件并关闭，运行以下命令，重新加载 systemd：

```shell
sudo systemctl daemon-reload
```

**启动/激活服务**

```shell
systemctl start django-myapps.service
```

**检查服务状态**

```shell
systemctl status django-myapps.service
```

**系统启动时启动**

使用 systemctl enable 命令设置启动时启动，同时可以使用 systemctl is-enable 命令检查服务是否已启用，如下所示：

```shell
# 开启随系统启动而启动
systemctl enable django-myapps.service
# 检查是否开启
systemctl is-enabled django-myapps.service
# 同时启用和启动服务
systemctl enable --now django-myapps.service
```

**禁用服务**

使用 systemctl disable 命令禁用服务，以防止它在系统启动时启动，通过 systemctl is-enable 命令检查服务是否已禁用：

```shell
systemctl disable django-myapps.service
systemctl is-disabled django-myapps.service
systemctl disable --now django-myapps.service
```

