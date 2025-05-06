## 英语网站

```makefile
FILESERVICENAME=fileservice
FILESERVICEID :=
IDENTITYSERVICENAME=identityservice
IDENTITYSERVICEID :=
LISTENADMINSERVICENAME=listenadminservice
LISTENADMINSERVICEID :=
LISTENMAINSERVICENAME=listenmainservice
LISTENMAINSERVICEID :=
MEDIAENCODERSERVICENAME=mediaencoderservice
MEDIAENCODERSERVICEID :=
SEARCHSERVICENAME=searchservice
SEARCHSERVICENAID :=
VERSION := $(shell date +'%Y%m%d%H%M')

FILESERVICEPORT = 9001
IDENTITYSERVICEPORT = 9002
LISTENADMINSERVICEPORT = 9003
LISTENMAINSERVICEPORT = 9004
MEDIAENCODERSERVICEPORT = 9005
SEARCHSERVICEPORT = 9006

.PHONY: run-identityservice build-identityservice tag-backup-identityservice \
run-fileservice build-fileservice tag-backup-fileservice \
run-listenadminservice build-listenadminservice tag-backup-listenadminservice \
run-listenmainservice build-listenmainservice tag-backup-listenmainservice    \
run-mediaencoderservice build-mediaencoderservice tag-backup-mediaencoderservice  \
run-searchservice build-searchservice tag-backup-searchservice\
clean-identityservice

all : run-identityservice run-fileservice run-listenmainservice run-listenadminservice\
    run-mediaencoderservice run-searchservice
clean: clean-identityservice clean-fileservice clean-listenadminservice\
    clean-listenmainservice clean-mediaencoderservice clean-searchservice
######################################################################
#              IdentityService   登录认证服务                         #
######################################################################

rename-identityservice-container:
    if [ -n "$$(docker ps -a -q --filter "ancestor=${IDENTITYSERVICENAME}")" ]; \
    then \
    docker rename ${IDENTITYSERVICENAME} ${IDENTITYSERVICENAME}_${VERSION}; \
    fi

get-identityservice-container-id:
    - $(eval IDENTITYSERVICEID=$(shell docker ps | grep $(IDENTITYSERVICENAME) | awk '{print $$1}'))

run-identityservice:build-identityservice rename-identityservice-container
    docker run  --network english-web-network --name ${IDENTITYSERVICENAME} -d  -p ${IDENTITYSERVICEPORT}:80 ${IDENTITYSERVICENAME}

build-identityservice:tag-backup-identityservice
    docker build -t ${IDENTITYSERVICENAME} -f IdentityService.WebAPI/Dockerfile .

tag-backup-identityservice: stop-identityservice
    if [ $$(docker images -q ${IDENTITYSERVICENAME}:latest) ]; \
    then \
    docker tag ${IDENTITYSERVICENAME}:latest ${IDENTITYSERVICENAME}:${VERSION}; \
    fi

stop-identityservice:rm-identityservice
    if [ $$(docker ps -q --filter "ancestor=${IDENTITYSERVICENAME}") ]; \
    then \
    docker stop ${IDENTITYSERVICEID}; \
    fi

rm-identityservice:get-identityservice-container-id
    if [ $$(docker ps  -q --filter "ancestor=${IDENTITYSERVICENAME}") ]; \
    then docker rm ${IDENTITYSERVICEID}; \
    fi

clean-identityservice:
    docker rmi -f $$(docker images -q --filter "reference=identityservice*")docker rmi -f $$(docker images -q --filter "reference=identityservice*")
    
rename-identityservice-container:
    if [ -n "$$(docker ps -a -q --filter "ancestor=${IDENTITYSERVICENAME}")" ]; \
    then \
    docker rename ${IDENTITYSERVICENAME} ${IDENTITYSERVICENAME}_${VERSION}; \
    fi

######################################################################
#              FileService   文件服务                                #
######################################################################


get-fileservice-container-id:
    - $(eval FILESERVICEID=$(shell docker ps | grep $(FILESERVICENAME) | awk '{print $$1}'))

run-fileservice:build-fileservice rename-fileservice-container
    docker run  --network english-web-network --name ${FILESERVICENAME} -d  -p ${FILESERVICEPORT}:80 ${FILESERVICENAME}

build-fileservice:tag-backup-fileservice
    docker build -t ${FILESERVICENAME} -f FileService.WebAPI/Dockerfile .

tag-backup-fileservice: stop-fileservice
    if [ $$(docker images -q ${FILESERVICENAME}:latest) ]; \
    then \
    docker tag ${FILESERVICENAME}:latest ${FILESERVICENAME}:${VERSION}; \
    fi

stop-fileservice:rm-fileservice
    if [ $$(docker ps -q --filter "ancestor=${FILESERVICENAME}") ]; \
    then \
    docker stop ${FILESERVICEID}; \
    fi

rm-fileservice:get-fileservice-container-id
    if [ $$(docker ps  -q --filter "ancestor=${FILESERVICENAME}") ]; \
    then docker rm ${FILESERVICEID}; \
    fi

clean-fileservice:
    docker rmi -f $$(docker images -q --filter "reference=fileservice*")docker rmi -f $$(docker images -q --filter "reference=fileservice*")


    
rename-fileservice-container:
    if [ -n "$$(docker ps -a -q --filter "ancestor=${FILESERVICENAME}")" ]; \
    then \
    docker rename ${FILESERVICENAME} ${FILESERVICENAME}_${VERSION}; \
    fi


######################################################################
#                 听力后台管理服务 ListenAdminService                #
######################################################################


get-listenadminservice-container-id:
    - $(eval LISTENADMINSERVICEID=$(shell docker ps | grep $(LISTENADMINSERVICENAME) | awk '{print $$1}'))

run-listenadminservice:build-listenadminservice rename-listenadminservice-container
    docker run  --network english-web-network --name ${LISTENADMINSERVICENAME} -d  -p ${LISTENADMINSERVICEPORT}:80 ${LISTENADMINSERVICENAME}

build-listenadminservice:tag-backup-listenadminservice
    docker build -t ${LISTENADMINSERVICENAME} -f Listening.Admin.WebAPI/Dockerfile .

tag-backup-listenadminservice: stop-listenadminservice
    if [ $$(docker images -q ${LISTENADMINSERVICENAME}:latest) ]; \
    then \
    docker tag ${LISTENADMINSERVICENAME}:latest ${LISTENMAINSERVICENAME}:${VERSION}; \
    fi

stop-listenadminservice:rm-listenadminservice
    if [ $$(docker ps -q --filter "ancestor=${LISTENADMINSERVICENAME}") ]; \
    then \
    docker stop ${LISTENADMINSERVICENAME}; \
    fi

rm-listenadminservice:get-listenadminservice-container-id
    if [ $$(docker ps  -q --filter "ancestor=${LISTENADMINSERVICENAME}") ]; \
    then docker rm ${LISTENADMINSERVICENAME}; \
    fi

clean-listenadminservice:
    docker rmi -f $$(docker images -q --filter "reference=listenadminservice*")docker rmi -f $$(docker images -q --filter "reference=listenadminservice*")

    
rename-listenadminservice-container:
    if [ -n "$$(docker ps -a -q --filter "ancestor=${LISTENADMINSERVICENAME}")" ]; \
    then \
    docker rename ${LISTENADMINSERVICENAME} ${LISTENADMINSERVICENAME}_${VERSION}; \
    fi



######################################################################
#                 听力服务 ListenMainService                         #
######################################################################


get-listenmainservice-container-id:
    - $(eval LISTENMAINSERVICEID=$(shell docker ps | grep $(LISTENMAINSERVICENAME) | awk '{print $$1}'))

run-listenmainservice:build-listenmainservice rename-listenmainservice-container
    echo ${LISTENMAINSERVICENAME}
    docker run  --network english-web-network --name ${LISTENMAINSERVICENAME} -d  -p ${LISTENMAINSERVICEPORT}:80 ${LISTENMAINSERVICENAME}

build-listenmainservice:tag-backup-listenmainservice
    echo ${LISTENMAINSERVICENAME}
    docker build -t ${LISTENMAINSERVICENAME} -f Listening.Main.WebAPI/Dockerfile .

tag-backup-listenmainservice: stop-listenmainservice
    if [ $$(docker images -q ${LISTENMAINSERVICENAME}:latest) ]; \
    then \
    docker tag ${LISTENMAINSERVICENAME}:latest ${LISTENMAINSERVICENAME}:${VERSION}; \
    fi

stop-listenmainservice:rm-listenmainservice
    if [ $$(docker ps -q --filter "ancestor=${LISTENMAINSERVICENAME}") ]; \
    then \
    docker stop ${LISTENMAINSERVICEID}; \
    fi

rm-listenmainservice:get-listenmainservice-container-id
    if [ $$(docker ps  -q --filter "ancestor=${LISTENMAINSERVICENAME}") ]; \
    then docker rm ${LISTENMAINSERVICEID}; \
    fi

clean-listenmainservice:
    docker rmi -f $$(docker images -q --filter "reference=listenmainservice*")docker rmi -f $$(docker images -q --filter "reference=listenmainservice*")


    
rename-listenmainservice-container:
    if [ -n "$$(docker ps -a -q --filter "ancestor=${LISTENMAINSERVICENAME}")" ]; \
    then \
    docker rename ${LISTENMAINSERVICENAME} ${LISTENMAINSERVICENAME}_${VERSION}; \
    fi



######################################################################
#                 解码服务 MediaEncoderService                       #
######################################################################


get-mediaencoderservice-container-id:
    - $(eval MEDIAENCODERSERVICEID=$(shell docker ps | grep $(MEDIAENCODERSERVICENAME) | awk '{print $$1}'))

run-mediaencoderservice:build-mediaencoderservice rename-mediaencoderservice-container
    docker run  --network english-web-network --name ${MEDIAENCODERSERVICENAME} -d  -p ${MEDIAENCODERSERVICEPORT}:80 ${MEDIAENCODERSERVICENAME}

build-mediaencoderservice:tag-backup-mediaencoderservice
    docker build -t ${MEDIAENCODERSERVICENAME} -f MediaEncoder.WebAPI/Dockerfile .

tag-backup-mediaencoderservice: stop-mediaencoderservice
    if [ $$(docker images -q ${MEDIAENCODERSERVICENAME}:latest) ]; \
    then \
    docker tag ${MEDIAENCODERSERVICENAME}:latest ${MEDIAENCODERSERVICENAME}:${VERSION}; \
    fi

stop-mediaencoderservice:rm-mediaencoderservice
    if [ $$(docker ps -q --filter "ancestor=${MEDIAENCODERSERVICENAME}") ]; \
    then \
    docker stop ${MEDIAENCODERSERVICEID}; \
    fi

rm-mediaencoderservice:get-mediaencoderservice-container-id
    if [ $$(docker ps  -q --filter "ancestor=${MEDIAENCODERSERVICENAME}") ]; \
    then docker rm ${MEDIAENCODERSERVICEID}; \
    fi

clean-mediaencoderservice:
    docker rmi -f $$(docker images -q --filter "reference=mediaencoderservice*")docker rmi -f $$(docker images -q --filter "reference=mediaencoderservice*")

rename-mediaencoderservice-container:
    if [ -n "$$(docker ps -a -q --filter "ancestor=${MEDIAENCODERSERVICENAME}")" ]; \
    then \
    docker rename ${MEDIAENCODERSERVICENAME} ${MEDIAENCODERSERVICENAME}_${VERSION}; \
    fi


######################################################################
#                 搜索服务 SearchService                             #
######################################################################


get-searchservice-container-id:
    - $(eval SEARCHSERVICEID=$(shell docker ps | grep $(SEARCHSERVICENAME) | awk '{print $$1}'))

run-searchservice:build-searchservice rename-searchservice-container
    docker run  --network english-web-network --name ${SEARCHSERVICENAME} -d  -p ${SEARCHSERVICEPORT}:80 ${SEARCHSERVICENAME}

build-searchservice:tag-backup-searchservice
    docker build -t ${SEARCHSERVICENAME} -f SearchService.WebAPI/Dockerfile .

tag-backup-searchservice: stop-searchservice
    if [ $$(docker images -q ${SEARCHSERVICENAME}:latest) ]; \
    then \
    docker tag ${SEARCHSERVICENAME}:latest ${SEARCHSERVICENAME}:${VERSION}; \
    fi

stop-searchservice:rm-searchservice
    if [ $$(docker ps -q --filter "ancestor=${SEARCHSERVICENAME}") ]; \
    then \
    docker stop ${SEARCHSERVICEID}; \
    fi

rm-searchservice:get-searchservice-container-id
    if [ $$(docker ps  -q --filter "ancestor=${SEARCHSERVICENAME}") ]; \
    then docker rm ${SEARCHSERVICEID}; \
    fi

clean-searchservice:
    docker rmi -f $$(docker images -q --filter "reference=searchservice*")docker rmi -f $$(docker images -q --filter "reference=searchservice*")

rename-searchservice-container:
    if [ -n "$$(docker ps -a -q --filter "ancestor=${SEARCHSERVICENAME}")" ]; \
    then \
    docker rename ${SEARCHSERVICENAME} ${SEARCHSERVICENAME}_${VERSION}; \
    fi
```

