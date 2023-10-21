## Master节点 : 整个集群的控制中枢

* `Kube-APIServer`：集群的控制中枢，各个模块之间信息交互都需要经过`Kube-APIServer`，同时它也是集群管理、资源配置、整个集群安全机制的入口
* `Controller-Manager`：集群的状态管理器，保证Pod或其他资源达到期望值，也是需要和`APIServer`进行通信，在需要的时候创建、更新或删除它所管理的资源
* `Scheduler`：集群的调度中心，它会根据指定的一系列条件，选择一个或一批最佳的节点，然后部署我们的Pod
* `Etcd`：键值数据库，报错一些集群的信息，一般生产环境中建议部署三个以上节点（奇数个）

##  Node : 工作节点

* `Kubelet`：负责监听节点上Pod的状态，同时负责上报节点和节点上面Pod的状态，负责与Master节点通信，并管理节点上面的Pod
* `Kube-proxy`：负责Pod之间的通信和负载均衡，将指定的流量分发到后端正确的机器上
* 查看`Kube-proxy`工作模式：`curl 127.0.0.1:10249/proxyMode`
  * `Ipvs`：监听Master节点增加和删除service以及endpoint的消息，调用`Netlink`接口创建相应的`IPVS`规则。通过`IPVS`规则，将流量转发至相应的Pod上
  * `Iptables`：监听Master节点增加和删除service以及endpoint的消息，对于每一个Service，他都会场景一个`iptables`规则，将service的`clusterIP`代理到后端对应的Pod
* 其他组件 
  * `Calico`：符合`CNI`标准的网络插件，给每个Pod生成一个唯一的`IP`地址，并且把每个节点当做一个路由器
  * `CoreDNS`：用于`Kubernetes`集群内部Service的解析，可以让Pod把Service名称解析成`IP`地址，然后通过Service的`IP`地址进行连接到对应的应用上
  * `Docker`：容器引擎，负责对容器的管理



## Pod

`Pod`是`Kubernetes`中最小的单元，它由一组、一个或多个容器组成，每个`Pod`还包含了一个`Pause`容器，Pause容器是Pod的父容器，主要负责僵尸进程的回收管理，通过`Pause`容器可以使同一个Pod里面的多个容器共享存储、网络、`PID`、`IPC`等

### 定义一个Pod

```yaml
apiVersion: v1 # 必选，API的版本号
kind: Pod       # 必选，类型Pod
metadata:       # 必选，元数据
  name: nginx   # 必选，符合RFC 1035规范的Pod名称
  namespace: default # 可选，Pod所在的命名空间，不指定默认为default，可以使用-n 指定namespace 
  labels:       # 可选，标签选择器，一般用于过滤和区分Pod
    app: nginx
    role: frontend # 可以写多个
  annotations:  # 可选，注释列表，可以写多个
    app: nginx
spec:   # 必选，用于定义容器的详细信息
  initContainers: # 初始化容器，在容器启动之前执行的一些初始化操作
  - command:
    - sh
    - -c
    - echo "I am InitContainer for init some configuration"
    image: busybox
    imagePullPolicy: IfNotPresent
    name: init-container
  containers:   # 必选，容器列表
  - name: nginx # 必选，符合RFC 1035规范的容器名称
    image: nginx:latest    # 必选，容器所用的镜像的地址
    imagePullPolicy: Always     # 可选，镜像拉取策略
    command: # 可选，容器启动执行的命令
    - nginx 
    - -g
    - "daemon off;"
    workingDir: /usr/share/nginx/html       # 可选，容器的工作目录
    volumeMounts:   # 可选，存储卷配置，可以配置多个
    - name: webroot # 存储卷名称
      mountPath: /usr/share/nginx/html # 挂载目录
      readOnly: true        # 只读
    ports:  # 可选，容器需要暴露的端口号列表
    - name: http    # 端口名称
      containerPort: 80     # 端口号
      protocol: TCP # 端口协议，默认TCP
    env:    # 可选，环境变量配置列表
    - name: TZ      # 变量名
      value: Asia/Shanghai # 变量的值
    - name: LANG
      value: en_US.utf8
    resources:      # 可选，资源限制和资源请求限制
      limits:       # 最大限制设置
        cpu: 1000m
        memory: 1024Mi
      requests:     # 启动所需的资源
        cpu: 100m
        memory: 512Mi
#    startupProbe: # 可选，检测容器内进程是否完成启动。注意三种检查方式同时只能使用一种。
#      httpGet:      # httpGet检测方式，生产环境建议使用httpGet实现接口级健康检查，健康检查由应用程序提供。
#            path: /api/successStart # 检查路径
#            port: 80
    readinessProbe: # 可选，健康检查。注意三种检查方式同时只能使用一种。
      httpGet:      # httpGet检测方式，生产环境建议使用httpGet实现接口级健康检查，健康检查由应用程序提供。
            path: / # 检查路径
            port: 80        # 监控端口
    livenessProbe:  # 可选，健康检查
      #exec:        # 执行容器命令检测方式
            #command: 
            #- cat
            #- /health
    #httpGet:       # httpGet检测方式
    #   path: /_health # 检查路径
    #   port: 8080
    #   httpHeaders: # 检查的请求头
    #   - name: end-user
    #     value: Jason 
      tcpSocket:    # 端口检测方式
            port: 80
      initialDelaySeconds: 60       # 初始化时间
      timeoutSeconds: 2     # 超时时间
      periodSeconds: 5      # 检测间隔
      successThreshold: 1 # 检查成功为2次表示就绪
      failureThreshold: 2 # 检测失败1次表示未就绪
    lifecycle:
      postStart: # 容器创建完成后执行的指令, 可以是exec httpGet TCPSocket
        exec:
          command:
          - sh
          - -c
          - 'mkdir /data/ '
      preStop:
        httpGet:      
              path: /
              port: 80
      #  exec:
      #    command:
      #    - sh
      #    - -c
      #    - sleep 9
  restartPolicy: Always   # 可选，默认为Always
  #nodeSelector: # 可选，指定Node节点
  #      region: subnet7
  imagePullSecrets:     # 可选，拉取镜像使用的secret，可以配置多个
  - name: default-dockercfg-86258
  hostNetwork: false    # 可选，是否为主机模式，如是，会占用主机端口
  volumes:      # 共享存储卷列表
  - name: webroot # 名称，与上述对应
    emptyDir: {}    # 挂载目录
        #hostPath:              # 挂载本机目录
        #  path: /etc/hosts
```

