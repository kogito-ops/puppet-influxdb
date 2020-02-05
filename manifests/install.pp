# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include influxdb::install
class influxdb::install {
  package { 'influxdb':
    ensure => present
  }

  -> group { 'influxdb':
      ensure => present,
      system => true,
  }

  -> user { 'influxdb':
      ensure     => present,
      gid        => 'influxdb',
      home       => '/home/influxdb',
      managehome => true,
      system     => true,
      require    => Group['influxdb'],
    }
}
