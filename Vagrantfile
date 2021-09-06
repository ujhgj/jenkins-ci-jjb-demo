# -*- mode: ruby -*-
# vi: set ft=ruby :

MACHINES = {
  :master => {
    :box => "debian/bullseye64",
    :ip_addr => "192.168.50.100",
    :memory => "1024"
  },
  :slave1 => {
    :box => "debian/bullseye64",
    :ip_addr => "192.168.50.101",
    :memory => "1024"
  },
  :slave2 => {
    :box => "windows-server",
    :box_url => "https://app.vagrantup.com/gusztavvargadr/boxes/windows-server/versions/1809.0.2108/providers/virtualbox.box",
    :ip_addr => "192.168.50.102",
    :memory => "1024"
  }
}

Vagrant.configure("2") do |config|
  MACHINES.each do |boxname, boxconfig|
    config.vm.define boxname do |box|
      box.vm.box = boxconfig[:box]
      if (boxconfig.has_key?(:box_url))
        box.vm.box_url = boxconfig[:box_url]
      end
      box.vm.host_name = boxname.to_s
      box.vm.network "private_network", ip: boxconfig[:ip_addr], virtualbox__intnet: true
      box.vm.provider "virtualbox" do |vb|
        vb.customize ["modifyvm", :id, "--memory", boxconfig[:memory]]
      end
    end
  end
end
