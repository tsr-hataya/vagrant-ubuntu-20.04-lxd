#!/bin/bash

echo "Start initial setup of LXD"

# vagrantユーザーをlxdグループに追加
echo "gpasswd --add vagrant lxd"
gpasswd --add vagrant lxd

# lxd init 実行
echo "lxd init --preseed < /vagrant.conf/lxd_init.yml"
lxd init --preseed < /vagrant.conf/lxd_init.yml

echo "The initial setup of LXD is complete."