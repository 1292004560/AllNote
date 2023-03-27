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

