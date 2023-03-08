## 安装前一些配置

### 修改各虚拟机的主机名

```sh
#各个机器设置自己的域名
hostnamectl set-hostname k8s-master01
hostnamectl set-hostname k8s-master02
hostnamectl set-hostname k8s-master03
hostnamectl set-hostname k8s-node01
hostnamectl set-hostname k8s-node02
```

### 修改ip和uuid

```sh
vim /etc/sysconfig/network-scripts/ifcfg-ens160
```

### 关闭selinux

```sh
setenforce 0
sed -i 's/^SELINUX=enforcing$/SELINUX=disabled/' /etc/selinux/config
```

### 关闭swap

```sh
swapoff -a  
sed -ri 's/.*swap.*/#&/' /etc/fstab
```

### 添加yum源

```sh
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=http://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=0
repo_gpgcheck=0
gpgkey=http://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg
   http://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
exclude=kubelet kubeadm kubectl
EOF
```

### 修改每个主机hosts文件

```sh
vim /etc/hosts
192.168.108.50 k8s-master01
192.168.108.51 k8s-master02
192.168.108.52 k8s-node01

设置成功之后
ping k8s-node01
```

### 关闭防火墙

```sh
systemctl disable --now firewalld
systemctl disable --now dnsmasq
#systemctl disable --now NetworkManager  #CentOS8无需关闭
```

### 各节点时间设置同步

```sh
yum install -y ntpdate
rpm -ivh http://mirrors.wlnmp.com/centos/wlnmp-release-centos.noarch.rpm
yum install wntp -y
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
echo 'Asia/Shanghai' >/etc/timezone

# 加入 crontab
crontab -e   # */5 * * * * /usr/sbin/ntpdate time2.aliyun.com
# 加入开机自启动
vim /etc/rc.local
ntpdate time2.aliyun.com
```

### 所有节点配置limit

```sh
ulimit -SHn 65535

vim /etc/security/limits.conf
# 末尾添加如下内容
* soft nofile 655360
* hard nofile 131072
* soft nproc 655350
* hard nproc 655350
* soft memlock unlimited
* hard memlock unlimited
```

### 配置免密登录

Master01节点免密钥登录其他节点，安装过程中生成配置文件和证书均在Master01上操作，集群管理也在Master01上操作，阿里云或者AWS上需要单独一台kubectl服务器。

密钥配置如下 :

```sh
ssh-keygen -t rsa
for i in k8s-master01 k8s-master02  k8s-node01;do ssh-copy-id -i .ssh/id_rsa.pub $i;done
```

### 安装git 

```sh
yum install -y git
git clone https://github.com/dotbalo/k8s-ha-install.git
```

### 更新软件源

###### centos7

```sh
curl -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-7.repo
 

yum-config-manager --add-repo https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF


sed -i -e '/mirrors.cloud.aliyuncs.com/d' -e '/mirrors.aliyuncs.com/d' /etc/yum.repos.d/CentOS-Base.repo
```

###### centos8

```sh
curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-8.repo
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF

sed -i -e '/mirrors.cloud.aliyuncs.com/d' -e '/mirrors.aliyuncs.com/d' /etc/yum.repos.d/CentOS-Base.repo
```

### 所有节点升级系统并重启

```sh
yum install wget jq psmisc vim net-tools telnet yum-utils device-mapper-persistent-data lvm2 -y
yum update -y --exclude=kernel* && reboot #CentOS7需要升级，8不需要
```

### 内核配置

###### centos 7

```sh
# CentOS7 需要升级内核至4.18+

# 使用如下方式安装最新版内核
rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm

# 查看最新版内核yum --disablerepo="*" --enablerepo="elrepo-kernel" list available
# 安装最新版：
yum --enablerepo=elrepo-kernel install kernel-ml kernel-ml-devel -y
# 安装完成后reboot
# 更改内核顺序：
grub2-set-default  0 && grub2-mkconfig -o /etc/grub2.cfg && grubby --args="user_namespace.enable=1" --update-kernel="$(grubby --default-kernel)" && reboot



1、查看当前内核
uname -r   
2、显示已经安装的内核
rpm -qa | grep kernel 
3、grub2存在的内核
grep menuentry /boot/grub2/grub.cfg
4、配置默认内核
grub2-set-default "CentOS Linux (4.20.8-1.el7.elrepo.x86_64) 7 (Core)"   
5、配置默认内核
grub2-editenv list  
6、reboot
```

