# 星链 API 一键部署脚本 (Windows)
# 使用方法：在 PowerShell 中执行 .\deploy.ps1

Write-Host ""
Write-Host "  ⭐ 星链 API - 一键部署" -ForegroundColor Cyan
Write-Host "  ========================" -ForegroundColor Cyan
Write-Host ""

# 检查 Docker
Write-Host "[1/4] 检查 Docker 环境..." -ForegroundColor Yellow
try {
    $null = docker info 2>&1
    if ($LASTEXITCODE -ne 0) { throw "Docker 未运行" }
    Write-Host "  ✓ Docker 运行正常" -ForegroundColor Green
} catch {
    Write-Host "  ✗ Docker 未运行，请先启动 Docker Desktop！" -ForegroundColor Red
    exit 1
}

# 创建目录
Write-Host "[2/4] 创建数据目录..." -ForegroundColor Yellow
@("data", "logs/nginx", "logs/api", "nginx/ssl") | ForEach-Object {
    if (-not (Test-Path $_)) { New-Item -ItemType Directory -Path $_ -Force | Out-Null }
}
Write-Host "  ✓ 目录就绪" -ForegroundColor Green

# 拉取镜像
Write-Host "[3/4] 拉取 Docker 镜像..." -ForegroundColor Yellow
docker compose pull 2>&1 | ForEach-Object { Write-Host "  $_" }
if ($LASTEXITCODE -eq 0) {
    Write-Host "  ✓ 镜像拉取完成" -ForegroundColor Green
} else {
    Write-Host "  ⚠ 镜像拉取可能有问题，尝试继续..." -ForegroundColor DarkYellow
}

# 启动服务
Write-Host "[4/4] 启动服务..." -ForegroundColor Yellow
docker compose up -d 2>&1 | ForEach-Object { Write-Host "  $_" }

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "  ✅ 部署成功！" -ForegroundColor Green
    Write-Host ""
    Write-Host "  📍 访问地址：" -ForegroundColor White
    Write-Host "     定制首页：http://localhost" -ForegroundColor Cyan
    Write-Host "     管理后台：http://localhost" -ForegroundColor Cyan
    Write-Host "     API 接口：http://localhost/v1" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  🔑 首次登录：root / 123456（请立即修改密码！）" -ForegroundColor Yellow
    Write-Host ""
} else {
    Write-Host "  ✗ 启动失败，请检查日志：docker compose logs" -ForegroundColor Red
}
