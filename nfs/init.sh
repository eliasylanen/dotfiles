#!/bin/bash

set -euo pipefail

MOUNT="192.168.1.234:/ /mnt/moekki nfs4 defaults 0 0"

if ! grep -qF "$MOUNT" /etc/fstab; then
		echo "Adding NFS mount to /etc/fstab"
		echo "$MOUNT" | sudo tee -a /etc/fstab > /dev/null
		mount -a
else
		echo "NFS mount already exists in /etc/fstab"
fi