###### centos 8

```sh
# 可以采用dnf升级，也可使用上述同样步骤升级（使用上述步骤注意elrepo-release-8.1版本）
rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
dnf install https://www.elrepo.org/elrepo-release-8.1-1.el8.elrepo.noarch.rpm
dnf --disablerepo=\* --enablerepo=elrepo -y install kernel-ml kernel-ml-devel
grubby --default-kernel && reboot
```

### 所有节点安装ipvsadm

```sh
yum install ipvsadm ipset sysstat conntrack libseccomp -y
```

所有节点配置ipvs模块，在内核4.19+版本`nf_conntrack_ipv4`已经改为`nf_conntrack`，本例安装的内核为4.18，使用nf_conntrack_ipv4即可：

```sh
modprobe -- ip_vs
modprobe -- ip_vs_rr
modprobe -- ip_vs_wrr
modprobe -- ip_vs_sh
modprobe -- nf_conntrack_ipv4 或 modprobe -- nf_conntrack


cat > /etc/modules-load.d/ipvs.conf <<EOF
#!/bin/bash
modprobe -- ip_vs
modprobe -- ip_vs_rr
modprobe -- ip_vs_wrr
modprobe -- ip_vs_sh
modprobe -- nf_conntrack
EOF

cat > /etc/modules-load.d/ipvs.conf <<EOF
#!/bin/bash
ip_vs
ip_vs_rr
ip_vs_wrr
ip_vs_sh
nf_conntrack
ip_tables
ip_set
xt_set
ipt_set
ipt_rpfilter
ipt_REJECT
ipip
EOF

然后执行systemctl enable --now systemd-modules-load.service即可
```

检查是否加载：

```sh
[root@k8s-master01 ~]# lsmod | grep -e ip_vs -e nf_conntrack_ipv4
nf_conntrack_ipv4      16384  23 
nf_defrag_ipv4         16384  1 nf_conntrack_ipv4
nf_conntrack          135168  10 xt_conntrack,nf_conntrack_ipv6,nf_conntrack_ipv4,nf_nat,nf_nat_ipv6,ipt_MASQUERADE,nf_nat_ipv4,xt_nat,nf_conntrack_netlink,ip_vs
```

### 配置k8s需要的内核参数

开启一些k8s集群中必须的内核参数，所有节点配置k8s内核：

```sh
cat <<EOF > /etc/sysctl.d/k8s.conf
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-iptables = 1
net.bridge.bridge-nf-call-ip6tables = 1
fs.may_detach_mounts = 1
vm.overcommit_memory=1
vm.panic_on_oom=0
fs.inotify.max_user_watches=89100
fs.file-max=52706963
fs.nr_open=52706963
net.netfilter.nf_conntrack_max=2310720

net.ipv4.tcp_keepalive_time = 600
net.ipv4.tcp_keepalive_probes = 3
net.ipv4.tcp_keepalive_intvl =15
net.ipv4.tcp_max_tw_buckets = 36000
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_max_orphans = 327680
net.ipv4.tcp_orphan_retries = 3
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_max_syn_backlog = 16384
net.ipv4.ip_conntrack_max = 65536
net.ipv4.tcp_max_syn_backlog = 16384
net.ipv4.tcp_timestamps = 0
net.core.somaxconn = 16384
EOF
```

```sh
# 然后执行
sysctl --system
```



所有节点配置完内核后，重启服务器，保证重启后内核依旧加载

```sh
reboot
lsmod | grep --color=auto -e ip_vs -e nf_conntrack
```

## 基本组件安装

### 安装docker

