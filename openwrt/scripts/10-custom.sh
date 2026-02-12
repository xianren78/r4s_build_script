#!/bin/bash

# 自定义脚本

# replace miniupnpd download domain
sed -i 's/tuxfamily\.org/free.fr/g' feeds/packages/net/miniupnpd/Makefile

# remove gro improvement patch
rm -f target/linux/generic/hack-6.12/600-net-enable-fraglist-GRO-by-default.patch
rm -f target/linux/generic/hack-6.18/600-net-enable-fraglist-GRO-by-default.patch
# according to https://github.com/coolsnowwolf/lede/issues/12331
#rm -f target/linux/generic/pending-6.12/680-net-add-TCP-fraglist-GRO-support.patch 

rm -f package/network/services/odhcpd/patches/001-odhcpd-RFC-9096-compliance.patch

# https://github.com/openwrt/openwrt/commit/cee749b88975fcd2861df648ff98d399e41aa1ea
rm -f target/linux/generic/pending-6.12/620-net_sched-codel-do-not-defer-queue-length-update.patch
rm -f target/linux/generic/pending-6.18/620-net_sched-codel-do-not-defer-queue-length-update.patch
# https://git.cooluc.com/sbwml/target_linux_generic/commit/51e0565f724343f69f7642a28fea97c44d28d91b
rm -f target/linux/generic/pending-6.12/730-net-ethernet-mtk_eth_soc-reset-all-TX-queues-on-DMA-.patch
rm -f target/linux/generic/pending-6.18/730-net-ethernet-mtk_eth_soc-reset-all-TX-queues-on-DMA-.patch

#openssl 3.0.19
rm -f package/libs/openssl/patches/140-allow-prefer-chacha20.patch
rm -f package/libs/openssl/patches/500-e_devcrypto-default-to-not-use-digests-in-engine.patch
rm -f package/libs/openssl/patches/510-e_devcrypto-ignore-error-when-closing-session.patch
pushd package/libs/openssl/patches
	curl -s -f -L -O https://github.com/openwrt/openwrt/raw/refs/heads/openwrt-24.10/package/libs/openssl/patches/140-allow-prefer-chacha20.patch
	curl -s -f -L -O https://github.com/openwrt/openwrt/raw/refs/heads/openwrt-24.10/package/libs/openssl/patches/500-e_devcrypto-default-to-not-use-digests-in-engine.patch
	curl -s -f -L -O https://github.com/openwrt/openwrt/raw/refs/heads/openwrt-24.10/package/libs/openssl/patches/510-e_devcrypto-ignore-error-when-closing-session.patch
popd

# add openwrt-nikki
rm -rf package/new/helloworld/luci-app-nikki
rm -rf package/new/helloworld/nikki
git clone https://$github/nikkinikki-org/OpenWrt-nikki package/new/OpenWrt-nikki

# Download and extract zashboard
mkdir -p files/etc/nikki/run/ui/zashboard
curl -Lso zashboard.zip https://$github/Zephyruso/zashboard/releases/latest/download/dist-cdn-fonts.zip
unzip zashboard.zip
mv dist/* dist/.* files/etc/nikki/run/ui/zashboard/ 2>/dev/null
rm zashboard.zip

rm -rf files/etc/nikki/run/ui/metacubexd
rm -rf files/etc/nikki/run/ui/yacd
rm -rf files/etc/nikki/run/ui/dashboard

# pubkey
mkdir -p files/root/.ssh/
touch  files/root/.ssh/authorized_keys
chmod 0600 files/root/.ssh/authorized_keys
echo $PUBKEY > files/root/.ssh/authorized_keys

# inputrc
touch files/root/.inputrc
echo "set enable-bracketed-paste off" > files/root/.inputrc
