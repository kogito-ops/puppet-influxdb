# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include influxdb::repo
class influxdb::repo (
  String $keyid = $::influxdb::params::keyid,
  String $keyid_source = $::influxdb::params::keyid_source,
  String $keyid_server = $::influxdb::params::keyid_server,
  String $package_manager = $::influxdb::params::package_manager,
  ){

  include ::apt

    case $package_manager {

    'apt': {
        apt::key {'influxdb':
            ensure => present,
            id     => $keyid,
            server => $keyid_server,
            source => $keyid_source,
        }

        apt::source{'influxdb':
            ensure       => present,
            comment      => 'InfluxData repository',
            location     => 'https://repos.influxdata.com/ubuntu',
            release      => $facts['os']['distro']['codename'],
            repos        => 'stable',
            include      => {
                src => false,
                deb => true,
                },
            architecture => 'amd64',
            key          => {
                id     => $keyid,
                }
            }
}
    default: {
      fail("${::hostname}: This module does not support osfamily ${::osfamily} ${::osname}")
    }
}

}
