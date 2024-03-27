#!/bin/bash

# 更新系统并安装必要的软件
apt update && apt upgrade -y
apt install -y curl

# 从v2ray官方脚本安装v2ray
bash <(curl -sL https://multi.netlify.app/v2ray.sh) --zh

# 启动v2ray服务
systemctl start v2ray
systemctl enable v2ray

echo "v2ray安装和配置完成"