```yaml
apiVersion: v1 # 必选，API的版本号
kind: Pod       # 必选，类型Pod
metadata:       # 必选，元数据
  name: nginx   # 必选，符合RFC 1035规范的Pod名称
  # namespace: default # 可选，Pod所在的命名空间，不指定默认为default，可以使用-n 指定namespace 
  labels:       # 可选，标签选择器，一般用于过滤和区分Pod
    app: nginx
    role: frontend # 可以写多个
  annotations:  # 可选，注释列表，可以写多个
    app: nginx
spec:   # 必选，用于定义容器的详细信息
#  initContainers: # 初始化容器，在容器启动之前执行的一些初始化操作
#  - command:
#    - sh
#    - -c
#    - echo "I am InitContainer for init some configuration"
#    image: busybox
#    imagePullPolicy: IfNotPresent
#    name: init-container
  containers:   # 必选，容器列表
  - name: nginx # 必选，符合RFC 1035规范的容器名称
    image: nginx:1.15.2    # 必选，容器所用的镜像的地址
    imagePullPolicy: IfNotPresent     # 可选，镜像拉取策略, IfNotPresent: 如果宿主机有这个镜像，那就不需要拉取了. Always: 总是拉取, Never: 不管是否存储都不拉去
    command: # 可选，容器启动执行的命令 ENTRYPOINT, arg --> cmd
    - nginx 
    - -g
    - "daemon off;"
    workingDir: /usr/share/nginx/html       # 可选，容器的工作目录
#    volumeMounts:   # 可选，存储卷配置，可以配置多个
#    - name: webroot # 存储卷名称
#      mountPath: /usr/share/nginx/html # 挂载目录
#      readOnly: true        # 只读
    ports:  # 可选，容器需要暴露的端口号列表
    - name: http    # 端口名称
      containerPort: 80     # 端口号
      protocol: TCP # 端口协议，默认TCP
    env:    # 可选，环境变量配置列表
    - name: TZ      # 变量名
      value: Asia/Shanghai # 变量的值
    - name: LANG
      value: en_US.utf8
#    resources:      # 可选，资源限制和资源请求限制
#      limits:       # 最大限制设置
#        cpu: 1000m
#        memory: 1024Mi
#      requests:     # 启动所需的资源
#        cpu: 100m
#        memory: 512Mi
#    startupProbe: # 可选，检测容器内进程是否完成启动。注意三种检查方式同时只能使用一种。
#      httpGet:      # httpGet检测方式，生产环境建议使用httpGet实现接口级健康检查，健康检查由应用程序提供。
#            path: /api/successStart # 检查路径
#            port: 80
#    readinessProbe: # 可选，健康检查。注意三种检查方式同时只能使用一种。
#      httpGet:      # httpGet检测方式，生产环境建议使用httpGet实现接口级健康检查，健康检查由应用程序提供。
#            path: / # 检查路径
#            port: 80        # 监控端口
#    livenessProbe:  # 可选，健康检查
      #exec:        # 执行容器命令检测方式
            #command: 
            #- cat
            #- /health
    #httpGet:       # httpGet检测方式
    #   path: /_health # 检查路径
    #   port: 8080
    #   httpHeaders: # 检查的请求头
    #   - name: end-user
    #     value: Jason 
#      tcpSocket:    # 端口检测方式
#            port: 80
#      initialDelaySeconds: 60       # 初始化时间
#      timeoutSeconds: 2     # 超时时间
#      periodSeconds: 5      # 检测间隔
#      successThreshold: 1 # 检查成功为2次表示就绪
#      failureThreshold: 2 # 检测失败1次表示未就绪
#    lifecycle:
#      postStart: # 容器创建完成后执行的指令, 可以是exec httpGet TCPSocket
#        exec:
#          command:
#          - sh
#          - -c
#          - 'mkdir /data/ '
#      preStop:
#        httpGet:      
#              path: /
#              port: 80
      #  exec:
      #    command:
      #    - sh
      #    - -c
      #    - sleep 9
  restartPolicy: Always   # 可选，默认为Always，容器故障或者没有启动成功，那就自动该容器，Onfailure: 容器以不为0的状态终止，自动重启该容器, Never:无论何种状态，都不会重启
  #nodeSelector: # 可选，指定Node节点
  #      region: subnet7
#  imagePullSecrets:     # 可选，拉取镜像使用的secret，可以配置多个
#  - name: default-dockercfg-86258
#  hostNetwork: false    # 可选，是否为主机模式，如是，会占用主机端口
#  volumes:      # 共享存储卷列表
#  - name: webroot # 名称，与上述对应
#    emptyDir: {}    # 挂载目录
#        #hostPath:              # 挂载本机目录
#        #  path: /etc/hosts
#
```

