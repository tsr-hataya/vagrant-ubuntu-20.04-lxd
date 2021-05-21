#!/bin/bash

echo ""
echo "==>>"
echo "==>> [SETUP2] Initial setup of LXD."
echo "==>>"
echo ""

# ----- [TASK1] -----
echo "==> [TASK1] Install some packages."
apt install -y bridge-utils
echo ""


# ----- [TASK2] -----
echo "==> [TASK2] Add a bridge interface."

# 変数をセット

NIC0=`ip address show | grep "inet 10." |  awk '{print $8}'`
echo "NIC0=${NIC0}"

NIC1=`ip address show | grep "inet 192.168.56." |  awk '{print $7}'`
echo "NIC1=${NIC1}"

IPADDR1=`ip address show | grep "inet 192.168.56." |  awk '{print $2}'`
echo "IPADDR1=${IPADDR1}"

mv /etc/netplan/50-cloud-init.yaml /etc/netplan/50-cloud-init.yaml-`date '+%Y%m%d-%H%M%S'`
mv /etc/netplan/50-vagrant.yaml /etc/netplan/50-vagrant.yaml-`date '+%Y%m%d-%H%M%S'`
cp /vagrant.conf.d/50-lxdbr0.yaml /etc/netplan/50-lxdbr0.yaml
sed -i "s|==NIC0==|${NIC0}|g" /etc/netplan/50-lxdbr0.yaml
cp /vagrant.conf.d/50-lxdbr1.yaml /etc/netplan/50-lxdbr1.yaml
sed -i "s|==NIC1==|${NIC1}|g" /etc/netplan/50-lxdbr1.yaml
sed -i "s|==IPADDR1==|${IPADDR1}|g" /etc/netplan/50-lxdbr1.yaml
netplan apply
echo ""


# ----- [TASK3] -----
echo "==> [TASK3] Start initial setup of LXD."

# vagrantユーザーをlxdグループに追加
echo "gpasswd --add vagrant lxd"
gpasswd --add vagrant lxd

# lxd init 実行
echo "lxd init --preseed < /vagrant.conf.d/lxd-init.yml"
lxd init --preseed < /vagrant.conf.d/lxd-init.yml

echo ""
