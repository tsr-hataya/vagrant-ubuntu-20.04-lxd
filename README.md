# Ubuntu 20.04 LXD ホスト

## 概要

Vagrant を使って Oracle MV VirtualBox に Ubuntu 20.04 をインストールして LXD/LXC をセットアップしてコンテナ基盤を作る。  


## 使用条件

* vagrant-disksize プラグインがインストールされているころ  
* Provider(バックエンドの仮想化ルーツ)は Oracle VM VirtualBox 6.1.x を使用  
* ホストオンリーアダプターが必要  
* ホストオンリーアダプターのIPv6設定が無効化されていること  


## 使い方

### 1) git pull する  


### 2) Vagrantfile を修正する  

`Vagrantfile` の `config.vm.network` で指定するIPアドレスをホストオンリーアダプターに割り当てられているネットワーク設定に合わせて変更する。  

```
Vagrant.configure("2") do |config|
    :
  config.vm.network "private_network", ip: "192.168.56.11"
    :
end
```

### 3) vagrant up する  

```
vagrant up
```

### 4) 作成された仮想マシンが再起動されたら出来上がり。  

### 5) ログインする  

```
vagrant ssh
```

または、`Vagrantfile` の `config.vm.network` で指定したホストオンリーアダプターのIPアドレスに TeraTerm などから SSH で接続する。  

### 6) lxc コマンドでコンテナを作って遊ぶ。  



## 補足事項


## 作成者

* 畑屋
* TSR株式会社
* hataya@tsr-company.com