```yaml
apiVersion: v1 
kind: Pod       
metadata:       
  name: mynginx  
spec:   
  containers:   
  - name: nginx 
    image: nginx
```

### Pod探针

* `StartupProbe`：`k8s1.16`版本后新加的探测方式，用于判断容器内应用程序是否已经启动。如果配置了`startupProbe`，就会先禁止其他的探测，直到它成功为止，成功后将不在进行探测
* `LivenessProbe`：用于探测容器是否运行，如果探测失败，`kubelet`会根据配置的重启策略进行相应的处理。若没有配置该探针，默认就是success
* `ReadinessProbe`：一般用于探测容器内的程序是否健康，它的返回值如果为success，那么久代表这个容器已经完成启动，并且程序已经是可以接受流量的状态

### 探针的检测方式

* `ExecAction`：在容器内执行一个命令，如果返回值为0，则认为容器健康
* `TCPSocketAction`：通过TCP连接检查容器内的端口是否是通的，如果是通的就认为容器健康
* `HTTPGetAction`：通过应用程序暴露的`API`地址来检查程序是否是正常的，如果状态码为200~400之间，则认为容器健康

### 探针检查参数配置

```sh
#      initialDelaySeconds: 60       # 初始化时间
#      timeoutSeconds: 2     # 超时时间
#      periodSeconds: 5      # 检测间隔
#      successThreshold: 1 # 检查成功为1次表示就绪
#      failureThreshold: 2 # 检测失败2次表示未就绪
```

## `ReplicationController`

Replication Controller（简称RC）可确保Pod副本数达到期望值，也就是RC定义的数量。换句话说，Replication Controller可确保一个Pod或一组同类Pod总是可用。

如果存在的Pod大于设定的值，则Replication Controller将终止额外的Pod。如果太小，Replication Controller将启动更多的Pod用于保证达到期望值。与手动创建Pod不同的是，用Replication Controller维护的Pod在失败、删除或终止时会自动替换。因此即使应用程序只需要一个Pod，也应该使用Replication Controller或其他方式管理。Replication Controller类似于进程管理程序，但是Replication Controller不是监视单个节点上的各个进程，而是监视多个节点上的多个Pod。

#### 定义一个`Replication Controller`

```yaml
apiVersion: v1
kind: ReplicationController
metadata:
  name: nginx
spec:
  replicas: 3
  selector:
    app: nginx
  template:
    metadata:
      name: nginx
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx
        ports:
        - containerPort: 80
```

## `ReplicaSet`

`ReplicaSet`是支持基于集合的标签选择器的下一代Replication Controller，它主要用作Deployment协调创建、删除和更新Pod，和Replication Controller唯一的区别是，`ReplicaSet`支持标签选择器。在实际应用中，虽然`ReplicaSet`可以单独使用，但是一般建议使用Deployment来自动管理`ReplicaSet`，除非自定义的Pod不需要更新或有其他编排等

#### 定义一个`ReplicaSet`

