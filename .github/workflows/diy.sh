#!/bin/bash

# 1.更新系统软件包
sudo apt install -y git curl build-essential libncurses5-dev zlib1g-dev gawk flex quilt libssl-dev xsltproc libxml-parser-perl mercurial bzr ecj cvs unzip
# 2.下载文件
mkdir Downloads

cd Downloads/

# wget https://downloads.openwrt.org/snapshots/targets/ramips/mt76x8/openwrt-sdk-ramips-mt76x8_gcc-11.3.0_musl.Linux-x86_64.tar.xz

wget https://downloads.openwrt.org/releases/22.03.2/targets/ramips/mt76x8/openwrt-sdk-22.03.2-ramips-mt76x8_gcc-11.2.0_musl.Linux-x86_64.tar.xz

tar -Jxf openwrt-sdk-22.03.2-ramips-mt76x8_gcc-11.2.0_musl.Linux-x86_64.tar.xz

mv openwrt-sdk-22.03.2-ramips-mt76x8_gcc-11.2.0_musl.Linux-x86_64 OpenWrt

rm-rf openwrt-sdk-22.03.2-ramips-mt76x8_gcc-11.2.0_musl.Linux-x86_64.tar.xz

cd OpenWrt

./scripts/feeds update -a
./scripts/feeds install libpcap

# 编译 po2lmo (如果有po2lmo可跳过)
git clone https://github.com/openwrt-dev/po2lmo.git
pushd po2lmo
make && sudo make install
popd

git clone https://github.com/KyleRicardo/MentoHUST-OpenWrt-ipk.git package/mentohust
git clone https://github.com/BoringCat/luci-app-mentohust.git package/luci-app-mentohust

rm -rf .config

mv /home/runner/work/openwrt/openwrt/.config /home/runner/work/openwrt/openwrt/Downloads/OpenWrt/.config


# make menuconfig

#图形化操作

make package/mentohust/compile V=s
make package/luci-app-mentohust/compile V=s
