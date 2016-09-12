#!/bin/bash

version=linux-4.7.3

mkdir -p $1 && cd $1
if [ ! -f linux.tar.xz ]; 
then
    wget -c https://www.kernel.org/pub/linux/kernel/v4.x/$version.tar.xz -O linux.tar.xz
fi

tar -Jxf linux.tar.xz
cd $version
make defconfig
make -j2 bzImage
cd ..
wget http://www.busybox.net/downloads/busybox-1.22.0.tar.bz2
tar jxvf busybox-1.22.0.tar.bz2
cd busybox-1.22.0
make defconfig
make CFLAGS=-static install 
mkdir ../initramfs/
mv _install/* ../initramfs/
cd ../initramfs
mkdir -p proc etc home home/user root sys dev


cat > etc/passwd <<'endmsg'
root:x:0:0:root:/root:/bin/sh
user:x:1000:1000:user:/home/user:/bin/sh
endmsg

cat > init << 'initmsg'
#!/bin/sh
mknod -m 0666 /dev/null c 1 3
mknod -m 0660 /dev/ttyS0 c 4 64
 
mount -t proc proc /proc
mount -t sysfs sysfs /sys
 
setsid cttyhack setuidgid 1000 sh
 
umount /proc
umount /sys
 
poweroff -f
initmsg
chmod +x init

cp ../$version/arch/x86/boot/bzImage ../
find . |cpio -H newc -o | gzip > ../initramfs.img

cd ..
cat > run.sh << 'runSH'
#!/bin/bash
 
qemu-system-x86_64 \
        -m 64M \
        -nographic \
        -kernel bzImage \
        -append 'console=ttyS0 loglevel=3 oops=panic panic=1' \
        -monitor /dev/null \
        -initrd initramfs.img \
        -s -S

runSH

chmod +x run.sh


