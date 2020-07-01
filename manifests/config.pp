# @summary Manages directories and files; configuration and service
#
# @example
#   include influxdb::config
class influxdb::config (
  String $configuration_path = $influxdb::configuration_path,
  String $configuration_file = $influxdb::configuration_file,
  String $configuration_template= $influxdb::configuration_template,
  String $service_defaults = $influxdb::service_defaults,
  String $service_default_template = $influxdb::service_default_template,
  String $service_definition = $influxdb::service_definition,
  String $service_definition_template = $influxdb::service_definition_template,
  String $group = $influxdb::group,
  String $user = $influxdb::user,

  # configuration template
  #  header
  Boolean $reporting_disabled = $influxdb::reporting_disabled,
  String $rpc_bind_address = $influxdb::rpc_bind_address,
#  meta
  String $metadata_raft = $influxdb::metadata_raft,

#  data
  String $tsm_data = $influxdb::tsm_data,
  String $tsm_wal = $influxdb::tsm_wal,
  Integer $series_id_set_cache_size = $influxdb::series_id_set_cache_size,

#  http
  Boolean $https_enabled = $influxdb::https_enabled,
  Boolean $auth_enabled = $influxdb::auth_enabled,

  Hash $meta = $influxdb::meta,
  Hash $data = $influxdb::data,
  Hash $coordinator = $influxdb::coordinator,
  Hash $retention = $influxdb::retention,
  Hash $shard_precreation = $influxdb::shard_precreation,
  Hash $monitor = $influxdb::monitor,
  Hash $http = $influxdb::http,
  Hash $logging = $influxdb::logging,
  Hash $subscriber = $influxdb::subscriber,
  Hash $graphite = $influxdb::graphite,
  Hash $collectd = $influxdb::collectd,
  Hash $opentsdb = $influxdb::opentsdb,
  Hash $udp = $influxdb::udp,
  Hash $continuous_queries = $influxdb::continuous_queries,
  Hash $tls = $influxdb::tls,

  Hash $meta_obligatory = $influxdb::meta_obligatory,
  Hash $data_obligatory = $influxdb::data_obligatory,
  Hash $http_obligatory = $influxdb::http_obligatory,
){

  $template_meta = deep_merge($meta_obligatory, $meta)
  $template_data = deep_merge($data_obligatory, $data)
  $template_http = deep_merge($http_obligatory, $http)

  file { $configuration_path:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  -> file { "${configuration_path}/${configuration_file}":
    ensure  => file,
    content => template($configuration_template),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  -> file { $service_defaults:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($service_default_template),
  }

  -> file { $service_definition:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($service_definition_template),
  }

  -> file { $tsm_data:
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => '0755',
  }

  -> file { $tsm_wal:
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => '0755',
  }

  -> file { $metadata_raft:
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => '0755',
  }
}
