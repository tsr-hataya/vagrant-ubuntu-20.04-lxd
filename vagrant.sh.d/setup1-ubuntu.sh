#!/bin/bash

echo ""
echo "==>>"
echo "==>> [SETUP1] Initial setup of Ubuntu 20.04."
echo "==>>"
echo ""

# ----- [TASK1] -----
echo "==> [TASK1] Set the dns servers."
sed -i.`date '+%Y%m%d-%H%M%S'` 's|#DNS=|DNS=8.8.8.8 8.8.4.4|' /etc/systemd/resolved.conf
systemctl restart systemd-resolved
echo ""

# ----- [TASK2] -----
echo "==> [TASK2] Modify sources.list."
wget -q https://www.ubuntulinux.jp/ubuntu-ja-archive-keyring.gpg -O- | sudo apt-key add -
wget -q https://www.ubuntulinux.jp/ubuntu-jp-ppa-keyring.gpg -O- | sudo apt-key add -
wget -q https://www.ubuntulinux.jp/sources.list.d/focal.list -O /etc/apt/sources.list.d/ubuntu-focal_ja.list
echo ""

# ----- [TASK3] -----
echo "==> [TASK3] System update."
apt update
apt full-upgrade -y
echo ""

# ----- [TASK4] -----
echo "==> [TASK4] Install some packages."
apt install -y dnsutils tree zip unzip
echo ""

# ----- [TASK5] -----
echo "==> [TASK5] Disable ipv6."
sed -i.`date '+%Y%m%d-%H%M%S'` 's|GRUB_CMDLINE_LINUX=""|GRUB_CMDLINE_LINUX="ipv6.disable=1"|' /etc/default/grub
update-grub
echo ""

# ----- [TASK6] -----
echo "==> [TASK6] Dsable systemd-networkd-wait-online.service."
systemctl disable systemd-networkd-wait-online.service
systemctl mask systemd-networkd-wait-online.service
echo ""

# ----- [TASK7] -----
echo "==> [TASK7] Set up some NTP servers."
sed -i.`date '+%Y%m%d-%H%M%S'` 's|#NTP=|NTP=ntp.nict.jp ntp.jst.mfeed.ad.jp|' /etc/systemd/timesyncd.conf
systemctl restart systemd-timesyncd
echo ""

# ----- [TASK8] -----
echo "==> [TASK8] Set the time zone."
timedatectl set-timezone Asia/Tokyo
echo ""

# ----- [TASK9] -----
echo "==> [TASK9] Set the locale."
apt install -y language-pack-ja-base language-pack-ja
update-locale LANG=ja_JP.UTF-8
cat /vagrant.conf.d/set-locale >> /etc/bash.bashrc
echo ""

# ----- [TASK10] -----
echo "==> [TASK10] Set the default editor."
update-alternatives --set editor /usr/bin/vim.basic
echo ""


