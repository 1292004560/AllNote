## 获取节点并且和label

```sh
kubectl get node --show-label
```

## 获取默认名称空间的Pod

```sh
kubectl get po
```

## 从yaml中新建Pod

```sh
kubectl create -f pod.yaml
```

```sh
kubectl get po --show-label
```

```sh
kubectl delete po nginx
```

```sh
kubectl logs -f nginx
```

```sh
kubectl delete po nginx -n kube-pubic  
```

```sh
kubectl get deployment -n kube-system
```

```sh
kubectl edit coredns -n kube-system
```

```sh
kubectl get po -oyaml
```

```sh
kubectl describe po nginx
```

```sh
kubectl exec -it nginx -- sh
```

```sh
kubectl delete -f pod.yaml
```

```sh
time kubectl delete po nginx
```

```sh
kubectl replace -f nginx-deploy.yaml
```

```sh
kubectl get po -owide
```

```sh
kubectl roolout status deploy nginx
```

```sh
kubectl set image deploy nginx nginx=nginx:2.1 --record
```

```sh
kubectl rollout history deploy nginx
```

```sh
# 回滚到上个版本
kubectl rollout undo deploy nginx

kubectl get po
```

```sh
kubectl get deploy nginx -oyaml | grep nginx
```

```sh
# 查看指定版本的详细信息
kubectl rollout history deploy nginx --reverion=5
```

```sh
# 扩容
kubectl scale --replicas=3 deploy nginx
```

```sh
kubectl get pod --namespace=kube-system
```

```sh
kubectl describe pod coredns-5bbd96d687-hx99g --namespace=kube-system
kubectl -n kube-flannel logs kube-flannel-ds-mpbsq

nmcli connection reload
nmcli connection up ens3
nmcli connection down ens3
nmcli connection down ens3 && nmcli connection up ens3


 kubeadm token create --print-join-command
 
kubeadm token create --print-join-command
kubeadm join 192.168.108.100:6443 --token mefpp7.lebt21478dl8rijy --discovery-token-ca-cert-hash sha256:7f7461fdedf7bd7f41e839a9790b4cb1daf81ea2a7b9a0e6d80dbb3c08ebc0d7
  --cri-socket unix:///var/run/cri-dockerd.sock
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
kubeadm init --image-repository registry.aliyuncs.com/google_containers --kubernetes-version=v1.26.2 --pod-network-cidr=10.244.0.0/16 --cri-socket /var/run/cri-dockerd.sock

```

```sh
wget https://docs.projectcalico.org/manifests/calico.yaml
kubectl get nodes -l gpu=true
```

```sh
kubectl delete pod -l version=canary  # 删除所有版本为canary的pod
```

```sh
kubectl create namespace zzz
```

```sh
kubectl get pods -L app
```

```sh
kubectl exec kubia-pc9qz env 
```

