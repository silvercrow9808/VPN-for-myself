# VPN-for-myself

一个基于 WireGuard 与 wg-easy 的多地区 VPN 实验项目。

这个仓库提供的是一套适合个人学习和快速落地的首版骨架，目标是让你可以把相同的部署结构分别放到日本、美国等不同 VPS 上，得到独立出口节点，并通过 `wg-easy` 面板管理每个节点的客户端配置。

## 技术栈

- Ubuntu Server 22.04 / 24.04
- Docker Engine
- Docker Compose Plugin
- WireGuard
- wg-easy
- iptables / NAT
- UFW

## 目录结构

```text
.
├── docker-compose.yml
├── .env.example
├── env
│   ├── japan.env.example
│   └── us.env.example
├── docs
│   └── deployment.md
└── scripts
    ├── bootstrap-host.sh
    └── configure-firewall.sh
```

## 设计说明

这个首版按“每个地区一台 VPS”来设计：

- 日本 VPS 部署一份 `wg-easy`
- 美国 VPS 部署一份 `wg-easy`
- 每个地区使用自己的域名、密码、端口和 WireGuard 子网
- 每个客户端配置只归属于一个节点

这样结构最简单，也更接近真实部署方式。

## 快速开始

1. 把项目上传到你的 VPS。
2. 运行主机初始化脚本：

```bash
sudo bash scripts/bootstrap-host.sh
```

3. 复制环境模板：

```bash
cp env/japan.env.example .env
```

或：

```bash
cp env/us.env.example .env
```

4. 按实际信息修改 `.env`。
5. 配置防火墙与转发：

```bash
sudo bash scripts/configure-firewall.sh
```

6. 启动服务：

```bash
docker compose up -d
```

7. 打开面板：

```text
http://<your-server-ip>:51821
```

## 默认部署思路

- 日本节点建议使用 `10.8.0.0/24`
- 美国节点建议使用 `10.9.0.0/24`
- 管理面板默认端口 `51821`
- WireGuard 默认 UDP 端口 `51820`

如果你在同一台机器上做实验，可以改掉端口和子网，避免冲突。

## 后续可扩展内容

- Nginx / Caddy 反向代理与 HTTPS
- 多节点统一入口页
- 自动备份客户端配置
- Ansible 一键部署
- 节点监控与告警

## 合规说明

本项目仅用于合法的学习、远程访问、个人网络实验与合规场景。请遵守本地法律法规、云服务商条款与目标服务条款。
