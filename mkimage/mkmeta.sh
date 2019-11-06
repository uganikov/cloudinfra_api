#!/bin/sh

if [ ${EUID:-${UID}} = 0 ]; then
    echo 'this script needs root permission.'
fi

tmpdir=$(mktemp -d)
tmpfile=$(mktemp)

dd if=/dev/zero of=$tmpfile bs=1M count=5
mkfs.ext3 -F $tmpfile
mount -o loop -t ext3 $tmpfile $tmpdir

