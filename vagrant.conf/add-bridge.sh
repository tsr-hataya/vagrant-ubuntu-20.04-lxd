#!/bin/bash

echo "Add a bridge interface."

# 変数をセット
BRIDGE1="lxdbr1"
echo "BRIDGE1=${BRIDGE1}"

NIC1=`ip address show | grep "inet 192.168.56." |  awk '{print $7}'`
echo "NIC1=${NIC1}"

IPADDR1=`ip address show | grep "inet 192.168.56." |  awk '{print $2}'`
echo "IPADDR1=${IPADDR1}"

# ブリッジインターフェース追加
echo "brctl addbr ${BRIDGE1}"
brctl addbr ${BRIDGE1}

# ブリッジインターフェースのSTPをOFF
echo "brctl stp ${BRIDGE1} off"
brctl stp ${BRIDGE1} off

# ブリッジインターフェースにIPアドレスを割当て
echo "ip address add ${IPADDR1} dev ${BRIDGE1}"
ip address add ${IPADDR1} dev ${BRIDGE1}

# ブリッジインターフェースに物理インターフェースを割当て
echo "brctl addif ${BRIDGE1} ${NIC1}"
brctl addif ${BRIDGE1} ${NIC1}

# 物理インターフェースのIPアドレスを削除
echo "ip address flush dev ${NIC1}"
ip address flush dev ${NIC1}

# 物理インターフェースのプロミスキャスモードをON
echo "ip link set dev ${NIC1} promisc on"
ip link set dev ${NIC1} promisc on

# 物理インターフェース UP
echo "ip link set dev ${NIC1} up"
ip link set dev ${NIC1} up

# ブリッジインターフェース UP
echo "ip link set dev ${BRIDGE1} up"
ip link set dev ${BRIDGE1} up


echo "The bridge interface has been added."


