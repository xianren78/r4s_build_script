#!/bin/bash

# 自定义脚本

# remove gro improvement patch
rm -f target/linux/generic/hack-6.12/600-net-enable-fraglist-GRO-by-default.patch
# according to https://github.com/coolsnowwolf/lede/issues/12331
#rm -f target/linux/generic/pending-6.12/680-net-add-TCP-fraglist-GRO-support.patch 

# https://github.com/openwrt/openwrt/commit/cee749b88975fcd2861df648ff98d399e41aa1ea
rm -f target/linux/generic/pending-6.12/620-net_sched-codel-do-not-defer-queue-length-update.patch
# https://git.cooluc.com/sbwml/target_linux_generic/commit/51e0565f724343f69f7642a28fea97c44d28d91b
rm -f target/linux/generic/pending-6.12/730-net-ethernet-mtk_eth_soc-reset-all-TX-queues-on-DMA-.patch

# add openwrt-nikki
rm -rf package/new/helloworld/luci-app-nikki
rm -rf package/new/helloworld/nikki
git clone https://$github/nikkinikki-org/OpenWrt-nikki package/new/OpenWrt-nikki

# Download and extract zashboard
mkdir -p files/etc/nikki/run/ui/zashboard
curl -Lso zashboard.zip https://$github/Zephyruso/zashboard/releases/latest/download/dist.zip
unzip zashboard.zip
mv dist/* dist/.* files/etc/nikki/run/ui/zashboard/ 2>/dev/null
rm zashboard.zip

rm -rf files/etc/nikki/run/ui/metacubexd

# Download and extract Yacd-meta-gh-pages
mkdir -p files/etc/nikki/run/ui/yacd
curl -Lso Yacd-meta-gh-pages.zip https://$github/MetaCubeX/Yacd-meta/archive/refs/heads/gh-pages.zip
unzip Yacd-meta-gh-pages.zip
mv Yacd-meta-gh-pages files/etc/nikki/run/ui/yacd
rm Yacd-meta-gh-pages.zip

# Download and extract Razord-meta-gh-pages
mkdir -p files/etc/nikki/run/ui/dashboard
curl -Lso Razord-meta-gh-pages.zip https://$github/MetaCubeX/Razord-meta/archive/refs/heads/gh-pages.zip
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