```sh
主要安装的是集群中用到的各种组件，比如Docker-ce、Kubernetes各组件等。

查看可用docker-ce版本：
yum list docker-ce.x86_64 --showduplicates | sort -r
wget https://download.docker.com/linux/centos/7/x86_64/edge/Packages/containerd.io-1.2.13-3.2.el7.x86_64.rpm 
yum install containerd.io-1.2.13-3.2.el7.x86_64.rpm -y

安装指定版本的Docker：
yum -y install docker-ce-17.09.1.ce-1.el7.centos
安装最新版本的Docker
yum install docker-ce -y
```

**注意 : **

```sh
由于新版kubelet建议使用systemd，所以可以把docker的CgroupDriver改成systemd
cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"]
}
EOF
所有节点设置开机自启动Docker：
systemctl daemon-reload && systemctl enable --now docker
```

### 安装k8s组件

```sh
yum list kubeadm.x86_64 --showduplicates | sort -r

所有节点安装最新版本kubeadm：
yum install kubeadm -y
所有节点安装指定版本k8s组件：
yum install -y kubeadm-1.12.3-0.x86_64 kubectl-1.12.3-0.x86_64 kubelet-1.12.3-0.x86_64
```

#### 报错

![](./images/1.png)

#### 解决报错

```sh
 yum -y install kubernetes-cni = 0.6.0
```

### 配置仓库

```sh
# 默认配置的pause镜像使用gcr.io仓库，国内可能无法访问，所以这里配置Kubelet使用阿里云的pause镜像：
DOCKER_CGROUPS=$(docker info | grep 'Cgroup' | cut -d' ' -f3)
cat >/etc/sysconfig/kubelet<<EOF
KUBELET_EXTRA_ARGS="--cgroup-driver=systemd --pod-infra-container-image=registry.cn-hangzhou.aliyuncs.com/google_containers/pause-amd64:3.1"
EOF
```

### 设置Kubelet开机自启动

```sh
systemctl daemon-reload
systemctl enable --now kubelet
```

## 高可用组件安装

```sh
# 所有Master节点通过yum安装HAProxy和KeepAlived：
yum install keepalived haproxy -y
```

```sh
# 所有Master节点配置HAProxy（详细配置参考HAProxy文档，所有Master节点的HAProxy配置相同）：
[root@k8s-master01 etc]# mkdir /etc/haproxy
[root@k8s-master01 etc]# vim /etc/haproxy/haproxy.cfg 
global
  maxconn  2000
  ulimit-n  16384
  log  127.0.0.1 local0 err
  stats timeout 30s

defaults
  log global
  mode  http
  option  httplog
  timeout connect 5000
  timeout client  50000
  timeout server  50000
  timeout http-request 15s
  timeout http-keep-alive 15s

frontend monitor-in
  bind *:33305
  mode http
  option httplog
  monitor-uri /monitor

frontend k8s-master
  bind 0.0.0.0:16443
  bind 127.0.0.1:16443
  mode tcp
  option tcplog
  tcp-request inspect-delay 5s
  default_backend k8s-master

backend k8s-master
  mode tcp
  option tcplog
  option tcp-check
  balance roundrobin
  default-server inter 10s downinter 5s rise 2 fall 2 slowstart 60s maxconn 250 maxqueue 256 weight 100
  server k8s-master01	192.168.108.50:6443  check
  server k8s-master02	192.168.108.51:6443  check
  
　所有Master节点配置KeepAlived，配置不一样，注意区分 
[root@k8s-master01 pki]# vim /etc/keepalived/keepalived.conf ，注意每个节点的IP和网卡（interface参数）
```

**Master01节点的配置：**

```sh
[root@k8s-master01 etc]# mkdir /etc/keepalived

[root@k8s-master01 ~]# vim /etc/keepalived/keepalived.conf 
! Configuration File for keepalived
global_defs {
    router_id LVS_DEVEL
}
vrrp_script chk_apiserver {
    script "/etc/keepalived/check_apiserver.sh"
interval 5
    weight -5
    fall 2
    rise 1  
}
vrrp_instance VI_1 {
    state MASTER
    interface ens160# 注意更换网卡名字
    mcast_src_ip 192.168.108.50
    virtual_router_id 51
    priority 101
nopreempt
    advert_int 2
    authentication {
        auth_type PASS
        auth_pass K8SHA_KA_AUTH
    }
    virtual_ipaddress {
        192.168.108.55
    }
#    track_script {
#       chk_apiserver
#    }
}
```

