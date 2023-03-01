#!/bin/bash
lsblk  # 查看系统存在的盘
mkfs.xfs -f  /dev/sde #格式化
echo y | vgextend centos /dev/sde 
lvextend -L +59.9G /dev/mapper/centos-root /dev/sde
vgdisplay
xfs_growfs /dev/centos/root