```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: frontend
  labels:
    app: guestbook
    tier: frontend
spec:
  # modify replicas according to your case
  replicas: 3
  selector:
    matchLabels:
      tier: frontend
    matchExpressions:
      - {key: tier, operator: In, values: [frontend]}
  template:
    metadata:
      labels:
        app: guestbook
        tier: frontend
    spec:
      containers:
      - name: php-redis
        image: gcr.io/google_samples/gb-frontend:v3
        resources:
          requests:
            cpu: 100m
            memory: 100Mi
        env:
        - name: GET_HOSTS_FROM
          value: dns
          # If your cluster config does not include a dns service, then to
          # instead access environment variables to find service host
          # info, comment out the 'value: dns' line above, and uncomment the
          # line below.
          # value: env
        ports:
        - containerPort: 80
```

`Replication Controller`和`ReplicaSet`的创建删除和Pod并无太大区别，`Replication Controller`目前几乎已经不在生产环境中使用，`ReplicaSet`也很少单独被使用，都是使用更高级的资源`Deployment`、`DaemonSet`、`StatefulSet`进行管理Pod

## Deployment

用于部署无状态的服务，这个最常用的控制器。一般用于管理维护企业内部无状态的微服务，比如configserver、zuul、springboot。他可以管理多个副本的Pod实现无缝迁移、自动扩容缩容、自动灾难恢复、一键回滚等功能。

#### 创建一个Deployment

**手动创建：**

```sh
kubectl create deployment nginx --image=nginx:1.15.2
```

**从文件创建：**

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "1"
  creationTimestamp: "2020-09-19T02:41:11Z"
  generation: 1
  labels:
    app: nginx
  name: nginx
  namespace: default
spec:
  progressDeadlineSeconds: 600
  replicas: 2 #副本数
  revisionHistoryLimit: 10 # 历史记录保留的个数
  selector:
    matchLabels:
      app: nginx
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: nginx
    spec:
      containers:
      - image: nginx:1.15.2
        imagePullPolicy: IfNotPresent
        name: nginx
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
```

#### 状态解析

```sh
[root@k8s-master01 ~]# kubectl get deploy -owide
NAME               READY   UP-TO-DATE   AVAILABLE   AGE   CONTAINERS   IMAGES        SELECTOR
nginx-deployment   3/3     3            3           97m   nginx        nginx:1.7.9   app=nginx
```

* `NAME`： Deployment名称

* `READY`：Pod的状态，已经Ready的个数

* `UP-TO-DATE`：已经达到期望状态的被更新的副本数

* `AVAILABLE`：已经可以用的副本数

* `AGE`：显示应用程序运行的时间

* `CONTAINERS`：容器名称

* `IMAGES`：容器的镜像

* `SELECTOR`：管理的Pod的标签

### Deployment的更新

```sh
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "1"
  generation: 1
  labels:
    app: nginx
  name: nginx
  namespace: default
spec:
  progressDeadlineSeconds: 600
  replicas: 2 #副本数
  revisionHistoryLimit: 10 # 历史记录保留的个数
  selector:
    matchLabels:
      app: nginx
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: nginx
    spec:
      containers:
      - image: nginx:1.15.2
        imagePullPolicy: IfNotPresent
        name: nginx
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
```

```sh
kubectl create -f nginx-deploy.yaml
```

```sh
更改deployment的镜像并记录 :
[root@k8s-master01 yaml]# kubectl set image deploy nginx nginx=nginx:1.15.7 --record
Flag --record has been deprecated, --record will be removed in the future
deployment.apps/nginx image updated
```

```sh
查看更新过程 :
[root@k8s-master01 yaml]# kubectl rollout status deploy nginx
Waiting for deployment "nginx" rollout to finish: 1 out of 2 new replicas have been updated...
Waiting for deployment "nginx" rollout to finish: 1 out of 2 new replicas have been updated...
Waiting for deployment "nginx" rollout to finish: 1 out of 2 new replicas have been updated...
Waiting for deployment "nginx" rollout to finish: 1 old replicas are pending termination...
Waiting for deployment "nginx" rollout to finish: 1 old replicas are pending termination...
```

```sh
查看历史版本 : 
[root@k8s-master01 yaml]# kubectl rollout history deploy nginx
deployment.apps/nginx
REVISION  CHANGE-CAUSE
1         <none>
2         <none>
3         kubectl set image deploy nginx nginx=nginx:1.15.7 --record=true
```

```sh
回滚到上一个版本 :
kubectl rollout undo deploy nginx 
kubectl get po
kubectl get deploy nginx -oyaml | grep nginx
```

### Deployment的暂停和恢复

```sh
[root@k8s-master01 yaml]# kubectl rollout pause deployment nginx
deployment.apps/nginx paused

