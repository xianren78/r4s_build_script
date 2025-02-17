#!/bin/bash

# 自定义脚本

# add openwrt-nikki
rm -rf package/new/helloworld/luci-app-nikki
rm -rf package/new/helloworld/nikki
git clone https://$github/nikkinikki-org/OpenWrt-nikki package/new/OpenWrt-nikki

mkdir -p files/etc/nikki/run/ui

# Download and extract zashboard
curl -Lso zashboard.zip https://github.com/Zephyruso/zashboard/releases/latest/download/dist.zip
unzip zashboard.zip
rm -rf files/etc/nikki/run/ui/metacubexd
mv dist files/etc/nikki/run/ui/zashboard
rm zashboard.zip

# Download and extract Yacd-meta-gh-pages
curl -Lso Yacd-meta-gh-pages.zip https://$github/MetaCubeX/yacd/archive/gh-pages.zip
unzip Yacd-meta-gh-pages.zip
mv Yacd-meta-gh-pages files/etc/nikki/run/ui/yacd
rm Yacd-meta-gh-pages.zip

# Download and extract Razord-meta-gh-pages
curl -Lso Razord-meta-gh-pages.zip https://$github/MetaCubeX/Razord-meta/archive/refs/heads/gh-pages.zip
unzip Razord-meta-gh-pages.zip
mv Razord-meta-gh-pages files/etc/nikki/run/ui/dashboard
rm Razord-meta-gh-pages.zip