**Master02节点的配置：**

```sh
[root@k8s-master01 ~]# vim /etc/keepalived/keepalived.conf 
! Configuration File for keepalived
global_defs {
    router_id LVS_DEVEL
}
vrrp_script chk_apiserver {
    script "/etc/keepalived/check_apiserver.sh"
interval 5
    weight -5
    fall 2
    rise 1
}
vrrp_instance VI_1 {
    state BACKUP
    interface ens160
    mcast_src_ip 192.168.108.51# 注意更换网卡名字
    virtual_router_id 51
    priority 100
nopreempt
    advert_int 2
    authentication {
        auth_type PASS
        auth_pass K8SHA_KA_AUTH
    }
    virtual_ipaddress {
        192.168.108.55
    }
#    track_script {
#       chk_apiserver
#    }
}
```

**Master03节点的配置：**

```sh
! Configuration File for keepalived
global_defs {
    router_id LVS_DEVEL
}
vrrp_script chk_apiserver {
    script "/etc/keepalived/check_apiserver.sh"
interval 5
    weight -5
    fall 2  
   rise 1
}
vrrp_instance VI_1 {
    state BACKUP
    interface ens160 # 注意更换网卡名字
    mcast_src_ip 192.168.0.107
    virtual_router_id 51
    priority 100
nopreempt
    advert_int 2
    authentication {
        auth_type PASS
        auth_pass K8SHA_KA_AUTH
    }
    virtual_ipaddress {
        192.168.0.200
    }
#    track_script {
#       chk_apiserver
#    }
}
```

**注意上述的健康检查是关闭的，集群建立完成后再开启：**

```sh
#    track_script {
#       chk_apiserver
#    }
```

**配置KeepAlived健康检查文件：**

```sh
[root@k8s-master01 keepalived]# cat /etc/keepalived/check_apiserver.sh 
#!/bin/bash

err=0
for k in $(seq 1 3)
do
    check_code=$(pgrep haproxy)
    if [[ $check_code == "" ]]; then
        err=$(expr $err + 1)
        sleep 1
        continue
    else
        err=0
        break
    fi
done

if [[ $err != "0" ]]; then
    echo "systemctl stop keepalived"
    /usr/bin/systemctl stop keepalived
    exit 1
else
    exit 0
fi
```

```sh
chmod +x /etc/keepalived/check_apiserver.sh
```

### 启动haproxy和keepalived

```sh
[root@k8s-master01 keepalived]# systemctl enable --now haproxy
[root@k8s-master01 keepalived]# systemctl enable --now keepalived
```

<b style="color:red;">注意 : </b>

```sh
重要：如果安装了keepalived和haproxy，需要测试keepalived是否是正常的
telnet 192.168.108.55 16443 
如果ping不通且telnet没有出现  "]"，则认为VIP不可以，不可在继续往下执行，需要排查keepalived的问题，比如防火墙和selinux，haproxy和keepalived的状态，监听端口等
所有节点查看防火墙状态必须为disable和inactive：systemctl status firewalld
所有节点查看selinux状态，必须为disable：getenforce
master节点查看haproxy和keepalived状态：systemctl status keepalived haproxy
master节点查看监听端口：netstat -lntp
```

```http
https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/high-availability/
```

## Master 节点的配置文件

Master节点的kubeadm-config.yaml配置文件如下：

### Master01 : 

