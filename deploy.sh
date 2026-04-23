#!/bin/bash
# 星链 API 一键部署脚本 (Linux)
# 使用方法：chmod +x deploy.sh && ./deploy.sh

set -e

echo ""
echo -e "\033[36m  ⭐ 星链 API - 一键部署\033[0m"
echo -e "\033[36m  ========================\033[0m"
echo ""

# 检查 Docker
echo -e "\033[33m[1/4] 检查 Docker 环境...\033[0m"
if ! docker info > /dev/null 2>&1; then
    echo -e "\033[31m  ✗ Docker 未安装或未运行！\033[0m"
    echo "  安装方法：curl -fsSL https://get.docker.com | sh"
    exit 1
fi
echo -e "\033[32m  ✓ Docker 运行正常\033[0m"

# 创建目录
echo -e "\033[33m[2/4] 创建数据目录...\033[0m"
mkdir -p data logs/nginx logs/api nginx/ssl nginx/html nginx/conf.d
echo -e "\033[32m  ✓ 目录就绪\033[0m"

# 拉取镜像
echo -e "\033[33m[3/4] 拉取 Docker 镜像...\033[0m"
docker compose pull
echo -e "\033[32m  ✓ 镜像拉取完成\033[0m"

# 启动服务
echo -e "\033[33m[4/4] 启动服务...\033[0m"
docker compose up -d

echo ""
echo -e "\033[32m  ✅ 部署成功！\033[0m"
echo ""
echo -e "  📍 访问地址："
echo -e "     定制首页：\033[36mhttp://$(hostname -I | awk '{print $1}')\033[0m"
echo -e "     管理后台：\033[36mhttp://$(hostname -I | awk '{print $1}')\033[0m"
echo -e "     API 接口：\033[36mhttp://$(hostname -I | awk '{print $1}')/v1\033[0m"
echo ""
echo -e "  🔑 首次登录：\033[33mroot / 123456\033[0m（请立即修改密码！）"
echo ""