[root@k8s-master01 yaml]# kubectl get deploy nginx -oyaml
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "5"
    kubernetes.io/change-cause: kubectl set image deploy nginx nginx=nginx:1.15.7
      --record=true
  creationTimestamp: "2023-03-14T05:45:35Z"
  generation: 6
  labels:
    app: nginx
  name: nginx
  namespace: default
  resourceVersion: "835766"
  uid: 32881877-e181-4b59-892a-3bd134bbd2c9
spec:
  paused: true
  progressDeadlineSeconds: 600
  replicas: 2
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: nginx
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: nginx
    spec:
      containers:
      - image: nginx:1.15.7
        imagePullPolicy: IfNotPresent
        name: nginx
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
status:
  availableReplicas: 2
  conditions:
  - lastTransitionTime: "2023-03-14T05:48:17Z"
    lastUpdateTime: "2023-03-14T05:48:17Z"
    message: Deployment has minimum availability.
    reason: MinimumReplicasAvailable
    status: "True"
    type: Available
  - lastTransitionTime: "2023-03-14T06:43:39Z"
    lastUpdateTime: "2023-03-14T06:43:39Z"
    message: Deployment is paused
    reason: DeploymentPaused
    status: Unknown
    type: Progressing
  observedGeneration: 6
  readyReplicas: 2
  replicas: 2
 * spec.revisionHistoryLimit：设置保留RS旧的revision的个数，设置为0的话，不保留历史数据
 * spec.minReadySeconds：可选参数，指定新创建的Pod在没有任何容器崩溃的情况下视为Ready最小的秒数，默认为0，即一旦被创建就视为可用
 滚动更新的策略:
       spec.strategy.type：更新deployment的方式，默认是RollingUpdate
          RollingUpdate：滚动更新，可以指定maxSurge和maxUnavailable
             maxUnavailable：指定在回滚或更新时最大不可用的Pod的数量，可选字段，默认25%，可以设置成数字或百分比，如果该值为0，那么              maxSurge就不能0
             -------------------
             maxSurge：可以超过期望值的最大Pod数，可选字段，默认为25%，可以设置成数字或百分比，如果该值为0，那么maxUnavailable不能			   为0
        
           Recreate：重建，先删除旧的Pod，在创建新的Pod
```

## StatefulSet

`StatefulSet`（有状态集，缩写为`sts`）常用于部署有状态的且需要有序启动的应用程序，比如在进行`SpringCloud`项目容器化时，`Eureka`的部署是比较适合用`StatefulSet`部署方式的，可以给每个`Eureka`实例创建一个唯一且固定的标识符，并且每个`Eureka`实例无需配置多余的`Service`，其余`Spring Boo`t应用可以直接通过`Eureka`的`Headless Service`即可进行注册。

`Eureka`的`statefulset`的资源名称是`eureka，eureka-0 eureka-1 eureka-2`

`Service：headless service`，没有`ClusterIP	eureka-svc Eureka-0.eureka-svc.NAMESPACE_NAME  eureka-1.eureka-svc …`

###  `StatefulSet`的基本概念

`StatefulSet`主要用于管理有状态应用程序的工作负载`API`对象。比如在生产环境中，可以部署`ElasticSearch`集群、`MongoDB`集群或者需要持久化的`RabbitMQ`集群、`Redis`集群、`Kafka`集群和`ZooKeeper`集群等。

和`Deployment`类似，一个`StatefulSet`也同样管理着基于相同容器规范的Pod。不同的是，`StatefulSet`为每个Pod维护了一个粘性标识。这些Pod是根据相同的规范创建的，但是不可互换，每个Pod都有一个持久的标识符，在重新调度时也会保留，一般格式为`StatefulSetName-Number`。比如定义一个名字是`Redis-Sentinel`的`StatefulSet`，指定创建三个Pod，那么创建出来的Pod名字就为`Redis-Sentinel-0`、`Redis-Sentinel-1`、`Redis-Sentinel-2`。而`StatefulSet`创建的Pod一般使用Headless Service（无头服务）进行通信，和普通的Service的区别在于Headless Service没有`ClusterIP`，它使用的是Endpoint进行互相通信，Headless一般的格式为

`statefulSetName-{0..N-1}.serviceName.namespace.svc.cluster.local`

* `serviceName`为Headless Service的名字，创建`StatefulSet`时，必须指定Headless Service名称；
*  0..N-1为Pod所在的序号，从0开始到N-1；
*  `statefulSetName`为`StatefulSet`的名字；
*  `namespace`为服务所在的命名空间；
* `.cluster.local`为Cluster Domain（集群域）；

假如公司某个项目需要在`Kubernetes`中部署一个主从模式的`Redis`，此时使用`StatefulSet`部署就极为合适，因为`StatefulSet`启动时，只有当前一个容器完全启动时，后一个容器才会被调度，并且每个容器的标识符是固定的，那么就可以通过标识符来断定当前Pod的角色。

比如用一个名为`redis-ms`的`StatefulSet`部署主从架构的`Redis`，第一个容器启动时，它的标识符为`redis-ms-0`，并且Pod内主机名也为`redis-ms-0`，此时就可以根据主机名来判断，当主机名为`redis-ms-0`的容器作为`Redis`的主节点，其余从节点，那么Slave连接Master主机配置就可以使用不会更改的Master的Headless Service，此时`Redis`从节点（Slave）配置文件如下：

```sh
port 6379
slaveof redis-ms-0.redis-ms.public-service.svc.cluster.local 6379
tcp-backlog 511
timeout 0
tcp-keepalive 0
……
```

其中`redis-ms-0.redis-ms.public-service.svc.cluster.local`是`Redis Master`的Headless Service，在同一命名空间下只需要写`redis-ms-0.redis-ms`即可，后面的`public-service.svc.cluster.local`可以省略。

### 定义一个`StatefulSet`资源文件

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx
  labels:
    app: nginx
spec:
  ports:
  - port: 80
    name: web
  clusterIP: None
  selector:
    app: nginx
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: web
spec:
  serviceName: "nginx"
  replicas: 2
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx
        ports:
        - containerPort: 80
          name: web
# 此示例没有添加存储配置，后面的章节会单独讲解存储相关的知识点
```

