#!/bin/bash
# SSH ProxyCommand — 自动检测 HTTP_PROXY，有则走 HTTP CONNECT，无则直连
# 依赖 corkscrew（已安装）

proxy="${HTTP_PROXY:-${http_proxy:-}}"
host="$1"
port="$2"

if [ -z "$proxy" ]; then
    exec nc "$host" "$port"
fi

# 解析代理地址
proxy="${proxy#http://}"
proxy="${proxy#https://}"
proxy_host="${proxy%:*}"
proxy_port="${proxy##*:}"
[ "$proxy_host" = "$proxy_port" ] && proxy_port=8080

exec corkscrew "$proxy_host" "$proxy_port" "$host" "$port"