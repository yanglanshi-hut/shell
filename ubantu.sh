#!/bin/bash

# 确保以root用户执行
if [ "$(id -u)" != "0" ]; then
   echo "该脚本必须以root身份运行" 1>&2
   exit 1
fi

# 更新系统软件包列表
echo "更新软件包列表..."
apt-get update

# 升级所有已安装的软件包到最新版本
echo "升级所有已安装的软件包..."
apt-get -y upgrade

# 安装基本工具
echo "安装基本工具..."
apt-get install -y curl wget vim git net-tools software-properties-common

# 卸载旧版本的Docker（如有）
echo "卸载旧版本的Docker..."
apt-get remove -y docker docker-engine docker.io containerd runc

# 设置Docker的官方GPG密钥
echo "设置Docker的官方GPG密钥..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

# 添加Docker的官方APT仓库
echo "添加Docker的官方APT仓库..."
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# 更新APT包索引
echo "更新APT包索引..."
apt-get update

# 安装Docker Engine和containerd
echo "安装Docker Engine和containerd..."
apt-get install -y docker-ce docker-ce-cli containerd.io

# 添加当前用户到docker组，以免每次调用docker命令时都需要sudo（需要重新登录才能生效）
usermod -aG docker $USER

# 测试Docker是否安装成功
echo "测试Docker是否安装成功..."
docker --version

# 安装Docker Compose
# 请检查GitHub的Docker Compose发布页面（https://github.com/docker/compose/releases）以获取最新版本号，并替换下面的"latest"标签
COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
echo "安装Docker Compose版本 $COMPOSE_VERSION..."
curl -L "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# 给予执行权限
chmod +x /usr/local/bin/docker-compose

# 测试Docker Compose是否安装成功
echo "测试Docker Compose是否安装成功..."
docker-compose --version

echo "Docker和Docker Compose安装完毕！"


# 清理
echo "清理不再需要的软件包..."
apt-get autoremove -y
apt-get autoclean -y

echo "初始化脚本执行完毕！"
