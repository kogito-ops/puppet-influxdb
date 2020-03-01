# @summary Manages directories and files; configuration and service
#
# @example
#   include influxdb::config
class influxdb::config (
  String $configuration_path = $influxdb::configuration_path,
  Enum['directory', 'absent'] $configuration_path_manage = $influxdb::configuration_path_manage,
  String $configuration_file = $influxdb::configuration_file,
  Enum['present', 'absent'] $configuration_file_manage = $influxdb::configuration_file_manage,
  String $configuration_template= $influxdb::configuration_template,
  String $service_defaults = $influxdb::service_defaults,
  Enum['present', 'absent'] $service_defaults_manage = $influxdb::service_defaults_manage,
  String $service_default_template = $influxdb::service_default_template,
  String $service_definition = $influxdb::service_definition,
  Enum['present', 'absent'] $service_definition_manage = $influxdb::service_definition_manage,
  String $service_definition_template = $influxdb::service_definition_template,
  String $tsm_data = $influxdb::tsm_data,
  Enum['directory', 'absent'] $tsm_data_manage = $influxdb::tsm_data_manage,
  String $tsm_wal = $influxdb::tsm_wal,
  Enum['directory', 'absent'] $tsm_wal_manage = $influxdb::tsm_wal_manage,
  String $metadata_raft = $influxdb::metadata_raft,
  Enum['directory', 'absent'] $metadata_raft_manage = $influxdb::metadata_raft_manage,
  String $group = $influxdb::group,
  String $user = $influxdb::user,
){

  file { $configuration_path:
    ensure => $configuration_path_manage,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  -> concat { "${configuration_path}/${configuration_file}":
    owner => 'root',
    group => 'root',
    mode  => '0644'
  }

  -> concat::fragment { 'influxdb_header':
    target  => "${configuration_path}/${configuration_file}",
    content => template($configuration_template),
    order   => '01'
  }

  -> concat::fragment { 'influxdb_meta':
    target  => "${configuration_path}/${configuration_file}",
    content => template('influxdb/influxdb.conf/meta.conf.erb'),
    order   => '02'
  }

  -> concat::fragment { 'influxdb_data':
    target  => "${configuration_path}/${configuration_file}",
    content => template('influxdb/influxdb.conf/data.conf.erb'),
    order   => '03'
  }

  -> concat::fragment { 'influxdb_coordinator':
    target  => "${configuration_path}/${configuration_file}",
    content => template('influxdb/influxdb.conf/coordinator.conf.erb'),
    order   => '04'
  }

  -> concat::fragment { 'influxdb_retention':
    target  => "${configuration_path}/${configuration_file}",
    content => template('influxdb/influxdb.conf/retention.conf.erb'),
    order   => '05'
  }

  -> concat::fragment { 'influxdb_shard-precreation':
    target  => "${configuration_path}/${configuration_file}",
    content => template('influxdb/influxdb.conf/shard-precreation.conf.erb'),
    order   => '06'
  }

  -> concat::fragment { 'influxdb_monitor':
    target  => "${configuration_path}/${configuration_file}",
    content => template('influxdb/influxdb.conf/monitor.conf.erb'),
    order   => '07'
  }

  -> concat::fragment { 'influxdb_http':
    target  => "${configuration_path}/${configuration_file}",
    content => template('influxdb/influxdb.conf/http.conf.erb'),
    order   => '08'
  }

  -> concat::fragment { 'influxdb_logging':
    target  => "${configuration_path}/${configuration_file}",
    content => template('influxdb/influxdb.conf/logging.conf.erb'),
    order   => '09'
  }

  -> concat::fragment { 'influxdb_subscriber':
    target  => "${configuration_path}/${configuration_file}",
    content => template('influxdb/influxdb.conf/subscriber.conf.erb'),
    order   => '10'
  }

  -> concat::fragment { 'influxdb_graphite':
    target  => "${configuration_path}/${configuration_file}",
    content => template('influxdb/influxdb.conf/graphite.conf.erb'),
    order   => '11'
  }

  -> concat::fragment { 'influxdb_collectd':
    target  => "${configuration_path}/${configuration_file}",
    content => template('influxdb/influxdb.conf/collectd.conf.erb'),
    order   => '12'
  }

  -> concat::fragment { 'influxdb_opentsdb':
    target  => "${configuration_path}/${configuration_file}",
    content => template('influxdb/influxdb.conf/opentsdb.conf.erb'),
    order   => '13'
  }

  -> concat::fragment { 'influxdb_udp':
    target  => "${configuration_path}/${configuration_file}",
    content => template('influxdb/influxdb.conf/udp.conf.erb'),
    order   => '14'
  }

  -> concat::fragment { 'influxdb_continuous_queries':
    target  => "${configuration_path}/${configuration_file}",
    content => template('influxdb/influxdb.conf/continuous_queries.conf.erb'),
    order   => '15'
  }

  -> concat::fragment { 'influxdb_tls':
    target  => "${configuration_path}/${configuration_file}",
    content => template('influxdb/influxdb.conf/tls.conf.erb'),
    order   => '16'
  }

  -> file { $service_defaults:
    ensure  => $service_defaults_manage,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($service_default_template),
  }

  -> file { $service_definition:
    ensure  => $service_definition_manage,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($service_definition_template),
  }

  -> file { $tsm_data:
    ensure => $tsm_data_manage,
    owner  => $user,
    group  => $group,
    mode   => '0755',
  }

  -> file { $tsm_wal:
    ensure => $tsm_wal_manage,
    owner  => $user,
    group  => $group,
    mode   => '0755',
  }

  -> file { $metadata_raft:
    ensure => $metadata_raft_manage,
    owner  => $user,
    group  => $group,
    mode   => '0755',
  }

}