* kind: Service定义了一个名字为`Nginx`的Headless Service，创建的Service格式为`nginx-0.nginx.default.svc.cluster.local`，其他的类似，因为没有指定`Namespace`（命名空间），所以默认部署在default。
* kind: `StatefulSe`t定义了一个名字为web的`StatefulSet`，replicas表示部署Pod的副本数，本实例为2。

在`StatefulSet`中必须设置Pod选择器`（.spec.selector）`用来匹配其标签`（.spec.template.metadata.labels）`。在1.8版本之前，如果未配置该字段`（.spec.selector）`，将被设置为默认值，在1.8版本之后，如果未指定匹配Pod Selector，则会导致`StatefulSet`创建错误。

当`StatefulSet`控制器创建Pod时，它会添加一个标签`statefulset.kubernetes.io/pod-name`，该标签的值为Pod的名称，用于匹配Service。

### 创建一个`StatefulSet`

```sh
[root@k8s-master01 yaml]# kubectl create -f nginx-sts.yaml
service/nginx created
statefulset.apps/web created
[root@k8s-master01 yaml]# kubectl get svc
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   7d5h
nginx        ClusterIP   None         <none>        80/TCP    16s
[root@k8s-master01 yaml]# kubectl get po
NAME                        READY   STATUS    RESTARTS   AGE
nginx-aa-79674cd84f-s4npw   1/1     Running   0          7m3s
web-0                       1/1     Running   0          28s
web-1                       1/1     Running   0          24s
[root@k8s-master01 yaml]# kubectl scale --replicas=3 sts web
statefulset.apps/web scaled
[root@k8s-master01 yaml]# kubectl get po
NAME                        READY   STATUS              RESTARTS   AGE
nginx-aa-79674cd84f-s4npw   1/1     Running             0          7m21s
web-0                       1/1     Running             0          46s
web-1                       1/1     Running             0          42s
web-2                       0/1     ContainerCreating   0          3s
```

### `StatefulSet`更新策略

```yaml
[root@k8s-master01 yaml]# kubectl get sts web -o yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  creationTimestamp: "2023-03-14T08:04:56Z"
  generation: 2
  name: web
  namespace: default
  resourceVersion: "842718"
  uid: 979cd4ef-f999-492f-84ac-fe55646a7137
spec:
  podManagementPolicy: OrderedReady
  replicas: 3
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: nginx
  serviceName: nginx
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: nginx
    spec:
      containers:
      - image: nginx
        imagePullPolicy: Always
        name: nginx
        ports:
        - containerPort: 80
          name: web
          protocol: TCP
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
  updateStrategy:
    rollingUpdate:
      partition: 0
    type: RollingUpdate
status:
  availableReplicas: 3
  collisionCount: 0
  currentReplicas: 3
  currentRevision: web-b486b4959
  observedGeneration: 2
  readyReplicas: 3
  replicas: 3
  updateRevision: web-b486b4959
  updatedReplicas: 3
```

## `DaemonSet`

`DaemonSet`：守护进程集，缩写为`ds`，在所有节点或者是匹配的节点上都部署一个Pod。

使用`DaemonSet`的场景 : 

*  运行集群存储的`daemon`，比如`ceph`或者`glusterd`
* 节点的`CNI`网络插件，`calico`
* 节点日志的收集：fluentd或者是filebeat
* 节点的监控：node exporter
*  服务暴露：部署一个`ingress nginx`

