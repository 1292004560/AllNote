#!/bin/bash
dd if=/dev/zero of=test.img bs=10M count=1
losetup /dev/loop0 test.img
mkfs.ext4 /dev/loop0 -N 5
losetup -d /dev/loop0
mkdir /test-dir
mount -o loop test.img test-dir/


