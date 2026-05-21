#!/usr/bin/env bash

set -euo pipefail

if [[ "${EUID}" -ne 0 ]]; then
  echo "Please run as root or with sudo."
  exit 1
fi

WG_PORT="${WG_PORT:-51820}"
UI_PORT="${UI_PORT:-51821}"

if ! grep -q '^net.ipv4.ip_forward=1$' /etc/sysctl.conf; then
  echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf
fi

sysctl -p

ufw allow OpenSSH
ufw allow "${WG_PORT}/udp"
ufw allow "${UI_PORT}/tcp"
ufw --force enable

cat <<EOF
Firewall configured.

Allowed ports:
- SSH
- UDP ${WG_PORT} for WireGuard
- TCP ${UI_PORT} for wg-easy

If your cloud provider uses security groups, open the same ports there too.
EOF
