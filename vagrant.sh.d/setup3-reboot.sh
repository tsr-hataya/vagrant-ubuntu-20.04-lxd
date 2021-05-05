#!/bin/bash

echo ""
echo "==>>"
echo "==>> [SETUP3] Setup is complete."
echo "==>>"
echo ""

# ----- [Final TASK] -----
echo "==> [Final TASK] Setup is complete."
echo "Clearing the cache."
apt autoremove -y
apt autoclean
apt clean
snap refresh
echo ""
echo "The setup process is complete."
echo ""
echo "Reboot the server. Please wait for a little while."
echo ""
shutdown -r now


