## 过滤镜像

* `dangling` ： 可以指定true或者false，仅返回虚悬镜像(true) ，或者非虚悬镜像(false)
* `before` : 需要镜像名称或ID作为参数，返回在之前被创建的全部镜像
* `since` ： 与before 类似，不过返回的是指定镜像之后创建的全部镜像。
* `label` : 根据标注(label) 的名称或者值，对镜像进行过滤
* `reference` : 

```sh
docker images --filter dangling=true
docker images --filter=reference="*:latest"
```

## 格式化输出

```sh
docker images  --format "{{.Repository}}: {{.Tag}} : {{.Size}}"
```

## 搜索镜像

```sh
docker search apline --filter "is-official=true" # 列出官方镜像

docker search alpine --filter "is-automated=true"  # 列出自动构建的镜像
```

```sh
systemctl is-active docker
```

## 容器重启策略

```sh
docker run --name neversaydie -it --restart always alpine sh
# 当daemon重启的时候，停止的容器也会被重启
```

```sh
# always 和 unless-stopped 的最大区别，就是--restart unless-stopped 并处于Stopped(Exited) 状态的容器，不会在Docker daemon 重启的时候被重启
docker run -d --name always --restart always alpine sleep 1d

docker run -d --name unless-stopped --restart unless-stopped alpine sleep 1d

docker stop unless-stopped

systemctl restart docker

--restart on-failure 策略会在容器退出并且返回值不是0的时候重启容器
```

```sh
docker rm $(docker container ls -aq ) -f
```

## 是否会新建镜像层

如果指令的作用是向镜像中增添新的文件或者程序，那么这条指令就会新建镜像层；如果告诉docker如何构建或者如何运行应用程序，那么就只会增加镜像的元数据。

```sh
docker image inspect web:v1 | tail -n 15
```

## 如何优化镜像

新增镜像层越多镜像就越大，常见解决镜像大小的简单方法是 通过使用 `&&` 连接多个命令以及使用反斜杠`\` 换行的方法，将多个命令包含在一个`RUN` 指令中。

## 多阶段构建

```dockerfile
FROM node:latest AS storefront
WORKDIR /usr/src/atsea/app/react-app
COPY react-app .
RUN npm install
RUN npm run build

FROM maven:latest AS appserver
WORKDIR /usr/src/atsea
COPY pom.xml .
RUN mvn -B -f pom.xml -s /usr/share/maven/ref/settings-docker.xml dependency
\:resolve
COPY . .
RUN mvn -B -s /usr/share/maven/ref/settings-docker.xml package -DskipTests

FROM java:8-jdk-alpine AS production
RUN adduser -Dh /home/gordon gordon
WORKDIR /static
COPY --from=storefront /usr/src/atsea/app/react-app/build/ .
WORKDIR /app
COPY --from=appserver /usr/src/atsea/target/AtSea-0.0.1-SNAPSHOT.jar .
ENTRYPOINT ["java", "-jar", "/app/AtSea-0.0.1-SNAPSHOT.jar"]
CMD ["--spring.profiles.active=postgres"]
```

```sh
docker build 命令加入 --nocache=true 参数可以强制忽略对缓存的使用
```

```sh
docker build 命令增加 --squash 参数创建一个合并的镜像
```

```sh
使用apt包管理器时，则应该执行 apt-get install 命令时增加 no-install-recommands 参数，这能确保apt仅安装核心依赖包，而不是推荐和建议的包，这样能够显著减少不必要包的下载数量
```

```sh
docker build -t 指定标签 -f 可以指定任意目录的Dockerfile，也可以是远程的。
```

## docker-compose

```sh
docker-compose up -d  # 用于部署一个Compose应用。默认情况下该命令会读取名为docker-compose.yml 或docker-compose.yaml的文件，当然也可以使用 -f 指定其他文件名。通常情况下会使用 -d 参数令应用在后台启动
docker-compose stop  # 命令会停止Compose应用相关的所有容器。但是不会删除它们。被停止的应用可以很容易地通过docker-compose restart 命令重新启动。
docker-compose rm # 命令用于删除已停止的Compose应用。它会删除网络，但是不会删除卷和镜像
docker-compose ps # 命令用于列出Compose应用中的各个容器。
docker-compose down # 会停止运行的Compose应用。它会删除容器和网络。但是不会删除镜像和卷

```

## docker-swarm

```sh
docker swarm init \
  --advertise-addr 10.0.0.1:2377 \
  --listen-addr 10.0.0.1:2377
docker swarm init
 会通知Docker来初始化一个新的Swarm，并将自身设置为第一个管理节点。同时也会使该节点开启Swarm模式。

--advertise-addr
 指定其他节点用来连接到当前管理节点的IP和端口。这一属性是可选的，当节点上有多个IP时，可以用于指定使用哪个IP。此外，还可以用于指定一个节点上没有的IP，比如一个负载均衡的IP。

