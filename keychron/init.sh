#!/bin/bash

set -euo pipefail

rules_file="/etc/udev/rules.d/99-keychron.rules"
user_group=$(id -gn)

sudo tee "$rules_file" > /dev/null << 'EOF'
EOF

while IFS= read -r line; do
  ids=$(echo "$line" | awk '{print $6}')
  manufacturer=$(echo "$ids" | awk -F: '{print $1}')
  product_id=$(echo "$ids" | awk -F: '{print $2}')

  echo "Manufacturer: $manufacturer, Product ID: $product_id"

  echo "KERNEL==\"hidraw*\", SUBSYSTEM==\"hidraw\", ATTRS{idVendor}==\"$manufacturer\", ATTRS{idProduct}==\"$product_id\", MODE=\"0660\", GROUP=\"$user_group\", TAG+=\"uaccess\", TAG+=\"udev-acl\"" | sudo tee -a "$rules_file" > /dev/null
done < <(lsusb | grep Keychron)

echo "Written rules to $rules_file"

sudo udevadm control --reload-rules
sudo udevadm trigger