## one-stop-service

```makefile
JPPROJECTSERVICE = jpprojectservice
VERSION := $(shell date +'%Y%m%d%H%M')
.PHONY: run build tag-backup stop start rm create-network run-postgresql
CONTAINERNAME :=
all : run
PORT = 9007
######################################################################
#              JpProject                                             #
######################################################################
get-container-name:
        -$(eval CONTAINERNAME=$(shell docker ps | grep $(JPPROJECTSERVICE) | awk '{print $$1}'))
run: build
        - docker run --name ${JPPROJECTSERVICE} --network one-stop-service -d  -p ${PORT}:8080 ${JPPROJECTSERVICE} 
build: tag-backup
        - docker build -t ${JPPROJECTSERVICE} -f JpProject.WebAPI/Dockerfile .

tag-backup: stop
        - docker tag ${JPPROJECTSERVICE}:latest ${JPPROJECTSERVICE}:${VERSION}

rm: stop get-container-name
        - docker rm ${CONTAINERNAME}
stop: get-container-name
        - docker stop ${CONTAINERNAME}

start:  get-container-name
        - docker start ${CONTAINERNAME}
restart:
        - docker restart ${CONTAINERNAME}

create-network:
        - docker network create -d bridge one-stop-service

run-postgresql: create-network
        - docker volume create pgdata
        - docker run --name postgresql --network one-stop-service -p 5432:5432 -e POSTGRES_PASSWORD=123456 -v pgdata:/var/lib/postgresql/data --restart=always -d postgres
                                                            
```

