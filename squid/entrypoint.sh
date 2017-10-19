#!/bin/bash
chown -R squid:squid /mnt/squid
chmod 0777 /mnt/sqiud

echo "Creating cache directories..."
squid -z

echo "Starting squid..."
squid -f /etc/squid/squid.conf -NYCd 1
