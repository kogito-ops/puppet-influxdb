#!/usr/bin/env bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: nil; tab-width: 4 -*-

export DEBIAN_FRONTEND=noninteractive

breed=$1
lock_file=/var/tmp/puppet-setup.lock

apt_wait () {
	while sudo fuser /var/lib/dpkg/lock-frontend >/dev/null 2>&1 ; do
		sleep 1
	done
	while sudo fuser /var/lib/dpkg/lock >/dev/null 2>&1 ; do
		sleep 1
	done
	while sudo fuser /var/lib/apt/lists/lock >/dev/null 2>&1 ; do
		sleep 1
	done
	if [ -f /var/log/unattended-upgrades/unattended-upgrades.log ]; then
		while sudo fuser /var/log/unattended-upgrades/unattended-upgrades.log >/dev/null 2>&1 ; do
			sleep 1
		done
	fi
}

yum_wait () {
	while sudo fuser /var/run/yum.pid >/dev/null 2>&1 ; do
		sleep 1
	done
}

setup_ubuntu_trusty_64() {
	dist="trusty"
	echo "### Adding PuppetLabs repository"
	wget -q \
		https://apt.puppetlabs.com/puppet5-release-${dist}.deb \
		-O ${HOME}/puppet5-release-${dist}.deb
	apt_wait
	dpkg -i ${HOME}/puppet5-release-${dist}.deb >/dev/null 2>&1

	echo "### Updating repository cache"
	apt_wait
	apt-get update >/dev/null 2>&1

	echo "### Installing Puppet and its dependencies"
	apt_wait
	apt-get install -y apt-transport-https >/dev/null 2>&1
	apt_wait
	apt-get install -y puppet-agent >/dev/null 2>&1

	echo "### Stopping Puppet service"
	PATH=$PATH:/opt/puppetlabs/bin:/opt/puppetlabs/puppet/bin
	puppet resource service puppet ensure=stopped enable=false >/dev/null 2>&1

	echo "### Cleaning up"
	apt_wait
	apt-get autoremove -y --purge >/dev/null 2>&1

	echo "### Updating cache"
	apt_wait
	apt-get update >/dev/null 2>&1
}

setup_ubuntu_xenial_64() {
	dist="xenial"
	echo "### Adding PuppetLabs repository"
	wget -q \
		https://apt.puppetlabs.com/puppet5-release-${dist}.deb \
		-O ${HOME}/puppet5-release-${dist}.deb
	apt_wait
	dpkg -i ${HOME}/puppet5-release-${dist}.deb >/dev/null 2>&1

	echo "### Updating repository cache"
	apt_wait
	apt-get update >/dev/null 2>&1

	echo "### Installing Puppet and its dependencies"
	apt_wait
	apt-get install -y apt-transport-https >/dev/null 2>&1
	apt_wait
	apt-get install -y puppet-agent >/dev/null 2>&1

	echo "### Stopping Puppet service"
	PATH=$PATH:/opt/puppetlabs/bin:/opt/puppetlabs/puppet/bin
	puppet resource service puppet ensure=stopped enable=false >/dev/null 2>&1

	echo "### Cleaning up"
	apt_wait
	apt-get autoremove -y --purge >/dev/null 2>&1

	echo "### Updating cache"
	apt_wait
	apt-get update >/dev/null 2>&1
}

setup_ubuntu_bionic_64() {
	dist="bionic"
	echo "### Adding PuppetLabs repository"
	wget -q \
		https://apt.puppetlabs.com/puppet5-release-${dist}.deb \
		-O ${HOME}/puppet5-release-${dist}.deb
	apt_wait
	dpkg -i ${HOME}/puppet5-release-${dist}.deb >/dev/null 2>&1

	echo "### Updating repository cache"
	apt_wait
	apt-get update >/dev/null 2>&1

	echo "### Installing Puppet and its dependencies"
	apt_wait
	apt-get install -y apt-transport-https >/dev/null 2>&1
	apt_wait
	apt-get install -y puppet-agent >/dev/null 2>&1

	echo "### Stopping Puppet service"
	PATH=$PATH:/opt/puppetlabs/bin:/opt/puppetlabs/puppet/bin
	puppet resource service puppet ensure=stopped enable=false >/dev/null 2>&1

	echo "### Cleaning up"
	apt_wait
	apt-get autoremove -y --purge >/dev/null 2>&1

	echo "### Updating cache"
	apt_wait
	apt-get update >/dev/null 2>&1
}