```yaml
apiVersion: kubeadm.k8s.io/v1beta2
bootstrapTokens:
- groups:
  - system:bootstrappers:kubeadm:default-node-token
  token: 7t2weq.bjbawausm0jaxury
  ttl: 24h0m0s
  usages:
  - signing
  - authentication
kind: InitConfiguration
localAPIEndpoint:
  advertiseAddress: 192.168.108.50
  bindPort: 6443
nodeRegistration:
  criSocket: /var/run/dockershim.sock
  name: k8s-master01
  taints:
  - effect: NoSchedule
    key: node-role.kubernetes.io/master
---
apiServer:
  certSANs:
  - 192.168.108.55
  timeoutForControlPlane: 4m0s
apiVersion: kubeadm.k8s.io/v1beta2
certificatesDir: /etc/kubernetes/pki
clusterName: kubernetes
controlPlaneEndpoint: 192.168.108.55:16443
controllerManager: {}
dns:
  type: CoreDNS
etcd:
  local:
    dataDir: /var/lib/etcd
imageRepository: registry.cn-hangzhou.aliyuncs.com/google_containers
kind: ClusterConfiguration
kubernetesVersion: v1.18.5
networking:
  dnsDomain: cluster.local
  podSubnet: 172.168.0.0/16
  serviceSubnet: 10.96.0.0/12
scheduler: {}
```

### 更新kubeadm文件

```sh
kubeadm config migrate --old-config kubeadm-config.yaml --new-config new.yaml
```

**所有Master节点提前下载镜像，可以节省初始化时间：**

```sh
kubeadm config images pull --config /root/kubeadm-config.yaml
```

**所有节点设置开机自启动kubelet**

```sh
systemctl enable --now kubelet
```

Master01节点初始化，初始化以后会在/etc/kubernetes目录下生成对应的证书和配置文件，之后其他Master节点加入Master01即可：

```sh
kubeadm init --config /root/kubeadm-config.yaml  --upload-certs
不用配置文件初始化：
kubeadm init --control-plane-endpoint "LOAD_BALANCER_DNS:LOAD_BALANCER_PORT" --upload-certs
```

**如果初始化失败，重置后再次初始化，命令如下：**

```sh
kubeadm reset
```

**初始化成功以后，会产生Token值，用于其他节点加入时使用，因此要记录下初始化成功生成的token值（令牌值）：**

**所有Master节点配置环境变量，用于访问Kubernetes集群：**

```sh
cat <<EOF >> /root/.bashrc
export KUBECONFIG=/etc/kubernetes/admin.conf
EOF
source /root/.bashrc
```

### 查看节点状态

```sh
[root@k8s-master01 ~]# kubectl get nodes
NAME           STATUS     ROLES     AGE       VERSION
k8s-master01   NotReady   master    14m       v1.12.3
```

**采用初始化安装方式，所有的系统组件均以容器的方式运行并且在kube-system命名空间内，此时可以查看Pod状态：**

```sh
[root@k8s-master01 ~]# kubectl get pods -n kube-system -o wide
NAME                                   READY     STATUS    RESTARTS   AGE       IP              NODE
coredns-777d78ff6f-kstsz               0/1       Pending   0          14m       <none>          <none>
coredns-777d78ff6f-rlfr5               0/1       Pending   0          14m       <none>          <none>
etcd-k8s-master01                      1/1       Running   0          14m       192.168.0.100   k8s-master01
kube-apiserver-k8s-master01            1/1       Running   0          13m       192.168.0.100   k8s-master01
kube-controller-manager-k8s-master01   1/1       Running   0          13m       192.168.0.100   k8s-master01
kube-proxy-8d4qc                       1/1       Running   0          14m       192.168.0.100   k8s-master01
kube-scheduler-k8s-master01            1/1       Running   0          13m       192.168.0.100   k8s-master01
```

## Calico组件的安装

### 添加docker加速器

```sh
vim  /etc/docker/daemon.json
{
"exec-opts": ["native.cgroupdriver=systemd"], 
  "registry-mirrors": [
    "https://registry.docker-cn.com",
    "http://hub-mirror.c.163.com",
    "https://docker.mirrors.ustc.edu.cn"
  ]
}
systemctl daemon-reload
systemctl restart docker
```

### 安装Calico

```sh
Calico：https://www.projectcalico.org/
https://docs.projectcalico.org/getting-started/kubernetes/self-managed-onprem/onpremises

curl https://docs.projectcalico.org/manifests/calico.yaml -O
            - name: CALICO_IPV4POOL_CIDR
              value: "172.168.0.0/16"

kubectl apply -f calico.yaml
```

## token过期后生成新token

