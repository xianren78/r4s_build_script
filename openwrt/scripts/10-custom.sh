#!/bin/bash

# 自定义脚本

# try to fix udp by removing patch 611-03-v6.11-udp-Fall-back-to-software-USO-if-IPv6-extension-head.patch
if [ "$version" = "rc2" ]; then
    #curl -s https://$github/xianren78/target_linux_generic/raw/refs/heads/main/hack-6.6/999-udp_offload-backto-43.patch > target/linux/generic/hack-6.6/999-udp_offload-backto-43.patch
    rm -rf target/linux/generic/backport-6.6/611-03-v6.11-udp-Fall-back-to-software-USO-if-IPv6-extension-head.patch
    curl -s https://$github/xianren78/target_linux_generic/raw/refs/heads/main/backport-6.6/900-v6.12-net-udp-Compute-L4-checksum-as-usual-when-not-segmenting-the-skb.patch > target/linux/generic/backport-6.6/900-v6.12-net-udp-Compute-L4-checksum-as-usual-when-not-segmenting-the-skb.patch
fi

# fallback uboot-rockchip version
if [ "$platform" = "rk3568" ]; then
    rm -rf package/boot/uboot-rockchip
    git clone https://$github/pmkol/package_boot_uboot-rockchip package/boot/uboot-rockchip --depth 1
fi

# add ddns-go
git clone https://$github/sirpdboy/luci-app-ddns-go package/new/ddns-go --depth 1
sed -i '3 a\\t\t"order": 50,' package/new/ddns-go/luci-app-ddns-go/root/usr/share/rpcd/acl.d/luci-app-ddns-go.json

# add eqosplus
git clone https://$github/pmkol/openwrt-eqosplus package/new/openwrt-eqosplus --depth 1

# add qosmate
git clone https://$github/hudra0/qosmate package/new/qosmate --depth 1
sed -i 's/option enabled '1'/option enabled '0'/g' package/new/qosmate/etc/config/qosmate
git clone https://$github/pmkol/luci-app-qosmate package/new/luci-app-qosmate --depth 1

# add luci-app-tailscale
git clone https://$github/asvow/luci-app-tailscale package/new/luci-app-tailscale --depth 1
sed -i '/\/etc\/init\.d\/tailscale/d;/\/etc\/config\/tailscale/d;' feeds/packages/net/tailscale/Makefile

# add luci-app-upnp
rm -rf feeds/luci/applications/luci-app-upnp
git clone https://$github/pmkol/luci-app-upnp feeds/luci/applications/luci-app-upnp --depth 1

#haproxy
sed -i '/ADDON+=USE_QUIC_OPENSSL_COMPAT=1/d' feeds/packages/net/haproxy/Makefile

# add openwrt-mihomo
rm -rf package/new/helloworld/luci-app-mihomo
rm -rf package/new/helloworld/mihomo
git clone https://$github/morytyann/OpenWrt-mihomo package/new/openwrt-mihomo
if [ "$MINIMAL_BUILD" = "y" ]; then
    if curl -s "https://$mirror/openwrt/23-config-minimal-common" | grep -q "^CONFIG_PACKAGE_luci-app-mihomo=y"; then
        mkdir -p files/etc/mihomo/run/ui
        curl -Lso metacubexd-gh-pages.zip https://$github/MetaCubeX/metacubexd/archive/refs/heads/gh-pages.zip
        unzip metacubexd-gh-pages.zip
        rm metacubexd-gh-pages.zip
        mv metacubexd-gh-pages files/etc/mihomo/run/ui/metacubexd
    fi
else
    if curl -s "https://$mirror/openwrt/23-config-common" | grep -q "^CONFIG_PACKAGE_luci-app-mihomo=y"; then 
        # Ensure the directories exist before extracting
        mkdir -p files/etc/mihomo/run/ui

        # Download and extract metacubexd
        curl -Lso metacubexd-gh-pages.zip https://$github/MetaCubeX/metacubexd/archive/refs/heads/gh-pages.zip
        unzip metacubexd-gh-pages.zip
        rm metacubexd-gh-pages.zip
        mv metacubexd-gh-pages files/etc/mihomo/run/ui/metacubexd

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
    fi
fi
