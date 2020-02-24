# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
    # - SSH Settings -------------------------------------------------------------
    #
    # This aims to resolve an issue with lack of TTY during provisioning runs.
    # See https://github.com/mitchellh/vagrant/issues/1673
    config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

    # - Vagrant Settings ---------------------------------------------------------
    config.vagrant.plugins = ['vagrant-vbguest']

    # - VirtualBox guest additions configuration ---------------------------------
    config.vbguest.auto_update = false

    # - Vagrant box --------------------------------------------------------------
    config.vm.box = "debian/contrib-buster64"

    # - Vagrant provisioning: puppet agent (enables puppet agent and apply runs) -
    config.vm.provision 'puppet-agent-setup', type: 'shell', path: './scripts/puppet-agent-setup.bash', args: 'debian_buster_64'
end
