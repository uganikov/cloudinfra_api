#!/bin/sh

if [ ${EUID:-${UID}} = 0 ]; then
    echo 'this script needs root permission.'
fi

tmpdir=$(mktemp -d)
tmpfile=$(mktemp)

dd if=/dev/zero of=$tmpfile bs=1M count=5
mkfs.ext3 -F $tmpfile
mount -o loop -t ext3 $tmpfile $tmpdir
cat <<EOF > $tmpdir/cloudinit.sh
#!/bin/sh
nmcli c mod eth0 connection.autoconnect yes ipv4.method manual ipv4.addresses 192.168.1.1/24 ipv4.gateway 192.168.1.254
EOF
umount $tmpdir
rmdir $tmpdir
echo $tmpfile
