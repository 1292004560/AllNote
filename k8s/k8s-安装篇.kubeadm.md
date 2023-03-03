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
```

### 安装k8s组件

```sh
yum list kubeadm.x86_64 --showduplicates | sort -r

所有节点安装最新版本kubeadm：
yum install kubeadm -y
所有节点安装指定版本k8s组件：
yum install -y kubeadm-1.12.3-0.x86_64 kubectl-1.12.3-0.x86_64 kubelet-1.12.3-0.x86_64

所有节点设置开机自启动Docker：
systemctl daemon-reload && systemctl enable --now docker
```

### 配置仓库

```sh
# 默认配置的pause镜像使用gcr.io仓库，国内可能无法访问，所以这里配置Kubelet使用阿里云的pause镜像：
DOCKER_CGROUPS=$(docker info | grep 'Cgroup' | cut -d' ' -f4)
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
所有Master节点通过yum安装HAProxy和KeepAlived：
yum install keepalived haproxy -y
```

```sh
所有Master节点配置HAProxy（详细配置参考HAProxy文档，所有Master节点的HAProxy配置相同）：
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
  server k8s-master01	192.168.0.100:6443  check
  server k8s-master02	192.168.0.106:6443  check
  server k8s-master03	192.168.0.107:6443  check
  
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
    interface ens160
    mcast_src_ip 192.168.0.100
    virtual_router_id 51
    priority 101
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

**Master02节点的配置：**

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
    interface ens160
    mcast_src_ip 192.168.0.106
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
    interface ens160
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

