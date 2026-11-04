#!/bin/bash
# Usage: bash make_ubuntu_bootable_usb.sh /dev/sda
#   /dev/sda     target USB
# Run as root in the Chrome OS shell.

USB=$1
cgpt create $USB
cgpt add -i 1 -t kernel -b 8192 -s 65536 -l Kernel -S 1 -T 5 -P 10 $USB
cgpt add -i 2 -t data -b 73728 -s 2000335503 -l Root $USB
sleep 2

cd /tmp
wget https://github.com/skysilvergrass/chromebook-hp-11a-vmlinux-kpart/raw/refs/heads/master/v7.3/vmlinux.kpart
dd if=./vmlinux.kpart of=${USB}1 bs=1M

mkdir root
mount $USB2 root
cd root
wget https://cdimage.ubuntu.com/ubuntu-base/releases/22.04/release/ubuntu-base-22.04-base-arm64.tar.gz
tar zxfm  *.tar.gz
mount --bind /dev dev
mount --bind /proc proc
mount --bind /sys sys
cp /etc/resolv.conf etc

sync
echo "done."
