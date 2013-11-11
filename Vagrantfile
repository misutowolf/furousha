# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|

  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"

  config.vm.graceful_halt_timeout = 60

  # Set Hostname!
  config.vm.hostname = "furousha"

  # Default login
  config.ssh.username = "vagrant"

  # Port forwarding for Rails development server ('rails s'), LiveReload, and MailCatcher (SMTP Mocking!)
  config.vm.network :forwarded_port, guest: 3000, host: 3000
  config.vm.network :forwarded_port, guest: 1025, host: 1025
  config.vm.network :forwarded_port, guest: 35729, host: 35729

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.module_path = "puppet/modules"
  end

  # This is for debugging
  #config.vm.provider "virtualbox" do |v|
  #  v.gui = true
  #end

end