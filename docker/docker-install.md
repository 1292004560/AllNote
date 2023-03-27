## 在almalinux 安装docker

```sh
dnf clean all
dnf update -y
dnf groupinstall "Development Tools" -y

# Docker CE 存储库添加到您的 AlmaLinux 系统：
dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
# 使用以下命令安装最新版本的 Docker CE:
dnf install docker-ce --nobest -y
# 启动 Docker 服务并通过运行以下命令使其在启动时自动启动：
systemctl enable --now docker
systemctl start docker
systemctl status docker


vim /etc/docker/daemon.json
{
"registry-mirrors": [
"https://docker.mirrors.ustc.edu.cn",
"https://hub-mirror.c.163.com",
"https://reg-mirror.qiniu.com",
"https://registry.docker-cn.com"
],
"exec-opts": ["native.cgroupdriver=systemd"]
}
systemctl daemon-reload && systemctl enable --now docker
```



```sh
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-aarch64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=http://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg http://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF
#清除缓存
yum clean all

#把服务器的包信息下载到本地电脑缓存起来，makecache建立一个缓存
yum makecache

#列出kubectl可用的版本
yum list kubectl --showduplicates | sort -r


cat <<EOF >  /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
vm.swappiness=0
EOF

#让上述配置命令生效
sysctl --system

#或者这样去设置
echo "1" >/proc/sys/net/bridge/bridge-nf-call-iptables
echo "1" >/proc/sys/net/bridge/bridge-nf-call-ip6tables

#保证输出的都是1
cat /proc/sys/net/bridge/bridge-nf-call-ip6tables
cat /proc/sys/net/bridge/bridge-nf-call-iptables
```

## 安装 kubelet kubeadm kubectl 

```sh
#安装最新版本,也可安装指定版本
yum install -y kubelet kubeadm kubectl

#安装指定版本的kubelet,kubeadm,kubectl
yum install -y kubelet-1.19.3-0 kubeadm-1.19.3-0 kubectl-1.19.3-0

#查看kubelet版本
kubelet --version
#版本如下:
Kubernetes v1.19.3

#查看kubeadm版本
kubeadm version
```

## 启动kubelet并设置开机启动服务

```sh
#重新加载配置文件
systemctl daemon-reload

#启动kubelet
systemctl start kubelet

#查看kubelet启动状态
systemctl status kubelet
#没启动成功,报错先不管,后面的kubeadm init会拉起

#设置开机自启动
systemctl enable kubelet

#查看kubelet开机启动状态 enabled:开启, disabled:关闭
systemctl is-enabled kubelet

#查看日志
journalctl -xefu kubelet
```

```sh
[Unit]
Description=CRI Interface for Docker Application Container Engine
Documentation=https://docs.mirantis.com
After=network-online.target firewalld.service docker.service
Wants=network-online.target
Requires=cri-docker.socket

[Service]
Type=notify
ExecStart=/usr/bin/cri-dockerd --network-plugin=cni --pod-infra-container-image=registry.aliyuncs.com/google_containers/pause:3.7
ExecReload=/bin/kill -s HUP $MAINPID
TimeoutSec=0
RestartSec=2
Restart=always

StartLimitBurst=3

StartLimitInterval=60s

LimitNOFILE=infinity
LimitNPROC=infinity
LimitCORE=infinity

TasksMax=infinity
Delegate=yes
KillMode=process

[Install]
WantedBy=multi-user.target
```

```sh
[Unit]
Description=CRI Docker Socket for the API
PartOf=cri-docker.service

[Socket]
ListenStream=%t/cri-dockerd.sock
SocketMode=0660
SocketUser=root
SocketGroup=docker

[Install]
WantedBy=sockets.target
```

```sh
scp /usr/lib/systemd/system/cri-docker.socket /usr/lib/systemd/system/cri-docker.service k8s-node2:/usr/lib/systemd/system/

```

