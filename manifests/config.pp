# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include influxdb::config
class influxdb::config (
  String $configuration_path = $::influxdb::configuration_path,
  String $configuration_file = $::influxdb::configuration_file,
  String $service_defaults = $::influxdb::service_defaults,
  String $service_definition = $::influxdb::service_definition,
  String $metadata_raft = $::influxdb::metadata_raft,
  String $tsm_data = $::influxdb::tsm_data,
  String $tsm_wal = $::influxdb::tsm_wal,
  String $user = $::influxdb::user,
  String $group = $::influxdb::group,
  String $package = $::influxdb::package,
  String $service_name = $::influxdb::service_name,
  String $service_provider = $::influxdb::service_provider,
  String $service_ensure = $::influxdb::service_ensure,
){
  file { $::influxdb::configuration_path:
    ensure => 'directory',
    owner  => $::influxdb::user,
    group  => $::influxdb::group,
    mode   => '0755',
  }

  -> file { "${::influxdb::configuration_path}/${::influxdb::configuration_file}":
    ensure  => 'present',
    owner   => $::influxdb::user,
    group   => $::influxdb::group,
    mode    => '0644',
    content => template('influxdb/influxdb.conf.erb')
  }

  -> file { $::influxdb::service_defaults:
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('influxdb/service-defaults.erb'),
  }

  -> file { $::influxdb::service_definition:
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('influxdb/systemd.service.erb'),
  }

  -> file { $::influxdb::tsm_data:
    ensure => 'directory',
    owner  => $::influxdb::user,
    group  => $::influxdb::group,
    mode   => '0755',
  }

  -> file { $::influxdb::tsm_wal:
    ensure => 'directory',
    owner  => $::influxdb::user,
    group  => $::influxdb::group,
    mode   => '0755',
  }

  -> file { $::influxdb::metadata_raft:
    ensure => 'directory',
    owner  => $::influxdb::user,
    group  => $::influxdb::group,
    mode   => '0755',
  }
}