### 创建一个`DaemonSet`

```yaml
[root@k8s-master01 yaml]# cat nginx-ds.yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  labels:
    app: nginx
  name: nginx
spec:
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: nginx
    spec:
      containers:
      - image: nginx:1.15.2
        imagePullPolicy: IfNotPresent
        name: nginx
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
[root@k8s-master01 yaml]# kubectl create -f nginx-ds.yaml

[root@k8s-master01 yaml]# kubectl get po -A
NAMESPACE              NAME                                        READY   STATUS    RESTARTS        AGE
default                nginx-aa-79674cd84f-s4npw                   1/1     Running   0               17m
default                nginx-nl2ck                                 1/1     Running   0               117s
default                web-0                                       1/1     Running   0               11m
default                web-1                                       1/1     Running   0               10m
default                web-2                                       1/1     Running   0               10m
kube-flannel           kube-flannel-ds-2z267                       1/1     Running   0               3d1h
kube-flannel           kube-flannel-ds-mpbsq                       1/1     Running   23 (7d1h ago)   7d3h
kube-system            coredns-5bbd96d687-dd5t8                    1/1     Running   0               7d5h
kube-system            coredns-5bbd96d687-hx99g                    1/1     Running   0               7d5h
kube-system            etcd-k8s-master01                           1/1     Running   0               7d5h
kube-system            kube-apiserver-k8s-master01                 1/1     Running   0               7d5h
kube-system            kube-controller-manager-k8s-master01        1/1     Running   0               7d5h
kube-system            kube-proxy-7mwdx                            1/1     Running   0               3d1h
kube-system            kube-proxy-d48kv                            1/1     Running   0               7d5h
kube-system            kube-scheduler-k8s-master01                 1/1     Running   0               7d5h
kubernetes-dashboard   dashboard-metrics-scraper-7bc864c59-wfpjt   1/1     Running   0               28h
kubernetes-dashboard   kubernetes-dashboard-6c7ccbcf87-fdd2r       1/1     Running   0               28h
```

## `Label`和`Selector`

Label：对k8s中各种资源进行分类、分组，添加一个具有特别属性的一个标签

Selector：通过一个过滤的语法进行查找到对应标签的资源

当Kubernetes对系统的任何API对象如Pod和节点进行“分组”时，会对其添加Label（key=value形式的“键-值对”）用以精准地选择对应的API对象。而Selector（标签选择器）则是针对匹配对象的查询方法。注：键-值对就是key-value pair。

例如，常用的标签tier可用于区分容器的属性，如frontend、backend；或者一个release_track用于区分容器的环境，如canary、production等

### 定义Label

应用案例：

公司与xx银行有一条专属的高速光纤通道，此通道只能与192.168.7.0网段进行通信，因此只能将与xx银行通信的应用部署到192.168.7.0网段所在的节点上，此时可以对节点进行Label（即加标签）：

```sh
[root@k8s-master01 ~]# kubectl label node k8s-node01 region=subnet7
node/k8s-node01 labeled
然后，可以通过Selector对其筛选：
[root@k8s-master01 ~]# kubectl get no -l region=subnet7
NAME         STATUS   ROLES    AGE    VERSION
k8s-node01   Ready    <none>   3d2h   v1.26.2
```

**最后，在Deployment或其他控制器中指定将Pod部署到该节点**

```yaml
containers:
  ......
dnsPolicy: ClusterFirst
nodeSelector:
  region: subnet7
restartPolicy: Always
......
```

**也可以用同样的方式对Service进行Label：**

```sh
[root@k8s-master01 ~]# kubectl get svc
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   7d6h
nginx        ClusterIP   None         <none>        80/TCP    30m
[root@k8s-master01 ~]# kubectl label svc nginx -n default env=canary version=v1
service/nginx labeled
```

**查看Labels：**

```sh
[root@k8s-master01 ~]# kubectl get svc -n default --show-labels
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE    LABELS
kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   7d6h   component=apiserver,provider=kubernetes
nginx        ClusterIP   None         <none>        80/TCP    31m    app=nginx,env=canary,version=v1
```

**还可以查看所有Version为v1的svc：**

```sh
[root@k8s-master01 ~]# kubectl get svc --all-namespaces -l version=v1
NAMESPACE   NAME    TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
default     nginx   ClusterIP   None         <none>        80/TCP    32m
```

### Selector条件匹配

Selector主要用于资源的匹配，只有符合条件的资源才会被调用或使用，可以使用该方式对集群中的各类资源进行分配。

假如对Selector进行条件匹配，目前已有的Label如下:

```sh
[root@k8s-master01 ~]# kubectl get svc --show-labels
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE    LABELS
kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   7d6h   component=apiserver,provider=kubernetes
nginx        ClusterIP   None         <none>        80/TCP    36m    app=nginx,env=canary,version=v1
```

