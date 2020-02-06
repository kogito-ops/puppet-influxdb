# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include influxdb::install
class influxdb::install {
  package { $::influxdb::params::package:
    ensure => present
  }

  -> group { $::influxdb::params::group:
      ensure => present,
      system => true,
  }

  -> user { $::influxdb::params::user:
      ensure     => present,
      gid        => $::influxdb::params::group,
      home       => "/home/${::influxdb::params::user}",
      managehome => true,
      system     => true,
      require    => Group[$::influxdb::params::group],
    }
}
