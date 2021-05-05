Vagrant.configure("2") do |config|
  
  config.vm.box = "ubuntu/focal64"
  config.vm.network "private_network", ip: "192.168.56.11"
  config.vm.hostname = "ubuntu-lxd"
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder "./vagrant.sh.d", "/vagrant.sh.d", create: true
  config.vm.synced_folder "./vagrant.conf.d", "/vagrant.conf.d", create: true
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
  
  config.vm.provision :shell, :path => "./vagrant.sh.d/setup1-ubuntu.sh"
  config.vm.provision :shell, :path => "./vagrant.sh.d/setup2-lxd.sh"
  config.vm.provision :shell, :path => "./vagrant.sh.d/setup3-reboot.sh"

end