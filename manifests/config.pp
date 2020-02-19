# @summary This class creates directories and files; configuration and service
#
# @example
#   include influxdb::config
class influxdb::config(
  String $metadata_raft = $::influxdb::metadata_raft,
  String $tsm_data = $::influxdb::tsm_data,
  String $tsm_wal = $::influxdb::tsm_wal,
  String $user = $::influxdb::user,
  String $group = $::influxdb::group,
  String $service_defaults = $::influxdb::service_defaults,
  String $configuration_path = $::influxdb::configuration_path,
  String $configuration_file = $::influxdb::configuration_file,

  String $service_name = $::influxdb::service_name,
  String $service_provider = $::influxdb::service_provider,
  String $service_definition = $::influxdb::service_definition,
){

  file { $::influxdb::configuration_path:
    ensure => $::influxdb::configuration_path_manage,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  -> file { "${::influxdb::configuration_path}/${::influxdb::configuration_file}":
    ensure  => $::influxdb::configuration_file_manage,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($::influxdb::configuration_template)
  }

  -> file { $::influxdb::service_defaults:
    ensure  => $::influxdb::service_defaults_manage,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($::influxdb::service_default_template),
  }

  -> file { $::influxdb::service_definition:
    ensure  => $::influxdb::service_definition_manage,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($::influxdb::service_definition_template),
  }

  -> file { $::influxdb::tsm_data:
    ensure => $::influxdb::tsm_data_manage,
    owner  => $::influxdb::user,
    group  => $::influxdb::group,
    mode   => '0755',
  }

  -> file { $::influxdb::tsm_wal:
    ensure => $::influxdb::tsm_wal_manage,
    owner  => $::influxdb::user,
    group  => $::influxdb::group,
    mode   => '0755',
  }

  -> file { $::influxdb::metadata_raft:
    ensure => $::influxdb::metadata_raft_manage,
    owner  => $::influxdb::user,
    group  => $::influxdb::group,
    mode   => '0755',
  }

}