--listen-addr
 指定用于承载Swarm流量的IP和端口。其设置通常与--advertise-addr
 相匹配，但是当节点上有多个IP的时候，可用于指定具体某个IP。并且，如果--advertise-addr
 设置了一个远程IP地址（如负载均衡的IP地址），该属性也是需要设置的。建议执行命令时总是使用这两个属性来指定具体IP和端口。

```

### 列出Swarm中的节点

```sh
docker node ls
```

### 获取添加管理节点的Swarm命令

```sh
dockr swarm join-token manager
```

### 获取添加工作节点的Swarm命令

```sh
docker swarm join-token worker
```

### 启用自动锁

```sh
docker swarm update --autolock=true
```

## docker swarm 服务

```sh
docker service create --name web-fe \
   -p 8080:8080 \
   --replicas 5 \
   nigelpoulton/pluralsight-docker-ci
```

### 查看服务

```sh
docker service ls

docker service ps web-fe # 查看服务副本列表及各副本状态
docker service inspect --pretty web-fe
```

## Docker Swarm 常用命令

```sh
docker swarm init
 命令用户创建一个新的Swarm。执行该命令的节点会成为第一个管理节点，并且会切换到Swarm模式。

docker swarm join-token
 命令用于查询加入管理节点和工作节点到现有Swarm时所使用的命令和Token。要获取新增管理节点的命令，请执行docker swarm join-token manager
 命令；要获取新增工作节点的命令，请执行docker swarm join-token worker
 命令。

docker node ls
 命令用于列出Swarm中的所有节点及相关信息，包括哪些是管理节点、哪个是主管理节点。

docker service create
 命令用于创建一个新服务。

docker service ls
 命令用于列出Swarm中运行的服务，以及诸如服务状态、服务副本等基本信息。

docker service ps <service>
 命令会给出更多关于某个服务副本的信息。
```

## docker 网络

### 基础理论

在顶层设计中，Docker网络架构由3个主要部分构成：CNM、Libnetwork和驱动。

CNM是设计标准。在CNM中，规定了Docker网络架构的基础组成要素。
Libnetwork是CNM的具体实现，并且被Docker采用。Libnetwork通过Go语言编写，并实现了CNM中列举的核心组件。
驱动通过实现特定网络拓扑的方式来拓展该模型的能力。

### CNM

Docker网络架构的设计规范是CNM。CNM中规定了Docker网络的基础组成要素，完整内容见GitHub的docker/libnetwork库。
推荐通篇阅读该规范，不过其实抽象来讲，CNM定义了3个基本要素：沙盒（Sandbox）、终端（Endpoint）和网络（Network）。

**沙盒**
是一个独立的网络栈。其中包括以太网接口、端口、路由表以及DNS配置。

**终端**
 就是虚拟网络接口。就像普通网络接口一样，终端主要职责是负责创建连接。在CNM中，终端负责将沙盒连接到网络。

**网络**
 是802.1d网桥（类似大家熟知的交换机）的软件实现。因此，网络就是需要交互的终端的集合，并且终端之间相互独立。

### Libnetwork

CNM是设计规范文档，Libnetwork是标准的实现。Libnetwork是开源的，采用Go语言编写，它跨平台（Linux以及Windows），并且被Docker所使用。

在Docker早期阶段，网络部分代码都存在于daemon当中。这简直就是噩梦——daemon变得臃肿，并且不符合UNIX工具模块化设计原则，即既能独立工作，又易于集成到其他项目。所以，Docker将该网络部分从daemon中拆分，并重构为一个叫作Libnetwork的外部类库。现在，Docker核心网络架构代码都在Libnetwork当中。

正如读者期望，Libnetwork实现了CNM中定义的全部3个组件。此外它还实现了本地服务发现（Service Discovery）、基于Ingress的容器负载均衡，以及网络控制层和管理层功能。

### 驱动

如果说Libnetwork实现了控制层和管理层功能，那么驱动就负责实现数据层。比如，网络连通性和隔离性是由驱动来处理的，驱动层实际创建网络对象也是如此

Docker封装了若干内置驱动，通常被称作原生驱动或者本地驱动。在Linux上包括Bridge 、Overlay以及Macvlan，在Windows上包括NAT、Overlay 、Transport 以及L2 Bridge

第三方也可以编写Docker网络驱动。这些驱动叫作远程驱动，例如Calico 、Contiv 、Kuryr以及Weave 。

每个驱动都负责其上所有网络资源的创建和管理。举例说明，一个叫作"prod-fe-cuda"的覆盖网络由Overlay驱动所有并管理。

这意味着Overlay 驱动会在创建、管理和删除其上网络资源的时候被调用。

为了满足复杂且不固定的环境需求，Libnetwork支持同时激活多个网络驱动。这意味着Docker环境可以支持一个庞大的异构网络。

