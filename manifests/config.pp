# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include influxdb::config
class influxdb::config {
  file { '/etc/influxdb':
    ensure => 'directory',
    owner  => 'influxdb',
    group  => 'influxdb',
  }

  -> file { '/etc/influxdb/influxdb.conf':
    ensure  => 'present',
    owner   => 'influxdb',
    group   => 'influxdb',
    content => template('influxdb/influxdb.conf.erb')
  }

  -> file { '/etc/default/influxdb':
    ensure  => 'present',
    owner   => 'influxdb',
    group   => 'influxdb',
    content => template('influxdb/service-defaults.erb'),
  }

  -> file { '/lib/systemd/system/influxdb.service':
    ensure  => 'present',
    owner   => 'influxdb',
    group   => 'influxdb',
    content => template('influxdb/systemd.service.erb'),
  }

  -> file { $::influxdb::params::directory_tsmdata:
    ensure => 'directory',
    owner  => 'influxdb',
    group  => 'influxdb',
  }

  -> file { $::influxdb::params::directory_tsmwal:
    ensure => 'directory',
    owner  => 'influxdb',
    group  => 'influxdb',
  }

  -> file { $::influxdb::params::directory_metadataraft:
    ensure => 'directory',
    owner  => 'influxdb',
    group  => 'influxdb',
  }
}