```sh
kubeadm token create --print-join-command

Master需要生成--certificate-key
kubeadm init phase upload-certs  --upload-certs



初始化其他master加入集群
kubeadm join 192.168.0.200:16443 --token 9zp1xe.h5kpi1b9kd5blk76     --discovery-token-ca-cert-hash sha256:6ba6e5205ac27e39e03d3b89a639ef70f6503fb877b1cf8a332b399549471740 \
    --control-plane --certificate-key 309f945f612dd7f0d830b11868edd5135e6cf358ed503107eb645dc8d7c84405
```

## Node节点的配置

```sh
Node节点上主要部署公司的一些业务应用，生产环境中不建议Master节点部署系统组件之外的其他Pod，测试环境可以允许Master节点部署Pod以节省系统资源。
kubeadm join 192.168.0.200:16443 --token 9zp1xe.h5kpi1b9kd5blk76     --discovery-token-ca-cert-hash sha256:6ba6e5205ac27e39e03d3b89a639ef70f6503fb877b1cf8a332b399549471740
```

## Metrics部署

```sh
在新版的Kubernetes中系统资源的采集均使用Metrics-server，可以通过Metrics采集节点和Pod的内存、磁盘、CPU和网络的使用率。
Heapster
更改metrics的部署文件证书，
将metrics-server-3.6.1/metrics-server-deployment.yaml的front-proxy-ca.pem改为front-proxy-ca.crt
```

**将Master01节点的front-proxy-ca.crt复制到所有Node节点**

```sh
scp /etc/kubernetes/pki/front-proxy-ca.crt k8s-node01:/etc/kubernetes/pki/front-proxy-ca.crt
scp /etc/kubernetes/pki/front-proxy-ca.crt k8s-node(其他节点自行拷贝):/etc/kubernetes/pki/front-proxy-ca.crt
```

**安装metrics server**

```sh
kubectl  apply -f  metrics-server-3.6.1/
```

```sh
[root@k8s-master01 k8s-ha-install]# cd metrics-server-3.6.1/
[root@k8s-master01 metrics-server-3.6.1]# 
[root@k8s-master01 metrics-server-3.6.1]# ls
aggregated-metrics-reader.yaml  auth-delegator.yaml  auth-reader.yaml  metrics-apiservice.yaml  metrics-server-deployment.yaml  metrics-server-service.yaml  resource-reader.yaml
[root@k8s-master01 metrics-server-3.6.1]# kubectl apply -f .
clusterrole.rbac.authorization.k8s.io/system:aggregated-metrics-reader created
clusterrolebinding.rbac.authorization.k8s.io/metrics-server:system:auth-delegator created
rolebinding.rbac.authorization.k8s.io/metrics-server-auth-reader created
apiservice.apiregistration.k8s.io/v1beta1.metrics.k8s.io created
serviceaccount/metrics-server created
deployment.apps/metrics-server created
service/metrics-server created
clusterrole.rbac.authorization.k8s.io/system:metrics-server created
clusterrolebinding.rbac.authorization.k8s.io/system:metrics-server created
```

## Dashboard部署

```sh
官方GitHub：https://github.com/kubernetes/dashboard

Dashboard用于展示集群中的各类资源，同时也可以通过Dashboard实时查看Pod的日志和在容器中执行一些命令等。
```

```sh
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.3/aio/deploy/recommended.yaml
```

```sh
更改dashboard的svc为NodePort：
kubectl edit svc kubernetes-dashboard -n kubernetes-dashboard
```

```sh
将ClusterIP更改为NodePort（如果已经为NodePort忽略此步骤）：
查看端口号：
kubectl get svc kubernates-dashboard -n kubernates-dashboard
```

```sh
根据自己的实例端口号，通过任意安装了kube-proxy的宿主机或者VIP的IP+端口即可访问到dashboard：
访问Dashboard：https://192.168.0.200:18282（请更改18282为自己的端口），选择登录方式为令牌（即token方式）
```

**创建管理员用户vim admin.yaml**

```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kube-system
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding 
metadata: 
  name: admin-user
  annotations:
    rbac.authorization.kubernetes.io/autoupdate: "true"
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kube-system
```

