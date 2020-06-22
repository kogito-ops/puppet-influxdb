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
  Boolean $retention_autocreate = $influxdb::retention_autocreate,
  Boolean $logging_enabled = $influxdb::logging_enabled,
#  data
  String $tsm_data = $influxdb::tsm_data,
  String $tsm_wal = $influxdb::tsm_wal,
  String $wal_fsync_delay = $influxdb::wal_fsync_delay,
  String $index_version = $influxdb::index_version,
  Boolean $trace_logging_enabled = $influxdb::trace_logging_enabled,
  Boolean $query_log_enabled = $influxdb::query_log_enabled,
  Boolean $validate_keys = $influxdb::validate_keys,
  String $cache_max_memory_size = $influxdb::cache_max_memory_size,
  String $cache_snapshot_memory_size = $influxdb::cache_snapshot_memory_size,
  String $cache_snapshot_write_cold_duration = $influxdb::cache_snapshot_write_cold_duration,
  String $compact_full_write_cold_duration = $influxdb::compact_full_write_cold_duration,
  Integer $max_concurrent_compactions = $influxdb::max_concurrent_compactions,
  String $compact_throughput = $influxdb::compact_throughput,
  String $compact_throughput_burst = $influxdb::compact_throughput_burst,
  Boolean $tsm_use_madv_willneed = $influxdb::tsm_use_madv_willneed,
  Integer $max_series_per_database = $influxdb::max_series_per_database,
  Integer $max_values_per_tag = $influxdb::max_values_per_tag,
  String $max_index_log_file_size = $influxdb::max_index_log_file_size,
  Integer $series_id_set_cache_size = $influxdb::series_id_set_cache_size,

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

  Hash $http_obligatory = $influxdb::http_obligatory,
){

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
    mode    => '0644'
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
