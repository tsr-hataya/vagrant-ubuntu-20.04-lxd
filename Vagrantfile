Vagrant.configure("2") do |config|
  
  config.vm.box = "ubuntu/focal64"
  config.vm.network "private_network", ip: "192.168.56.11"
  config.vm.hostname = "ubuntu"
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder "./vagrant.conf", "/vagrant.conf", create: true
  config.disksize.size = "40GB"
  
  config.vm.provider "virtualbox" do |vb|
    vb.name = "ubuntu-20.04-lxd"
    vb.gui = true
    vb.cpus = 2
    vb.memory = "1024"
    vb.customize [
        "modifyvm", :id,
        "--graphicscontroller", "VMSVGA",
        "--audio", "none",
        "--uart1", "off",
        "--uart2", "off",
        "--uart3", "off",
        "--uart4", "off",
        "--usb", "off",
        "--nicpromisc2", "allow-all"
    ]
  end
  
  config.vm.provision "shell", inline: <<-SHELL
    # set dns server
    echo "--------------------"
    echo "set dns server"
    echo "--------------------"
    sed -i.`date '+%Y%m%d-%H%M%S'` 's/#DNS=/DNS=8.8.8.8 8.8.8.4/' /etc/systemd/resolved.conf
    systemctl restart systemd-resolved
    echo ""
    echo "complete."
    echo ""
    
    # modify sources.list
    echo "--------------------"
    echo "modify sources.list"
    echo "--------------------"
    sed -i.`date '+%Y%m%d-%H%M%S'` -e 's/archive.ubuntu.com/jp.archive.ubuntu.com/g' /etc/apt/sources.list
    echo "complete."
    
    # update
    echo "--------------------"
    echo "system update"
    echo "--------------------"
    apt update
    apt upgrade -y
    apt autoremove -y
    snap refresh
    echo "complete."
    
    # install packages
    echo "--------------------"
    echo "install packages"
    echo "--------------------"
    apt install -y bridge-utils curl dnsutils lsb-release lsof  man tree zip unzip
    echo "complete."
    
    # disable ipv6
    echo "--------------------"
    echo "disable ipv6"
    echo "--------------------"
    sed -i.`date '+%Y%m%d-%H%M%S'` 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="ipv6.disable=1"/' /etc/default/grub
    update-grub
    echo "complete."
    
    # disable systemd-networkd-wait-online.service
    echo "--------------------"
    echo "disable systemd-networkd-wait-online.service"
    echo "--------------------"
    systemctl disable systemd-networkd-wait-online.service
    systemctl mask systemd-networkd-wait-online.service
    echo "complete."
    
    # set ntp server
    echo "--------------------"
    echo "set ntp server"
    echo "--------------------"
    sed -i.`date '+%Y%m%d-%H%M%S'` 's/#NTP=/NTP=ntp.nict.jp ntp.jst.mfeed.ad.jp/' /etc/systemd/timesyncd.conf
    systemctl restart systemd-timesyncd
    echo "complete."
    
    # set timezone
    echo "--------------------"
    echo "set timezone"
    echo "--------------------"
    unlink /etc/localtime && ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
    echo "complete."
    
    # set locale
    echo "--------------------"
    echo "set locale"
    echo "--------------------"
    apt install -y language-pack-ja
    update-locale LANG=ja_JP.UTF-8
    echo "" >> /etc/bash.bashrc
    echo "# set locale" >> /etc/bash.bashrc
    echo "if [ -f /etc/default/locale ]; then" >> /etc/bash.bashrc
    echo "    . /etc/default/locale" >> /etc/bash.bashrc
    echo "fi" >> /etc/bash.bashrc
    echo "complete."
    
    # set default editor
    echo "--------------------"
    echo "set default editor"
    echo "--------------------"
    update-alternatives --set editor /usr/bin/vim.basic
    echo "complete."
    
    # setup lxd
    echo "--------------------"
    echo "setup lxd"
    echo "--------------------"
    /bin/bash /vagrant.conf/add-bridge.sh
    cp /vagrant.conf/add-bridge.sh /etc/rc.local
    chmod 700 /etc/rc.local
    /bin/bash /vagrant.conf/lxd-setup.sh
    echo "complete."
    
    # reboot
    echo "--------------------"
    echo "reboot"
    echo "--------------------"
    echo "The setup process is complete."
    echo "Reboot the server. Please wait for a little while."
    echo ""
    shutdown -r now
    
  SHELL

end