```sh
[root@k8s-master01 ~]# kubectl get svc -l 'app=nginx,env=canary,version=v1'
NAME    TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
nginx   ClusterIP   None         <none>        80/TCP    38m
```

### 修改标签（Label）

在实际使用中，Label的更改是经常发生的事情，可以使用overwrite参数修改标签。

修改标签，比如将version=v1改为version=v2：

```sh
[root@k8s-master01 ~]# kubectl label svc nginx -n default version=v2 --overwrite
service/nginx labeled
[root@k8s-master01 ~]# kubectl get svc -n default --show-labels
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE    LABELS
kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   7d6h   component=apiserver,provider=kubernetes
nginx        ClusterIP   None         <none>        80/TCP    43m    app=nginx,env=canary,version=v2
```

### 删除标签（Label）

删除标签，比如删除version：

```sh
[root@k8s-master01 ~]# kubectl label svc nginx -n default version-
service/nginx unlabeled
[root@k8s-master01 ~]# kubectl get svc -n default --show-labels
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE    LABELS
kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   7d6h   component=apiserver,provider=kubernetes
nginx        ClusterIP   None         <none>        80/TCP    48m    app=nginx,env=canary
[root@k8s-master01 ~]# kubectl label svc nginx -n default  env-
service/nginx unlabeled
[root@k8s-master01 ~]# kubectl get svc -n default --show-labels
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE    LABELS
kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   7d6h   component=apiserver,provider=kubernetes
nginx        ClusterIP   None         <none>        80/TCP    49m    app=nginx
```

## Service

Service可以简单的理解为逻辑上的一组Pod。一种可以访问Pod的策略，而且其他Pod可以通过这个Service访问到这个Service代理的Pod。相对于Pod而言，它会有一个固定的名称，一旦创建就固定不变。

### 创建一个Service

```yaml
cat nginx-deploy.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: nginx
  name: nginx
  namespace: default
spec:
  progressDeadlineSeconds: 600
  replicas: 2
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: nginx
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: nginx
    spec:
      containers:
      - image: nginx:1.15.2
        imagePullPolicy: IfNotPresent
        name: nginx
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
# cat nginx-svc.yaml
apiVersion: v1
kind: Service
metadata:
  labels:
    app: nginx-svc
  name: nginx-svc
spec:
  ports:
  - name: http # Service端口的名称
    port: 80 # Service自己的端口, servicea --> serviceb http://serviceb,  http://serviceb:8080 
    protocol: TCP # UDP TCP SCTP default: TCP
    targetPort: 80 # 后端应用的端口
  - name: https
    port: 443
    protocol: TCP
    targetPort: 443
  selector:
    app: nginx
  sessionAffinity: None
  type: ClusterIP
```

### 使用Service代理`k8s`外部应用

使用场景：

* 希望在生产环境中使用某个固定的名称而非IP地址进行访问外部的中间件服务
* 希望Service指向另一个Namespace中或其他集群中的服务
* 某个项目正在迁移至k8s集群，但是一部分服务仍然在集群外部，此时可以使用service代理至k8s集群外部的服务

```yaml
# cat nginx-svc-external.yaml 
apiVersion: v1
kind: Service
metadata:
  labels:
    app: nginx-svc-external
  name: nginx-svc-external
spec:
  ports:
  - name: http # Service端口的名称
    port: 80 # Service自己的端口, servicea --> serviceb http://serviceb,  http://serviceb:8080 
    protocol: TCP # UDP TCP SCTP default: TCP
    targetPort: 80 # 后端应用的端口
  sessionAffinity: None
  type: ClusterIP


# cat nginx-ep-external.yaml 
apiVersion: v1
kind: Endpoints
metadata:
  labels:
    app: nginx-svc-external
  name: nginx-svc-external
  namespace: default
subsets:
- addresses:
  - ip: 140.205.94.189 
  ports:
  - name: http
    port: 80
    protocol: TCP
```

### 使用Service反代域名

```yaml
# cat nginx-externalName.yaml 
apiVersion: v1
kind: Service
metadata:
  labels:
    app: nginx-externalname
  name: nginx-externalname
spec:
  type: ExternalName
  externalName: www.baidu.com
```

### Service类型

* ClusterIP：在集群内部使用，也是默认值。
* ClusterIP：在集群内部使用，也是默认值。
* NodePort：在所有安装了kube-proxy的节点上打开一个端口，此端口可以代理至后端Pod，然后集群外部可以使用节点的IP地址和NodePort的端口号访问到集群Pod的服务。NodePort端口范围默认是30000-32767。
* LoadBalancer：使用云提供商的负载均衡器公开服务。



