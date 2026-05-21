# VPN-for-myself-
这是一个供我自己使用的vpn，之后可以上线售卖
# Multi-Region WireGuard VPN Lab

一个用于学习和练习的多地区 VPN 部署项目，基于 WireGuard 和 wg-easy，实现日本、美国等不同地区出口节点的快速搭建与多人配置管理。

本项目主要用于网络工程学习，包括 VPN 隧道、NAT、路由、防火墙、Docker 部署、多用户配置管理等内容。

> ⚠️ 本项目仅用于合法的个人学习、远程访问、网络实验和合规场景。请遵守所在国家/地区法律法规、云服务商条款以及目标网站服务条款。

---

## 项目目标

本项目希望实现：

- 使用 WireGuard 搭建 VPN 节点
- 支持多个地区出口，例如：
  - 日本节点
  - 美国节点
- 每个用户拥有独立的 VPN 配置
- 支持手机、电脑客户端连接
- 使用 Docker 快速部署 wg-easy 管理面板
- 方便生成配置文件和二维码
- 作为个人 DevOps / 网络工程练手项目

---

## 技术栈

- Ubuntu Server 22.04 / 24.04
- Docker
- Docker Compose
- WireGuard
- wg-easy
- iptables / NAT
- UFW / 云厂商安全组

---

## 架构设计

```text
User Device
  ├── Japan VPN Config  ──> Japan VPS  ──> Internet
  └── US VPN Config     ──> US VPS     ──> Internet
