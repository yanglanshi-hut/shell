#!/bin/bash

# 确保脚本以 root 权限运行
if [ "$(id -u)" != "0" ]; then
   echo "该脚本必须以 root 权限运行" 1>&2
   exit 1
fi

# 用户名和密码，根据需要替换 YOUR_PASSWORD
USERNAME="yls"
PASSWORD="YOUR_PASSWORD"

# 检查用户是否存在
if id "$USERNAME" &>/dev/null; then
    echo "用户 $USERNAME 已存在，将更新其密码。"
else
    echo "用户 $USERNAME 不存在，将创建该用户并设置密码。"
    # 使用 useradd 创建用户并创建家目录
    useradd -m "$USERNAME"

    # 将新用户添加到 sudo 组
    usermod -aG sudo "$USERNAME"
fi

# 设置或更新用户密码
echo "$USERNAME:$PASSWORD" | chpasswd
echo "密码设置完成。"
