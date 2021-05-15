#  mkdir -p root
#  cd root
#  mkdir -p bin dev etc lib mnt proc sbin sys tmp var
#  cd -
#  curl -L 'https://www.busybox.net/downloads/binaries/1.26.2-defconfig-multiarch/busybox-x86_64' >root/bin/busybox
#  chmod +x root/bin/busybox
#  cat >>root/init <<EOF
#  #!/bin/busybox sh
#  
#  mount -t devtmpfs  devtmpfs  /dev
#  mount -t proc      proc      /proc
#  mount -t sysfs     sysfs     /sys
#  mount -t tmpfs     tmpfs     /tmp
#  
#  sh
#  EOF
#  
#  cd root
#  find . | cpio -ov --format=newc | gzip -9 > /home/john/Downloads/build/initramfz
#  cd -

umount initrd/{dev,sys,proc,tmp}
rm -rf initrd

mkdir -p initrd/{bin,dev,etc,lib,mnt,proc,sbin,sys,tmp,var}

curl -L 'https://www.busybox.net/downloads/binaries/1.26.2-defconfig-multiarch/busybox-i686' >initrd/bin/busybox
chmod +x initrd/bin/busybox

cat >>initrd/init <<EOF
#!/bin/busybox sh

#/bin/busybox mount -t devtmpfs  devtmpfs  /dev
#/bin/busybox mount -t proc      proc      /proc
#/bin/busybox mount -t sysfs     sysfs     /sys
#/bin/busybox mount -t tmpfs     tmpfs     /tmp

/bin/busybox sh
EOF

chmod +x initrd/init
