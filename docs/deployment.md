# Deployment Guide

## 1. 准备 VPS

建议每个地区一台 Ubuntu 22.04 或 24.04 服务器：

- `jp-vps` 用于日本出口
- `us-vps` 用于美国出口

最低建议：

- 1 vCPU
- 1 GB RAM
- 10 GB SSD
- 独立公网 IPv4

## 2. 上传项目

将整个项目目录放到服务器，例如：

```bash
/opt/vpn-for-myself
```

## 3. 初始化主机

```bash
cd /opt/vpn-for-myself
sudo bash scripts/bootstrap-host.sh
```

## 4. 生成管理密码哈希

wg-easy 建议使用哈希后的密码。

可以先在本机或服务器上执行：

```bash
docker run --rm ghcr.io/wg-easy/wg-easy:latest wgpw 'YourStrongPassword'
```

把输出结果填入 `.env` 的 `PASSWORD_HASH`。

## 5. 选择地区配置模板

日本节点：

```bash
cp env/japan.env.example .env
```

美国节点：

```bash
cp env/us.env.example .env
```

然后修改这些值：

- `WG_HOST`
- `PASSWORD_HASH`
- `WG_PORT`
- `UI_PORT`

## 6. 配置防火墙

```bash
sudo WG_PORT=51820 UI_PORT=51821 bash scripts/configure-firewall.sh
```

如果你改过端口，把命令里的值一起改掉。

## 7. 启动服务

```bash
docker compose up -d
docker compose ps
```

## 8. 登录管理面板

打开：

```text
http://服务器IP:51821
```

登录后你可以：

- 创建用户
- 下载配置文件
- 查看二维码
- 吊销旧配置

## 9. 推荐的生产增强

- 给面板加 HTTPS 反向代理
- 限制面板访问来源 IP
- 定期备份 `./data`
- 配置监控与磁盘告警
- 分地区记录资产信息与端口分配

## 10. 当前首版的边界

这个版本是单节点部署骨架，不包含：

- 自动化多机编排
- 域名证书自动签发
- 多节点统一总控后台
- 计费和售卖系统

这些都可以在下一版继续往上加。