## 清理docker

```shell
docker volume ls -qf dangling=true 


[root@VM-4-10-centos ~]# docker system df
TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
Images          15        12        9.164GB   1.742GB (19%)
Containers      13        13        4.999GB   0B (0%)
Local Volumes   6         6         1.057GB   0B (0%)
Build Cache     0         0         0B        0B


# 删除所有dangling数据卷（即无用的Volume，僵尸文件）
docker volume rm $(docker volume ls -qf dangling=true)

# 删除所有dangling镜像（即无tag的镜像）
docker rmi $(docker images | grep "^<none>" | awk "{print $3}")

# 删除所有关闭的容器
docker ps -a | grep Exit | cut -d ' ' -f 1 | xargs docker rm


# 删除关闭的容器、无用的数据卷和网络
docker system prune
# 删除更彻底，可以将没有容器使用Docker镜像都删掉
docker system prune -a
```

## 一次构建两个前端镜像的Dockerfile

```dockerfile
# 构建ui
FROM node:21 AS builder-ui
WORKDIR /app
COPY Noodles.LnEnUI/package.json Noodles.LnEnUI/package-lock.json ./
RUN npm install --force
COPY Noodles.LnEnUI/ .
RUN npm run build

# 构建admin
FROM node:21 AS builder-admin
WORKDIR /app
COPY Noodles.LnEnFront/package.json Noodles.LnEnFront/package-lock.json ./
RUN npm install --force
COPY Noodles.LnEnFront/ .
RUN npm run build

# 第二阶段：生成生产环境镜像
FROM nginx
RUN mkdir /usr/share/nginx/html/englishadmin && mkdir /usr/share/nginx/html/englishui
COPY --from=builder-admin /app/dist/ /usr/share/nginx/html/englishadmin
COPY --from=builder-ui /app/dist/ /usr/share/nginx/html/englishui
COPY nginx.conf /etc/nginx/
WORKDIR /usr/share/nginx/html
EXPOSE 8089
EXPOSE 8085
CMD ["nginx", "-g", "daemon off;"] 
```

## 部署rabbitmq

```shell
docker run -d --hostname rabbitmq --name rabbitmq --network english-web-network -p 15672:15672 -p 5672:5672 rabbitmq

docker exec -it rabbitmq bash


rabbitmq-plugins enable rabbitmq_management
```

## 部署sqlserve

```shell
docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=zhoushuiping..shiliang123456" \
   -p 1433:1433 --name sqlserver --network english-web-network --hostname sqlserver \
   -d \
   mcr.microsoft.com/mssql/server:2022-latest
```

## 部署redis

```shell
docker run -d --hostname english-redis --name redis --network english-web-network -d  redis
```

