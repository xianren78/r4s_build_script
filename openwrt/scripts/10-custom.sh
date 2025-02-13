#!/bin/bash

# 自定义脚本

# add openwrt-mihomo
rm -rf package/new/helloworld/luci-app-mihomo
rm -rf package/new/helloworld/mihomo
git clone https://$github/morytyann/OpenWrt-mihomo package/new/openwrt-mihomo

mkdir -p files/etc/mihomo/run/ui

# Download and extract zashboard
curl -Lso zashboard.zip https://github.com/Zephyruso/zashboard/releases/latest/download/dist.zip
unzip zashboard.zip
rm -rf files/etc/mihomo/run/ui/metacubexd
mv dist files/etc/mihomo/run/ui/zashboard
rm zashboard.zip

# Download and extract Yacd-meta-gh-pages
curl -Lso Yacd-meta-gh-pages.zip https://$github/MetaCubeX/yacd/archive/gh-pages.zip
unzip Yacd-meta-gh-pages.zip
mv Yacd-meta-gh-pages files/etc/mihomo/run/ui/yacd
rm Yacd-meta-gh-pages.zip

# Download and extract Razord-meta-gh-pages
curl -Lso Razord-meta-gh-pages.zip https://$github/MetaCubeX/Razord-meta/archive/refs/heads/gh-pages.zip
unzip Razord-meta-gh-pages.zip
mv Razord-meta-gh-pages files/etc/mihomo/run/ui/dashboard
rm Razord-meta-gh-pages.zip
