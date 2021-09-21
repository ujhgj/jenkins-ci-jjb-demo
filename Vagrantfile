# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'
settings = YAML.load_file 'settings.yaml'

MACHINES = {
  :master => {
    :box => "debian/buster64",
    :ip_addr => "192.168.50.100",
    :memory => 1024,
    :cpus => 1,
    :forwarded_ports => {
      "8080" => "8080"
    },
  },
  :slave1 => {
    :box => "debian/buster64",
    :ip_addr => "192.168.50.101",
    :memory => 512,
    :cpus => 1,
  },
  :slave2 => {
    :box => "Windows-Server-2019-Standard",
    :box_url => "https://app.vagrantup.com/gusztavvargadr/boxes/windows-server/versions/1809.0.2108/providers/virtualbox.box",
    :ip_addr => "192.168.50.102",
    :memory => 512,
    :cpus => 1,
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

      if (boxconfig.has_key?(:forwarded_ports))
        boxconfig[:forwarded_ports].each do |host_port, guest_port|
          box.vm.network "forwarded_port", guest: guest_port, host: host_port
        end
      end

      box.vm.network "private_network", ip: boxconfig[:ip_addr], virtualbox__intnet: true

      box.vm.provider "virtualbox" do |v|
        v.memory = boxconfig[:memory]
        v.cpus = boxconfig[:cpus]
      end

    end
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "ansible/provision-playbook.yml"
    ansible.host_vars = {
          "master" => {
              "user_git_public_key" => settings['user_git_public_key'],
              "jenkins_admin_password_file" => "/vagrant/initialAdminPassword",
            }
        }
  end
end
