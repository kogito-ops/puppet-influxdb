# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include influxdb::repo
class influxdb::repo (
  String $key_id = $::influxdb::key_id,
  String $key_source = $::influxdb::key_source,
  String $key_server = $::influxdb::key_server,
  String $package_manager = $::influxdb::package_manager,
  ){

  include ::apt

    case $package_manager {

        'apt': {

            apt::key {'influxdb':
                ensure => present,
                id     => $key_id,
                server => $key_server,
                source => $key_source,
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
                    id     => $key_id,
                    }
            }
        }

        default: {
        fail("${::hostname}: This module does not support osfamily ${::osfamily}}")
        }
    }
}
