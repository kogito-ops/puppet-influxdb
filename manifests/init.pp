# @summary Manages an InfluxDB server
#
# @example
#   include influxdb
class influxdb (
  Boolean $manage_repo = $influxdb::params::manage_repo,
  String $package_name = $influxdb::params::package_name,
  String $ensure_package = $influxdb::params::ensure_package,

  String $group = $influxdb::params::group,
  Boolean $group_system = $influxdb::params::group_system,
  String $user = $influxdb::params::user,
  Boolean $user_system = $influxdb::params::user_system,
  Boolean $user_manage_home = $influxdb::params::user_manage_home,
  String $user_home = $influxdb::params::user_home,

  String $configuration_path = $influxdb::params::configuration_path,
  String $configuration_file = $influxdb::params::configuration_file,
  String $configuration_template= $influxdb::params::configuration_template,
  String $service_defaults = $influxdb::params::service_defaults,
  String $service_default_template = $influxdb::params::service_default_template,
  String $service_definition = $influxdb::params::service_definition,
  String $service_name = $influxdb::params::service_name,
  String $service_provider = $influxdb::params::service_provider,
  Enum['running', 'stopped'] $service_manage = $influxdb::params::service_manage,
  Boolean $service_enable = $influxdb::params::service_enable,
  Boolean $service_has_status = $influxdb::params::service_has_status,
  Boolean $service_has_restart = $influxdb::params::service_has_restart,

# database, user, grant, retention
  String $http_admin = $influxdb::params::http_admin,
  String $http_password = $influxdb::params::http_password,
  Boolean $https_enabled = false,
  Boolean $auth_enabled = false,
  Hash $users = $influxdb::params::users,
  Hash $grants = $influxdb::params::grants,
  Hash $databases = $influxdb::params::databases,
  Hash $retentions = $influxdb::params::retentions,

# configuration template
#  header
  Boolean $reporting_disabled = $influxdb::params::reporting_disabled,
  String $rpc_bind_address = $influxdb::params::rpc_bind_address,

#  meta
  String $metadata_raft = $influxdb::params::metadata_raft,
  Boolean $retention_autocreate = $influxdb::params::retention_autocreate,
  Boolean $logging_enabled = $influxdb::params::logging_enabled,

#  data
  String $tsm_data = $influxdb::params::tsm_data,
  String $tsm_wal = $influxdb::params::tsm_wal,
  String $wal_fsync_delay = $influxdb::params::wal_fsync_delay,
  String $index_version = $influxdb::params::index_version,
  Boolean $trace_logging_enabled = $influxdb::params::trace_logging_enabled,
  Boolean $query_log_enabled = $influxdb::params::query_log_enabled,
  Boolean $validate_keys = $influxdb::params::validate_keys,
  String $cache_max_memory_size = $influxdb::params::cache_max_memory_size,
  String $cache_snapshot_memory_size = $influxdb::params::cache_snapshot_memory_size,
  String $cache_snapshot_write_cold_duration = $influxdb::params::cache_snapshot_write_cold_duration,
  String $compact_full_write_cold_duration = $influxdb::params::compact_full_write_cold_duration,
  Integer $max_concurrent_compactions = $influxdb::params::max_concurrent_compactions,
  String $compact_throughput = $influxdb::params::compact_throughput,
  String $compact_throughput_burst = $influxdb::params::compact_throughput_burst,
  Boolean $tsm_use_madv_willneed = $influxdb::params::tsm_use_madv_willneed,
  Integer $max_series_per_database = $influxdb::params::max_series_per_database,
  Integer $max_values_per_tag = $influxdb::params::max_values_per_tag,
  String $max_index_log_file_size = $influxdb::params::max_index_log_file_size,
  Integer $series_id_set_cache_size = $influxdb::params::series_id_set_cache_size,

  Hash $coordinator = $influxdb::params::coordinator,
  Hash $retention = $influxdb::params::retention,
  Hash $shard_precreation = $influxdb::params::shard_precreation,
  Hash $monitor = $influxdb::params::monitor,
  Hash $http = $influxdb::params::http,
  Hash $logging = $influxdb::params::logging,
  Hash $subscriber = $influxdb::params::subscriber,
  Hash $graphite = $influxdb::params::graphite,
  Hash $collectd = $influxdb::params::collectd,
  Hash $opentsdb = $influxdb::params::opentsdb,
  Hash $udp = $influxdb::params::udp,
  Hash $continuous_queries = $influxdb::params::continuous_queries,
  Hash $tls = $influxdb::params::tls,
)
  inherits influxdb::params
{
  include ::influxdb::repo
  include ::influxdb::install
  include ::influxdb::config
  contain ::influxdb::service

  Class['influxdb::repo'] ~> Class['influxdb::install']
  Class['influxdb::install'] ~> Class['influxdb::config', 'influxdb::service']


  $databases.each | $database_name, $database_config | {
    influxdb::database { $database_name:
      * => $database_config,
    }
  }

  $users.each | $user, $user_config | {
    influxdb::user { $user:
      * => $user_config,
    }
  }

  $grants.each | $user, $grant | {
    influxdb::grant { $user:
      * => $grant,
    }
  }

  $retentions.each | $retention_name, $retention | {
    influxdb::retention { $retention_name:
      * => $retention,
    }
  }
}
