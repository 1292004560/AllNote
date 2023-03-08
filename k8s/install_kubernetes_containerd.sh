#!/bin/bash
#
#********************************************************************
#Author:            wangxiaochun
#QQ:                29308620
#Date:              2022-05-25
#FileName:          install_kubernetes_containerd.sh
#URL:               http://www.wangxiaochun.com
#Description:       The test script
#Copyright (C):     2022 All rights reserved
#********************************************************************

#说明:安装Kubernetes服务器内存建议至少2G

KUBE_VERSION="1.25.0"
#KUBE_VERSION="1.24.4"
#KUBE_VERSION="1.24.3"
#KUBE_VERSION="1.24.0"

KUBE_VERSION2=$(echo $KUBE_VERSION |awk -F. '{print $2}')

KUBEAPI_IP=10.0.0.100
MASTER1_IP=10.0.0.101
MASTER2_IP=10.0.0.102
MASTER3_IP=10.0.0.103
NODE1_IP=10.0.0.104
NODE2_IP=10.0.0.105
NODE3_IP=10.0.0.106
HARBOR_IP=10.0.0.200

DOMAIN=wang.org

MASTER1=master1.$DOMAIN
MASTER2=master2.$DOMAIN
MASTER3=master3.$DOMAIN
NODE1=node1.$DOMAIN
NODE2=node2.$DOMAIN
NODE3=node3.$DOMAIN
HARBOR=harbor.$DOMAIN

POD_NETWORK="10.244.0.0/16"
SERVICE_NETWORK="10.96.0.0/12"

IMAGES_URL="registry.aliyuncs.com/google_containers"


LOCAL_IP=`hostname -I|awk '{print $1}'`

. /etc/os-release

COLOR_SUCCESS="echo -e \\033[1;32m"
COLOR_FAILURE="echo -e \\033[1;31m"
END="\033[m"


color () {
    RES_COL=60
    MOVE_TO_COL="echo -en \\033[${RES_COL}G"
    SETCOLOR_SUCCESS="echo -en \\033[1;32m"
    SETCOLOR_FAILURE="echo -en \\033[1;31m"
    SETCOLOR_WARNING="echo -en \\033[1;33m"
    SETCOLOR_NORMAL="echo -en \E[0m"
    echo -n "$1" && $MOVE_TO_COL
    echo -n "["
    if [ $2 = "success" -o $2 = "0" ] ;then
        ${SETCOLOR_SUCCESS}
        echo -n $"  OK  "    
    elif [ $2 = "failure" -o $2 = "1"  ] ;then 
        ${SETCOLOR_FAILURE}
        echo -n $"FAILED"
    else
        ${SETCOLOR_WARNING}
        echo -n $"WARNING"
    fi
    ${SETCOLOR_NORMAL}
    echo -n "]"
    echo 
}

check () {
    if [ $ID = 'ubuntu' -a ${VERSION_ID} = "20.04"  ];then
        true
    else
        color "不支持此操作系统，退出!" 1
        exit
    fi
    if [ $KUBE_VERSION2 -lt 24 ] ;then 
        color "当前kubernetes版本过低，Containerd要求不能低于v1.24.0版，退出!" 1
        exit
    fi
}



install_prepare () {
    cat >> /etc/hosts <<EOF

$KUBEAPI_IP kubeapi.$DOMAIN
$MASTER1_IP $MASTER1
$MASTER2_IP $MASTER2
$MASTER3_IP $MASTER3
$NODE1_IP $NODE1
$NODE2_IP $NODE2
$NODE3_IP $NODE3
$HARBOR_IP $HARBOR
EOF
    hostnamectl set-hostname $(awk -v ip=$LOCAL_IP '{if($1==ip && $2 !~ "kubeapi")print $2}' /etc/hosts)
    swapoff -a
    sed -i '/swap/s/^/#/' /etc/fstab
    color "安装前准备完成!" 0
    sleep 1
}

config_kernel () {
    cat <<EOF | tee /etc/modules-load.d/k8s.conf
    overlay
    br_netfilter
EOF

    modprobe overlay
    modprobe br_netfilter

    cat <<EOF | tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF
    sysctl --system
}

install_containerd () {
    apt update
    apt -y install containerd || { color "安装Containerd失败!" 1; exit 1; }
    mkdir /etc/containerd/
    containerd config default > /etc/containerd/config.toml
    sed -i "s#k8s.gcr.io#${IMAGES_URL}#g"  /etc/containerd/config.toml
    #sed -i 's#SystemdCgroup = false#SystemdCgroup = true#g' /etc/containerd/config.toml
    systemctl restart containerd.service
    [ $? -eq 0 ] && { color "安装Containerd成功!" 0; sleep 1; } || { color "安装Containerd失败!" 1 ; exit 2; }
}

install_kubeadm () {
    apt-get update && apt-get install -y apt-transport-https
    curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | apt-key add - 
    cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main
EOF
    apt-get update
    apt-cache madison kubeadm |head
    ${COLOR_FAILURE}"5秒后即将安装: kubeadm-"${KUBE_VERSION}" 版本....."${END}
    ${COLOR_FAILURE}"如果想安装其它版本，请按ctrl+c键退出，修改版本再执行"${END}
    sleep 6

    #安装指定版本
    apt install -y  kubeadm=${KUBE_VERSION}-00 kubelet=${KUBE_VERSION}-00 kubectl=${KUBE_VERSION}-00
    [ $? -eq 0 ] && { color "安装kubeadm成功!" 0;sleep 1; } || { color "安装kubeadm失败!" 1 ; exit 2; }
    
    #实现kubectl命令自动补全功能    
    kubectl completion bash > /etc/profile.d/kubectl_completion.sh
}

#只有Kubernetes集群的第一个master节点需要执行下面初始化函数
kubernetes_init () {
    kubeadm init --control-plane-endpoint="kubeapi.$DOMAIN" \
                 --kubernetes-version=v${KUBE_VERSION}  \
                 --pod-network-cidr=${POD_NETWORK} \
                 --service-cidr=${SERVICE_NETWORK} \
                 --token-ttl=0  \
                 --upload-certs \
                 --image-repository=${IMAGES_URL} 
    [ $? -eq 0 ] && color "Kubernetes集群初始化成功!" 0 || { color "Kubernetes集群初始化失败!" 1 ; exit 3; }
    mkdir -p $HOME/.kube
    cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    chown $(id -u):$(id -g) $HOME/.kube/config
}

reset_kubernetes() {
    kubeadm reset -f --cri-socket unix:///run/cri-dockerd.sock
    rm -rf  /etc/cni/net.d/  $HOME/.kube/config
}

config_crictl () {
    cat > /etc/crictl.yaml <<EOF
runtime-endpoint: unix:///run/containerd/containerd.sock
image-endpoint: unix:///run/containerd/containerd.sock
EOF

}

check 

PS3="请选择编号(1-4): "
ACTIONS="
初始化新的Kubernetes集群
加入已有的Kubernetes集群
退出Kubernetes集群
退出本程序
"
select action in $ACTIONS;do
    case $REPLY in 
    1)
        install_prepare
        config_kernel
        install_containerd
        install_kubeadm
        kubernetes_init
        config_crictl
        break
        ;;
    2)
        install_prepare
        config_kernel
        install_containerd
        install_kubeadm
        $COLOR_SUCCESS"加入已有的Kubernetes集群已准备完毕,还需要执行最后一步加入集群的命令 kubeadm join ... "${END}
        break
        ;;
    3)
        reset_kubernetes
        break
        ;;
    4)
        exit
        ;;
    esac
done
exec bash

