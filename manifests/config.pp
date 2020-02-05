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

  -> file { '/var/lib/influxdb':
    ensure => 'directory',
    owner  => 'influxdb',
    group  => 'influxdb',
  }

  -> file { '/var/lib/influxdb/data':
    ensure => 'directory',
    owner  => 'influxdb',
    group  => 'influxdb',
  }

  -> file { '/var/lib/influxdb/meta':
    ensure => 'directory',
    owner  => 'influxdb',
    group  => 'influxdb',
  }

  -> file { '/var/lib/influxdb/wal':
    ensure => 'directory',
    owner  => 'influxdb',
    group  => 'influxdb',
  }
}
