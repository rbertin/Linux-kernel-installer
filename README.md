# Linux-kernel-installer
A script for debugging the linux kernel

This script sets up a minimal linux (x64) distrib using the specified linux kernel's versions
and busytools for basics shell commands. 

## Usage
The script must be executed with the destination directory in first parameter. 

`./installer.sh /tmp/toinstall `

## Dependencies

 - qemu (qemu-system-x86_64)
 - cpio
 
 