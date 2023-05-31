#!/bin/bash

OUTPUT="$(pwd)/images"
BUILD_VERSION="22.03.3"
BOARD_NAME="ath79"
BOARD_SUBNAME="generic"
BUILDER="https://downloads.openwrt.org/releases/${BUILD_VERSION}/targets/${BOARD_NAME}/${BOARD_SUBNAME}/openwrt-imagebuilder-${BUILD_VERSION}-${BOARD_NAME}-${BOARD_SUBNAME}.Linux-x86_64.tar.xz"

BASEDIR=$(realpath "$0" | xargs dirname)

# download image builder
if [ ! -f "${BUILDER##*/}" ]; then
	wget "$BUILDER"
	tar xJvf "${BUILDER##*/}"
fi

[ -d "${OUTPUT}" ] || mkdir "${OUTPUT}"

cd openwrt-*/

# clean previous images
make clean

make image PROFILE="tplink_archer-c7-v5" \
           PACKAGES="block-mount kmod-fs-ext4 kmod-usb-storage blkid mount-utils swap-utils e2fsprogs fdisk luci dnsmasq bash lsblk" \
           FILES="${BASEDIR}/files/" \
            BIN_DIR="$OUTPUT"
