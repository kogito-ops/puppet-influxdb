# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include influxdb::install
class influxdb::install {
  package { $::influxdb::package:
    ensure => present
  }

  -> group { $::influxdb::group:
      ensure => present,
      system => true,
  }

  -> user { $::influxdb::user:
      ensure     => present,
      gid        => $::influxdb::group,
      home       => "/home/${::influxdb::user}",
      managehome => true,
      system     => true,
      require    => Group[$::influxdb::group],
    }
}
