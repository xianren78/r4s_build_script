#!/bin/bash

# 自定义脚本

# add openwrt-nikki
rm -rf package/new/helloworld/luci-app-nikki
rm -rf package/new/helloworld/nikki
git clone https://$github/nikkinikki-org/OpenWrt-nikki package/new/OpenWrt-nikki

mkdir -p files/etc/nikki/run/ui

# Download and extract zashboard
curl -Lso zashboard-gh-pages.zip https://github.com/Zephyruso/zashboard/archive/refs/heads/gh-pages.zip
unzip zashboard-gh-pages.zip
rm -rf files/etc/nikki/run/ui/metacubexd
mv zashboard-gh-pages files/etc/nikki/run/ui/zashboard
rm zashboard-gh-pages.zip

# Download and extract Yacd-meta-gh-pages
curl -Lso Yacd-meta-gh-pages.zip https://github.com/MetaCubeX/Yacd-meta/archive/refs/heads/gh-pages.zip
unzip Yacd-meta-gh-pages.zip
mv Yacd-meta-gh-pages files/etc/nikki/run/ui/yacd
rm Yacd-meta-gh-pages.zip

# Download and extract Razord-meta-gh-pages
curl -Lso Razord-meta-gh-pages.zip https://github.com/MetaCubeX/Razord-meta/archive/refs/heads/gh-pages.zip
unzip Razord-meta-gh-pages.zip
mv Razord-meta-gh-pages files/etc/nikki/run/ui/dashboard
rm Razord-meta-gh-pages.zip

# pubkey
mkdir -p files/root/.ssh/
touch  files/root/.ssh/authorized_keys
chmod 0600 files/root/.ssh/authorized_keys
echo $PUBKEY > files/root/.ssh/authorized_keys

# inputrc
touch files/root/.inputrc
echo "set enable-bracketed-paste off" > files/root/.inputrc
