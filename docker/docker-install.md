## 在almalinux 安装docker

```sh
dnf clean all
dnf update
dnf groupinstall "Development Tools"

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

