## redis 安装

#### 下载redis

```http
https://redis.io/download/
```

#### 安装redis

```sh
yum -y install make
yum install -y gcc
tar -zxvf redis-stable.tar.gz
cd redis-stable
make
make install
```

`redis` 默认安装路径 是 `/usr/local/bin/`

拷贝`redis.conf` 到 `/myredis` 中

#### redis配置文件初始化

```
redis.conf配置文件，改完后确保生效，记得重启，记得重启
   1 默认daemonize no              改为  daemonize yes
   2 默认protected-mode  yes    改为  protected-mode no
   3 默认bind 127.0.0.1             改为  直接注释掉(默认bind 127.0.0.1只能本机访问)或改成本机IP地址，否则影响远程IP连接
   4 添加redis密码                      改为 requirepass 你自己设置的密码
```

#### 启动redis

```sh
cd /usr/local/bin/
./redis-server  /myredis/redis.conf
```

#### 连接redis

```sh
cd /usr/local/bin/
 ./redis-cli -a 123456
```

#### 关闭redis

```sh
单实例关闭：
redis-cli -a 123456 shutdown
多实例关闭，指定端口关闭:
redis-cli -p 6379 shutdown
```

