# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include influxdb::config
class influxdb::config{

  file { $::influxdb::configuration_path:
    ensure => $::influxdb::configuration_path_manage,
    owner  => $::influxdb::user,
    group  => $::influxdb::group,
    mode   => '0755',
  }

  -> file { "${::influxdb::configuration_path}/${::influxdb::configuration_file}":
    ensure  => $::influxdb::configuration_file_manage,
    owner   => $::influxdb::user,
    group   => $::influxdb::group,
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
    ensure => $::influxdb::metadata_raft,
    owner  => $::influxdb::user,
    group  => $::influxdb::group,
    mode   => '0755',
  }

}
