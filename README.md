# ⭐ 星链 API - 部署指南

基于 [New API](https://github.com/Calcium-Ion/new-api) 二次开发的一站式 AI API 中转服务平台。

## 📁 项目结构

```
api-server/
├── docker-compose.yml        # Docker 编排配置
├── deploy.ps1                # 一键部署脚本（Windows）
├── deploy.sh                 # 一键部署脚本（Linux）
├── nginx/
│   ├── conf.d/
│   │   └── default.conf      # Nginx 反向代理配置
│   ├── html/
│   │   └── index.html        # 定制首页（国潮渐变风格）
│   └── ssl/                  # SSL 证书目录（生产环境放置证书）
├── data/                     # New API 数据目录（自动生成）
└── logs/                     # 日志目录（自动生成）
```

## 🚀 快速启动

### Windows（PowerShell）

```powershell
# 1. 确保已安装 Docker Desktop 并启动
# 2. 执行一键部署
.\deploy.ps1
```

### Linux / 服务器

```bash
# 1. 确保已安装 Docker 和 Docker Compose
curl -fsSL https://get.docker.com | sh

# 2. 克隆项目
git clone https://github.com/rao5201/api.git
cd api

# 3. 一键启动
chmod +x deploy.sh
./deploy.sh
```

### 手动启动

```bash
docker-compose up -d
```

## 📍 访问地址

| 服务 | 地址 |
|------|------|
| 定制首页 | http://localhost |
| New API 管理后台 | http://localhost |
| API 接口 | http://localhost/v1 |
| 注册页面 | http://localhost/register |

> 首次登录账号：`root` / 密码：`123456`（**务必立即修改**）

## 🔧 首次配置清单

1. **修改密码** → 后台 → 个人设置 → 修改密码
2. **系统设置** → 系统设置 → 修改系统名称、Logo、新用户赠送额度
3. **添加渠道** → 渠道管理 → 添加上游 API Key（OpenAI / Claude / DeepSeek 等）
4. **创建令牌** → 令牌管理 → 创建 API 密钥
5. **自定义首页** → 系统设置 → 首页内容（可选覆盖 Nginx 的 index.html）

## 🔐 生产环境安全

在部署到生产服务器前，**必须修改** `docker-compose.yml` 中的：

```yaml
- POSTGRES_PASSWORD=StarLink2025!     # 改为强密码
- REDIS requirepass StarLink2025!      # 改为强密码
- SESSION_SECRET=starlink_api_...       # 改为随机字符串
- SQL_DSN=postgresql://root:xxx@...    # 对应数据库密码
```

## 🌐 绑定域名（可选）

1. 修改 `nginx/conf.d/default.conf` 中的 `server_name` 为你的域名
2. 将 SSL 证书放入 `nginx/ssl/` 目录
3. 取消 `default.conf` 底部 HTTPS 配置的注释
4. 修改 `docker-compose.yml` 端口映射 `"443:443"`

## 📧 联系方式

- 邮箱：rao5201@126.com
- GitHub：https://github.com/rao5201/api
