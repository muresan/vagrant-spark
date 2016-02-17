# -*- mode: ruby -*-
# vi: set ft=ruby :
#TODO
#puppet libraryan
#puppet vagrant installer
Vagrant.configure(2) do |config|

  config.ssh.pty = true

  hosts = {
    'sparkm' => { 'ip' => '192.168.124.101', 'cpus' => 1, 'memory' => 1024, 'autostart' => false },
    'spark1' => { 'ip' => '192.168.124.201', 'cpus' => 1, 'memory' => 1024, 'autostart' => true },
    'spark2' => { 'ip' => '192.168.124.202', 'cpus' => 1, 'memory' => 1024, 'autostart' => false },
    'spark3' => { 'ip' => '192.168.124.203', 'cpus' => 1, 'memory' => 1024, 'autostart' => false },

    'jenkins' => { 'ip' => '192.168.124.150', 'cpus' => 1, 'memory' => 1024, 'autostart' => true },

  }

  hosts.each do |host, params|
    config.vm.define host, autostart: params['autostart'] do |host_config|
      host_config.vm.box = "dliappis/centos65minlibvirt"
      host_config.vm.hostname = "#{host}"
      host_config.vm.network :private_network, ip: params['ip']
      
      host_config.vm.provider :libvirt do |libvirt|
        libvirt.driver = 'kvm'
        libvirt.management_network_name = 'private_network'
        libvirt.management_network_address = '192.168.124.0/24'
        libvirt.memory = params['memory']
        libvirt.cpus = params['cpus']
      end
	  
      host_config.vm.provision :shell, inline: <<-SHELL
        sudo yum -y vim-enhanced
        sudo chkconfig iptables off
        sudo service iptables stop
        sudo rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
        sudo yum -y install puppet
      SHELL

      host_config.vm.provision :puppet do |puppet|
        puppet.module_path = "modules"
        puppet.manifests_path = "manifests"
        puppet.manifest_file = "default.pp"
      end
    end
  end
end
