#!/bin/sh

if [ ! -f CentOS-7-x86_64-Minimal-1908.iso ]; then
  wget http://ftp-srv2.kddilabs.jp/Linux/packages/CentOS/7.7.1908/isos/x86_64/CentOS-7-x86_64-Minimal-1908.iso
fi

virt-install   --name mkimg   --hvm   --virt-type kvm   --ram 1024   --vcpus 1   --arch x86_64   --os-type linux   --os-variant rhel7   --boot hd   --disk mkimg.qcow2,size=5,format=qcow2   --graphics none   --serial pty   --console pty   --location CentOS-7-x86_64-Minimal-1908.iso   --initrd-inject mkimg.ks.cfg   --extra-args "inst.ks=file:/mkimg.ks.cfg console=ttyS0"

#virsh undefine mkimg
