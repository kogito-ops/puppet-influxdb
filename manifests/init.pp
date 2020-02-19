# @summary Manages an InfluxDB server
#
# @example
#   include influxdb

class influxdb (

  String $key_resource,
  String $resource,
  String $software = 'influxdb',
  Enum['present', 'absent'] $gpg_manage = 'present',
  String $gpg_id = '05CE15085FC09D18E99EFB22684A14CF2582E0C5',
  String $gpg_server = 'eu.pool.sks-keyservers.net',
  String $gpg_source = 'https://repos.influxdata.com/influxdb.key',

  Enum['present', 'absent'] $repository_manage = 'present',
  String $repos_comment = 'InfluxData repository',
  String $repos_location = 'https://repos.influxdata.com/ubuntu',
  String $repos_release ='%{::os.distro.codename}',
  String $repos = 'stable',
  Boolean $repos_src = false,
  Boolean $repos_bin = true,
  Enum['1', '0'] $repos_gpgcheck = '1',
  Enum['1', '0'] $repos_enable = '1',

  String $package= 'influxdb',
  Enum['present', 'absent'] $package_manage= 'present',

  String $group = 'influxdb',
  Enum['present', 'absent'] $group_manage = 'present',
  Boolean $group_system = true,
  String $user = 'influxdb',
  Enum['present', 'absent'] $user_manage = 'present',
  Boolean $user_system = true,
  Boolean $user_manage_home = true,
  String $user_home = '/var/lib/',

  String $configuration_path = '/etc/influxdb',
  Enum['directory', 'absent'] $configuration_path_manage = 'directory',
  String $configuration_file = 'influxdb.conf',
  Enum['present', 'absent'] $configuration_file_manage = 'present',
  String $configuration_template= 'influxdb/influxdb.conf.erb',
  String $service_defaults = '/etc/default/influxdb',
  Enum['present', 'absent'] $service_defaults_manage = 'present',
  String $service_default_template = 'influxdb/service-defaults.erb',
  String $service_definition = '/lib/systemd/system/influxdb.service',
  Enum['present', 'absent'] $service_definition_manage = 'present',
  String $service_definition_template = 'influxdb/systemd.service.erb',

  String $service_name = 'influxdb',
  String $service_provider = 'systemd',
  Enum['running', 'absent'] $service_manage = 'running',
  Boolean $service_enable = true,
  Boolean $service_has_status = true,
  Boolean $service_has_restart = true,

# meta
  String $metadata_raft = '/var/lib/influxdb/meta',
  Enum['directory', 'absent'] $metadata_raft_manage = 'directory',
  Boolean $retention_autocreate = true,
  Boolean $logging_enalbled = true,

# data
  String $tsm_data = '/var/lib/influxdb/data',
  Enum['directory', 'absent'] $tsm_data_manage = 'directory',
  String $tsm_wal = '/var/lib/influxdb/wal',
  Enum['directory', 'absent'] $tsm_wal_manage = 'directory',
  String $wal_fsync_delay = '0s',
  String $index_version = 'inmem',
  Boolean $trace_logging_enabled = false,
  Boolean $query_log_enabled = true,
  Boolean $validate_keys = false,
  String $cache_max_memory_size = '1g',
  String $cache_snapshot_memory_size = '25m',
  String $cache_snapshot_write_cold_duration = '10m',
  String $compact_full_write_cold_duration = '4h',
  Int $max_concurrent_compactions = 0,
  String $compact_throughput = '48m',
  String $compact_throughput_burst = '48m',
  Boolean $tsm_use_madv_willneed = false,
  Int $max_series_per_database = 1000000,
  Int $max_values_per_tag = 100000,
  String $max_index_log_file_size = '1m',
  Int $series_id_set_cache_size = 100,

# coordinator
  String $write_timeout = '10s',
  Int $max_concurrent_queries = 0,
  String $query_timeout = '0s',
  String $log_queries_after = '0s',
  Int $max_select_point = 0,
  Int $max_select_series = 0,
  Int $max_select_buckets = 0,

# retention
  Boolean $retention_enabled = true,
  String $retention_check_interval = '30m',

# shard-precreation
  Boolean $shard_precreation_enabled = true,
  String $shard_precreation_check_interval = '10m',
  String $shard_precreation_advance_period = '30m',

# monitor
  Boolean $store_enabled = true,
  String $store_database = '_internal',
  String $store_interval = '10s',

# http
  Boolean $http_enabled = true,
  Boolean $flux_enabled = false,
  Boolean $flux_log_enabled = false,
  String $bind_address = ':8086',
  Boolean $auth_enabled = false,
  String $realm = 'InfluxDB',
  Boolean $log_enabled = true,
  Boolean $suppress_write_log = false,
  String $access_log_path = '',
  Array $access_log_status_filters = [],
  Boolean $write_tracing = false,
  Boolean $pprof_enabled = true,
  Boolean $pprof_auth_enabled = false,
  Boolean $debug_pprof_enabled = false,
  Boolean $ping_auth_enabled = false,
  Boolean $https_enabled = false,
  String $https_certificate = '/etc/ssl/influxdb.pem',
  String $https_private_key = '',
  String $shared_secret = '',
  Int $max_row_limit = 0,
  Int $max_connection_limit = 0,
  Boolean $unix_socket_enabled = false,
  String $bind_socket = '/var/run/influxdb.sock',
  Int $max_body_size = 25000000,
  Int $max_concurrent_write_limit = 0,
  Int $max_enqueued_write_limit = 0,
  Int $enqueued_write_timeout = 0,

# logging
  String $format = 'auto',
  String $level = 'info',
  Boolean $suppress_logo = false,

# subscriber
  Boolean $subsriber_enabled = true,
  String $http_timeout = '30s',
  Boolean $insecure_skip_verify = false,
  String $ca_certs = '',
  Int $write_concurrency = 40,
  Int $write_buffer_size = 1000,

# graphit
  Boolean $graphit_enabled = false,
  String $graphit_database = 'graphite',
  String $graphit_retention_policy = '',
  String $graphit_bind_address = ':2003',
  String $graphit_protocol = 'tcp',
  String $graphit_consistency_level = 'one',
  Int $graphit_batch_size = 5000,
  Int $graphit_batch_pending = 10,
  String $graphit_batch_timeout = '1s',
  Int $graphit_udp_read_buffer = 0,
  String $graphit_separator = '.',
  Array $graphit_tags = ['region=us-east', 'zone=1c'],
  Array $graphit_templates = [],

){

  include ::influxdb::repo
  include ::influxdb::install
  include ::influxdb::config
  contain ::influxdb::service

  Class['influxdb::repo'] ~> Class['influxdb::install']
  Class['influxdb::install'] ~> Class['influxdb::config', 'influxdb::service']
}
