# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include influxdb::config
class influxdb::config (
  String $configuration_path = $::influxdb::params::configuration_path,
  String $configuration_file = $::influxdb::params::configuration_file,
  String $service_defaults = $::influxdb::params::service_defaults,
  String $service_definition = $::influxdb::params::service_definition,
  String $directory_metadataraft = $::influxdb::params::directory_metadataraft,
  String $directory_tsmdata = $::influxdb::params::directory_tsmdata,
  String $directory_tsmwal = $::influxdb::params::directory_tsmwal,
  String $user = $::influxdb::params::user,
  String $group = $::influxdb::params::group,
  String $package = $::influxdb::params::package,
  String $service_name = $::influxdb::params::service_name,
  String $service_provider = $::influxdb::params::service_provider,
  String $service_ensure = $::influxdb::params::service_ensure,
){
  file { $::influxdb::params::configuration_path:
    ensure => 'directory',
    owner  => $::influxdb::params::user,
    group  => $::influxdb::params::group,
  }

  -> file { "${::influxdb::params::configuration_path}/${::influxdb::params::configuration_file}":
    ensure  => 'present',
    owner   => $::influxdb::params::user,
    group   => $::influxdb::params::group,
    content => template('influxdb/influxdb.conf.erb')
  }

  -> file { $::influxdb::params::service_defaults:
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    content => template('influxdb/service-defaults.erb'),
  }

  -> file { $::influxdb::params::service_definition:
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    content => template('influxdb/systemd.service.erb'),
  }

  -> file { $::influxdb::params::directory_tsmdata:
    ensure => 'directory',
    owner  => $::influxdb::params::user,
    group  => $::influxdb::params::group,
  }

  -> file { $::influxdb::params::directory_tsmwal:
    ensure => 'directory',
    owner  => $::influxdb::params::user,
    group  => $::influxdb::params::group,
  }

  -> file { $::influxdb::params::directory_metadataraft:
    ensure => 'directory',
    owner  => $::influxdb::params::user,
    group  => $::influxdb::params::group,
  }
}
