#!/bin/bash

# 确保脚本以 root 权限运行
if [ "$(id -u)" != "0" ]; then
   echo "该脚本必须以 root 权限运行" 1>&2
   exit 1
fi

# 创建新用户（您可以选择添加更多选项，如 -m 创建家目录）
adduser yls

# 将新用户添加到 sudo 组
usermod -aG sudo yls

