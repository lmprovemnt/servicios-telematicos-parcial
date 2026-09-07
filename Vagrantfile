Vagrant.configure("2") do |config|

  config.vm.box = "bento/ubuntu-24.04"
  config.vm.box_architecture = "arm64"


  config.vm.define "dns-master" do |master|
    master.vm.hostname = "maestro.empresa.local"
    master.vm.network "private_network",
      ip: "192.168.50.2"

    master.vm.provider "virtualbox" do |vb|
      vb.name = "DNS-Master"
      vb.memory = 1024
      vb.cpus = 1
    end
  end

  config.vm.define "dns-slave" do |slave|
    slave.vm.hostname = "esclavo.empresa.local"
    slave.vm.network "private_network",
      ip: "192.168.50.3"

    slave.vm.provider "virtualbox" do |vb|
      vb.name = "DNS-Slave"
      vb.memory = 1024
      vb.cpus = 1
    end
  end

  config.vm.define "web" do |web|
    web.vm.hostname = "web.empresa.local"
    web.vm.network "private_network",
      ip: "192.168.50.10"

    web.vm.provider "virtualbox" do |vb|
      vb.name = "Web-Server"
      vb.memory = 2048
      vb.cpus = 2
    end
  end

  config.vm.define "client" do |client|
    client.vm.hostname = "cliente.empresa.local"
    client.vm.network "private_network",
      ip: "192.168.50.20"

    client.vm.provider "virtualbox" do |vb|
      vb.name = "DNS-Client"
      vb.memory = 1024
      vb.cpus = 1
    end
  end

end
