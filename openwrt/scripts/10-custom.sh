#!/bin/bash

# 自定义脚本

# add https://github.com/unifreq/linux-6.12.y/commit/efcda2e8870430b2db57e3a0da66a5ed4e2dd6d6 patch
curl -Os  https://github.com/unifreq/linux-6.12.y/commit/efcda2e8870430b2db57e3a0da66a5ed4e2dd6d6.patch > target/linux/generic/hack-6.12/efcda2.patch

# remove gro improvement patch
rm -f target/linux/generic/hack-6.12/600-net-enable-fraglist-GRO-by-default.patch
# according to https://github.com/coolsnowwolf/lede/issues/12331
#rm -f target/linux/generic/pending-6.12/680-net-add-TCP-fraglist-GRO-support.patch 

# remove mbedtls gcc15 patch after openwrt commit https://github.com/openwrt/openwrt/commit/53ab5629c31f3c7ca58cb48518d530c660ee0023
rm -f package/libs/mbedtls/patches/901-tests-fix-string-initialization-error-on-gcc15.patch

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
