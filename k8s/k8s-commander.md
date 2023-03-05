```sh
kubectl get node --show-label
```

```sh
kubectl get po
```

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

