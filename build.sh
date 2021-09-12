#!/bin/bash
mkdir __tmp
cd tmp
cp /boot/vmlinuz ./
mkdir -p initramfs_build/bin
wget 'https://www.busybox.net/downloads/binaries/1.31.0-defconfig-multiarch-musl/busybox-x86_64' -O initramfs_build/bin/busybox
echo $'#!/bin/sh\nexec /bin/busybox sh' >initramfs_build/init
chmod +x initramfs_build/init initramfs_build/bin/busybox
cd initramfs_build
find . -print0 | cpio --null -ov --format=newc | gzip -9 >../initramfs.cpio.gz
cd ..
find /boot/efi
exit 0