setup_ubuntu_eoan_64() {
	dist="eoan"
	echo "### Updating repository cache"
	apt_wait
	apt-get update >/dev/null 2>&1

	echo "### Installing Puppet and its dependencies"
	apt_wait
	apt-get install -y apt-transport-https >/dev/null 2>&1
	apt_wait
	apt-get install -y puppet >/dev/null 2>&1

	echo "### Stopping Puppet service"
	PATH=$PATH:/opt/puppetlabs/bin:/opt/puppetlabs/puppet/bin
	puppet resource service puppet ensure=stopped enable=false >/dev/null 2>&1

	echo "### Cleaning up"
	apt_wait
	apt-get autoremove -y --purge >/dev/null 2>&1

	echo "### Updating cache"
	apt_wait
	apt-get update >/dev/null 2>&1
}

setup_debian_buster_64() {
	dist="buster"
	echo "### Adding PuppetLabs repository"
	wget -q \
		https://apt.puppetlabs.com/puppet5-release-${dist}.deb \
		-O ${HOME}/puppet5-release-${dist}.deb
	apt_wait
	dpkg -i ${HOME}/puppet5-release-${dist}.deb >/dev/null 2>&1

	echo "### Updating repository cache"
	apt_wait
	apt-get update >/dev/null 2>&1

	echo "### Installing Puppet and its dependencies"
	apt_wait
	apt-get install -y apt-transport-https >/dev/null 2>&1
	apt_wait
	apt-get install -y puppet-agent >/dev/null 2>&1

	echo "### Stopping Puppet service"
	PATH=$PATH:/opt/puppetlabs/bin:/opt/puppetlabs/puppet/bin
	puppet resource service puppet ensure=stopped enable=false >/dev/null 2>&1

	echo "### Cleaning up"
	apt_wait
	apt-get autoremove -y --purge >/dev/null 2>&1

	echo "### Updating cache"
	apt_wait
	apt-get update >/dev/null 2>&1
}

setup_centos_7_64 () {
	dist="el-7"
	echo "### Adding PuppetLabs repository"
	curl -fSL \
		https://yum.puppet.com/RPM-GPG-KEY-puppet \
		-o ${HOME}/RPM-GPG-KEY-puppet >/dev/null 2>&1
	yum_wait
	rpm --import ${HOME}/RPM-GPG-KEY-puppet >/dev/null 2>&1
	curl -fSL \
		https://yum.puppet.com/puppet5-release-${dist}.noarch.rpm \
		-o ${HOME}/puppet5-release-${dist}.noarch.rpm >/dev/null 2>&1
	yum_wait
	yum install -y ${HOME}/puppet5-release-${dist}.noarch.rpm >/dev/null 2>&1

	echo "### Updating repository cache"
	yum_wait
	yum check-update >/dev/null 2>&1

	echo "### Installing Puppet and its dependencies"
	yum_wait
	yum install -y puppet-agent >/dev/null 2>&1

	echo "### Stopping Puppet service"
	PATH=$PATH:/opt/puppetlabs/bin:/opt/puppetlabs/puppet/bin
	puppet resource service puppet ensure=stopped enable=false >/dev/null 2>&1

	echo "### Cleaning up"
	yum_wait
	yum clean all >/dev/null 2>&1
}

# Run setup only the first time
if [ -f $lock_file ]; then
	echo "## Skipped breeding Puppet agent installation for '${breed}'"
	echo "### Remove $lock_file to rerun the Puppet agent installation"
else
	echo "## Breeding '${breed}' Puppet agent installation"
	setup_$breed && touch $lock_file
fi
