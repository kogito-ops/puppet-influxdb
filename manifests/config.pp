# @summary Manages directories and files; configuration and service
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

  -> concat { "${::influxdb::configuration_path}/${::influxdb::configuration_file}":
    owner => 'root',
    group => 'root',
    mode  => '0644'
  }

  -> concat::fragment { 'influxdb_header':
    target  => "${::influxdb::configuration_path}/${::influxdb::configuration_file}",
    content => template($::influxdb::configuration_template),
    order   => '01'
  }

  -> concat::fragment { 'influxdb_meta':
    target  => "${::influxdb::configuration_path}/${::influxdb::configuration_file}",
    content => template('influxdb/influxdb.conf/meta.conf.erb'),
    order   => '02'
  }

  -> concat::fragment { 'influxdb_data':
    target  => "${::influxdb::configuration_path}/${::influxdb::configuration_file}",
    content => template('influxdb/influxdb.conf/data.conf.erb'),
    order   => '03'
  }

  -> concat::fragment { 'influxdb_coordinator':
    target  => "${::influxdb::configuration_path}/${::influxdb::configuration_file}",
    content => template('influxdb/influxdb.conf/coordinator.conf.erb'),
    order   => '04'
  }

  -> concat::fragment { 'influxdb_retention':
    target  => "${::influxdb::configuration_path}/${::influxdb::configuration_file}",
    content => template('influxdb/influxdb.conf/retention.conf.erb'),
    order   => '05'
  }

  -> concat::fragment { 'influxdb_shard-precreation':
    target  => "${::influxdb::configuration_path}/${::influxdb::configuration_file}",
    content => template('influxdb/influxdb.conf/shard-precreation.conf.erb'),
    order   => '06'
  }

  -> concat::fragment { 'influxdb_monitor':
    target  => "${::influxdb::configuration_path}/${::influxdb::configuration_file}",
    content => template('influxdb/influxdb.conf/monitor.conf.erb'),
    order   => '07'
  }

  -> concat::fragment { 'influxdb_http':
    target  => "${::influxdb::configuration_path}/${::influxdb::configuration_file}",
    content => template('influxdb/influxdb.conf/http.conf.erb'),
    order   => '08'
  }

  -> concat::fragment { 'influxdb_logging':
    target  => "${::influxdb::configuration_path}/${::influxdb::configuration_file}",
    content => template('influxdb/influxdb.conf/logging.conf.erb'),
    order   => '09'
  }

  -> concat::fragment { 'influxdb_subscriber':
    target  => "${::influxdb::configuration_path}/${::influxdb::configuration_file}",
    content => template('influxdb/influxdb.conf/subscriber.conf.erb'),
    order   => '10'
  }

  -> concat::fragment { 'influxdb_graphite':
    target  => "${::influxdb::configuration_path}/${::influxdb::configuration_file}",
    content => template('influxdb/influxdb.conf/graphite.conf.erb'),
    order   => '11'
  }

  -> concat::fragment { 'influxdb_collectd':
    target  => "${::influxdb::configuration_path}/${::influxdb::configuration_file}",
    content => template('influxdb/influxdb.conf/collectd.conf.erb'),
    order   => '12'
  }

  -> concat::fragment { 'influxdb_opentsdb':
    target  => "${::influxdb::configuration_path}/${::influxdb::configuration_file}",
    content => template('influxdb/influxdb.conf/opentsdb.conf.erb'),
    order   => '13'
  }

  -> concat::fragment { 'influxdb_udp':
    target  => "${::influxdb::configuration_path}/${::influxdb::configuration_file}",
    content => template('influxdb/influxdb.conf/udp.conf.erb'),
    order   => '14'
  }

  -> concat::fragment { 'influxdb_continuous_queries':
    target  => "${::influxdb::configuration_path}/${::influxdb::configuration_file}",
    content => template('influxdb/influxdb.conf/continuous_queries.conf.erb'),
    order   => '15'
  }

  -> concat::fragment { 'influxdb_tls':
    target  => "${::influxdb::configuration_path}/${::influxdb::configuration_file}",
    content => template('influxdb/influxdb.conf/tls.conf.erb'),
    order   => '16'
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
