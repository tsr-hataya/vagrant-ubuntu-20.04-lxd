# Ubuntu 20.04 で作る LXD コンテナ基盤

## 概要

Vagrant を使って Oracle MV VirtualBox に Ubuntu 20.04 をインストールして LXD コンテナ基盤を作ることができます。  


## 動作環境

* Windows 10 Pro 20H2

* Oracle VM VirtualBox 6.1.22

* Vagrant 2.2.15
  * vagrant-disksize

* Ubuntu 20.04 LTS(Focal Fossa)
  * snap版 LXD 4.0.5


## 使用条件

* Vagrant の Provider(バックエンドの仮想化ルーツ)は Oracle VM VirtualBox 6.1.x を使用しています。  
* VirtualBox のホストオンリーアダプターが必要です。  
* ホストオンリーアダプターのIPv6設定が無効化されている必要があります。  
* vagrant に vagrant-disksize プラグインがインストールされている必要があります。  


## 使い方

### 1) git clone をします。  

```
C:\Users\hataya> git clone https://github.com/tsr-hataya/vagrant-ubuntu-20.04-lxd.git
C:\Users\hataya> cd vagrant-ubuntu-20.04-lxd
C:\Users\hataya\vagrant-ubuntu-20.04-lxd> 
```


### 2) 必要に応じて Vagrantfile を修正してください。  

`config.vm.network` で指定するIPアドレスをホストオンリーアダプターに割り当てられているネットワーク設定に合わせて変更する。  

```
Vagrant.configure("2") do |config|
    :
  config.vm.network "private_network", ip: "192.168.56.11"
    :
end
```

そのほか、CPU、メモリ、ホスト名、VMが参照するDNSサーバーなどが変更可能です。


### 3) vagrant up します。  

```
C:\Users\hataya\vagrant-ubuntu-20.04-lxd> vagrant up
```


### 4) 作成された仮想マシンが再起動されたら出来上がりです。  


### 5) ログインします。  

```
C:\Users\hataya\vagrant-ubuntu-20.04-lxd> vagrant ssh
```


### 6) lxc コマンドでコンテナを作って遊んでください。  

作成したコンテナの eth0 は VirtualBox の NAT インターフェースに接続されます。  

作成したコンテナの eth1 は VirtualBox の ホストオンリーアダプターに接続されます。  
ネットワーク設定はないので、コンテナ作成後手動で割り当てる必要があります。


## 補足事項

* とくになし

## 作成者

* 畑屋
* TSR株式会社
* hataya@tsr-company.com


