#!/bin/bash

if [ ${EUID:-${UID}} = 0 ]; then
    echo 'this script needs root permission.'
fi

network_addr=192.168.1.
host_addr=$1
shift
mask=24
shift
gw=254

tmpdir=$(mktemp -d)
tmpfile=$(mktemp)

dd if=/dev/zero of=$tmpfile bs=1M count=5
mkfs.ext3 -F $tmpfile
mount -o loop -t ext3 $tmpfile $tmpdir
cat <<EOF > $tmpdir/cloudinit.sh
#!/bin/sh
nmcli c mod eth0 connection.autoconnect yes ipv4.method manual ipv4.addresses $network_addr$host_addr/$mask ipv4.gateway ${network_addr}254
EOF
umount $tmpdir
rmdir $tmpdir
echo $tmpfile
