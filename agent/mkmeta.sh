#!/bin/bash

if [ ${EUID:-${UID}} = 0 ]; then
    echo 'this script needs root permission.'
fi

network_addr=192.168.1.
host_addr=$1
shift
instance_id=$1
mask=24
shift
gw=254

tmpdir=$(mktemp -d)
tmpfile=$(mktemp)

dd if=/dev/zero of=$tmpfile bs=1M count=5
mkfs.ext3 -F $tmpfile
mount -o loop -t ext3 $tmpfile $tmpdir
cp ${instance_id}.pub $tmpdir
cat <<EOF > $tmpdir/cloudinit.sh
#!/bin/sh
nmcli c mod eth0 connection.autoconnect yes ipv4.method manual ipv4.addresses $network_addr$host_addr/$mask ipv4.gateway ${network_addr}1
nmcli c mod eth0 ipv4.dns 8.8.8.8
nmcli c down eth0; nmcli c up eth0
mkdir -p /home/cloudinfra/.ssh/
chown cloudinfra:cloudinfra /home/cloudinfra/.ssh/
chmod 700 /home/cloudinfra/.ssh/
cp /var/metadrive/${instance_id}.pub /home/cloudinfra/.ssh/authorized_keys
chown cloudinfra:cloudinfra /home/cloudinfra/.ssh/authorized_keys
chmod 400 /home/cloudinfra/.ssh/authorized_keys
EOF
umount $tmpdir
rmdir $tmpdir
chown cloudinfra:cloudinfra $tmpfile
mv $tmpfile ./${instance_id}.meta
echo ${instance_id}.meta
