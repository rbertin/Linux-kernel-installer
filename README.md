# Linux-kernel-installer
A script for debugging the linux kernel

This script sets up a minimal linux (x64) distrib using the specified linux kernel's versions
and busytools for basics shell commands. 

## Usage
The script must be executed with the destination directory in first parameter. 

`./installer.sh /tmp/toinstall `

If you don't want qemu waiting for gdb connection, remove `-S -s` parameter at the end of the qemu-system-x86_64 command. 

Otherwise, for the remote debugging:

`
set architecture i386:x86-64
file vmlinux
target remote :1234
load vmlinux
`

At this time should be able to put breakpoint and so on.

## Dependencies

 - qemu (qemu-system-x86_64)
 - cpio
 - gzip

 
Tested on ArchLinux & Debian
