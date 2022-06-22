#!/bin/bash

# do menu config and update linux sym link before this
set -e

cd /usr/src/linux
make modules_prepare
mount /dev/nvme0n1p1 /boot
make -j12 && make modules_install && make install && emerge @module-rebuild && grub-mkconfig -o /boot/grub/grub.cfg
exit