```sh
kubectl create -f admin.yaml -n kube-system
```

**查看token值：**

```sh
[root@k8s-master01 1.1.1]# kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep admin-user | awk '{print $1}')
Name:         admin-user-token-r4vcp
Namespace:    kube-system
Labels:       <none>
Annotations:  kubernetes.io/service-account.name: admin-user
              kubernetes.io/service-account.uid: 2112796c-1c9e-11e9-91ab-000c298bf023

Type:  kubernetes.io/service-account-token

Data
====
ca.crt:     1025 bytes
namespace:  11 bytes
token:      eyJhbGciOiJSUzI1NiIsImtpZCI6IiJ9.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlLXN5c3RlbSIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJhZG1pbi11c2VyLXRva2VuLXI0dmNwIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQubmFtZSI6ImFkbWluLXVzZXIiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiIyMTEyNzk2Yy0xYzllLTExZTktOTFhYi0wMDBjMjk4YmYwMjMiLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6a3ViZS1zeXN0ZW06YWRtaW4tdXNlciJ9.bWYmwgRb-90ydQmyjkbjJjFt8CdO8u6zxVZh-19rdlL_T-n35nKyQIN7hCtNAt46u6gfJ5XXefC9HsGNBHtvo_Ve6oF7EXhU772aLAbXWkU1xOwQTQynixaypbRIas_kiO2MHHxXfeeL_yYZRrgtatsDBxcBRg-nUQv4TahzaGSyK42E_4YGpLa3X3Jc4t1z0SQXge7lrwlj8ysmqgO4ndlFjwPfvg0eoYqu9Qsc5Q7tazzFf9mVKMmcS1ppPutdyqNYWL62P1prw_wclP0TezW1CsypjWSVT4AuJU8YmH8nTNR1EXn8mJURLSjINv6YbZpnhBIPgUGk1JYVLcn47w
```

## 一些必须的配置更改

**将Kube-proxy改为ipvs模式，因为在初始化集群的时候注释了ipvs配置，所以需要自行修改一下：**

```sh
在master01节点执行
kubectl edit cm kube-proxy -n kube-system
mode: “ipvs”
```

```sh
更新Kube-Proxy的Pod：
kubectl patch daemonset kube-proxy -p "{\"spec\":{\"template\":{\"metadata\":{\"annotations\":{\"date\":\"`date +'%s'`\"}}}}}" -n kube-system
```

```sh
验证Kube-Proxy模式
[root@k8s-master01 1.1.1]# curl 127.0.0.1:10249/proxyMode
ipvs
```

### 开启健康检查

在所有的master节点

开启keepalived的健康检查：

```sh
[root@k8s-master01 etc]# vim /etc/keepalived

[root@k8s-master01 ~]# vim /etc/keepalived/keepalived.conf 
! Configuration File for keepalived
global_defs {
    router_id LVS_DEVEL
}
vrrp_script chk_apiserver {
    script "/etc/keepalived/check_apiserver.sh"
   interval 3
    weight -5
    fall 2  
}
vrrp_instance VI_1 {
    state MASTER
    interface ens160
    mcast_src_ip 192.168.0.100
    virtual_router_id 51
    priority 100
    advert_int 2
    authentication {
        auth_type PASS
        auth_pass K8SHA_KA_AUTH
    }
    virtual_ipaddress {
        192.168.0.200
    }
# 将此块注释打开
    track_script {
       chk_apiserver
    }
}
```

### 重启keepalived

```sh
systemctl daemon-reload
systemctl restart keepalived
```

<b style="color:red;font-size:30px;">注意事项</b>

注意：kubeadm安装的集群，证书有效期默认是一年。master节点的kube-apiserver、kube-scheduler、kube-controller-manager、etcd都是以容器运行的。可以通过kubectl get po -n kube-system查看。

启动和二进制不同的是，kubelet的配置文件在/etc/sysconfig/Kubelet

其他组件的配置文件在/etc/kubernetes目录下，比如kube-apiserver.yaml，该yaml文件更改后，kubelet会自动刷新配置，也就是会重启pod。不能再次创建该文件
