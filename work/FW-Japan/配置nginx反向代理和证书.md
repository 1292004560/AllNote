## 1. 免密登陆服务器

```sh
vim ~/.ssh/config
Host cardshop-dev.fw-robot.com
  HostName cardshop-dev.fw-robot.com
  User azureuser
  IdentityFile ~/.ssh/vm-cardshop-dev_key.pem
  
 ssh azureuser@cardshop-dev.fw-robot.com
```

## 2. 安装docker

```shell
# 更新软件包并安装必要软件
sudo apt update
sudo apt install apt-transport-https curl

#导入 Docker 官方 GPG 密钥
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# 添加 Docker 官方仓库
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 更新软件包列表
sudo apt update

# 安装 Docker
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

#检查 Docker 服务状态
sudo systemctl is-active docker

# 查看此端口是否可以远程访问
ss -tuln | grep ':8082'
```

## 3. 安装portainer

```shell
docker run -d \
  -p 9000:9000 \
  --name portainer \
  --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v portainer_data:/data \
  portainer/portainer-ce:latest
```

## 4. 安装nginx-proxy-manager

```shell
mkdir -p ~/docker/npm && cd ~/docker/npm
vim docker-compose.yml
```

```yaml
version: '3'
services:
  app:
    image: 'jc21/nginx-proxy-manager:latest'
    restart: unless-stopped
    ports:
      - '80:80'    # HTTP
      - '443:443'  # HTTPS
      - '81:81'    # 管理界面
    volumes:
      - ./data:/data
      - ./letsencrypt:/etc/letsencrypt
    depends_on:
      - db
  db:
    image: 'jc21/mariadb-aria:latest'
    restart: unless-stopped
    environment:
      MYSQL_ROOT_PASSWORD: 'npm'
      MYSQL_DATABASE: 'npm'
      MYSQL_USER: 'npm'
      MYSQL_PASSWORD: 'npm'
    volumes:
      - ./mysql:/var/lib/mysql
```

```shell
docker-compose up -d

浏览器打开 http://服务器IP:81，使用默认账号登录：
​​邮箱​​：admin@example.com
​​密码​​：changeme
​​首次登录需修改密码​​，建议启用两步验证提升安全性。
```

