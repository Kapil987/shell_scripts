# -*- mode: ruby -*-
# vi: set ft=ruby :

# Once passwordless authentication is setup using remoteLogin_copy_ssh_key.sh disable root login as below and restart the sshd service, This will disable direct root login
# 1. sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
# 2. systemctl restart sshd.service
# https://www.vagrantup.com/docs/provisioning/shell

## You can add your normal Linux script commands here, vagrant root pass is default
$script = <<-SCRIPT
echo Packages are beign installed...
yum install -y vim
echo -n "** \nDirect Root login is enabled Make sure to disable is later \n**"
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
systemctl restart sshd.service
temp_user=ansibledb
useradd $temp_user
#temp_pass=your_pass
echo 'dGRjCg==' | base64 --decode | passwd --stdin $temp_user
# #date > /etc/vagrant_provisioned_at
SCRIPT
## Number of servers to be provision and there configuration as an array
servers=[
  {
    :hostname => "mysql-db1",
    :ip => "192.168.1.50",
    :box => "centos/8",
    :ram => 512,
    :cpu => 2
  },
  {
    :hostname => "mysql-db2",
    :ip => "192.168.1.51",
    :box => "centos/8",
    :ram => 512,
    :cpu => 2
  }
]

## Looped configuration
Vagrant.configure(2) do |config|
  config.vm.provision "shell", inline: $script
  servers.each do |machine|
      config.vm.define machine[:hostname] do |node|
          node.vm.box = machine[:box]
          node.vm.hostname = machine[:hostname]
          node.vm.network "public_network", ip: machine[:ip]
          node.vm.provider "virtualbox" do |vb|
              vb.customize ["modifyvm", :id, "--memory", machine[:ram]]
          end
      end
  end
end


# config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
#  node.vm.provision "shell",
#      inline: "echo hello from node #{i}"
#Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  #config.vm.box = "centos/8"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  #config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  #config.vm.provision 'shell', inline: 'echo "vagrant:a" | chpasswd'
  # sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config    
  # systemctl restart sshd.service
  # SHELL
#end


# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
