# @summary Parameter definiton
#
# @example
#   include influxdb::params
class influxdb::params (

  Boolean $manager_repo = true,
  String $package_name = 'influxdb',
  Enum['present', 'absent'] $ensure_package = 'present',

  String $group = 'influxdb',
  Boolean $group_system = true,
  String $user = 'influxdb',
  Boolean $user_system = true,
  Boolean $user_manage_home = true,
  String $user_home = '/var/lib/',

  String $configuration_path = '/etc/influxdb',
  String $configuration_file = 'influxdb.conf',
  String $configuration_template= 'influxdb/influxdb.conf.erb',
  String $service_defaults = '/etc/default/influxdb',
  String $service_default_template = 'influxdb/service-defaults.erb',
  String $service_definition = '/lib/systemd/system/influxdb.service',
  String $service_definition_template = 'influxdb/systemd.service.erb',
  String $service_name = 'influxdb',
  String $service_provider = 'systemd',
  Enum['running', 'absent'] $service_manage = 'running',
  Boolean $service_enable = true,
  Boolean $service_has_status = true,
  Boolean $service_has_restart = true,

# database, user, grant, retention
  String $http_admin = 'admin',
  String $http_password = '',
  Hash $users = {},
  Hash $grants = {},
  Hash $databases = {},
  Hash $retentions = {},

# configuration template
#  header
  Boolean $reporting_disabled = false,
  String $rpc_bind_address = '127.0.0.1:8088',

#  meta
  String $metadata_raft = '/var/lib/influxdb/meta',
  Enum['directory', 'absent'] $metadata_raft_manage = 'directory',
  Boolean $retention_autocreate = true,
  Boolean $logging_enabled = true,

#  data
  String $tsm_data = '/var/lib/influxdb/data',
  String $tsm_wal = '/var/lib/influxdb/wal',
  String $wal_fsync_delay = '0s',
  String $index_version = 'inmem',
  Boolean $trace_logging_enabled = false,
  Boolean $query_log_enabled = true,
  Boolean $validate_keys = false,
  String $cache_max_memory_size = '1g',
  String $cache_snapshot_memory_size = '25m',
  String $cache_snapshot_write_cold_duration = '10m',
  String $compact_full_write_cold_duration = '4h',
  Integer $max_concurrent_compactions = 0,
  String $compact_throughput = '48m',
  String $compact_throughput_burst = '48m',
  Boolean $tsm_use_madv_willneed = false,
  Integer $max_series_per_database = 1000000,
  Integer $max_values_per_tag = 100000,
  String $max_index_log_file_size = '1m',
  Integer $series_id_set_cache_size = 100,

  Hash $coordinator = {},
  Hash $retention = {},
  Hash $shard_precreation = {},
  Hash $monitor = {},
  Hash $http = {},
  Hash $logging = {},
  Hash $subscriber = {},
  Hash $graphite = {},
  Hash $collectd = {},
  Hash $opentsdb = {},
  Hash $udp = {},
  Hash $continuous_queries = {},
  Hash $tls = {},
  ){

}
