# @summary Manages an InfluxDB server
#
# @example
#   include influxdb
class influxdb (

  String $key_resource = '',
  String $resource = '',
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

# header
  Boolean $reporting_disabled = false,
  String $rpc_bind_address = '127.0.0.1:8088',

# meta
  String $metadata_raft = '/var/lib/influxdb/meta',
  Enum['directory', 'absent'] $metadata_raft_manage = 'directory',
  Boolean $retention_autocreate = true,
  Boolean $logging_enabled = true,

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
  Integer $max_concurrent_compactions = 0,
  String $compact_throughput = '48m',
  String $compact_throughput_burst = '48m',
  Boolean $tsm_use_madv_willneed = false,
  Integer $max_series_per_database = 1000000,
  Integer $max_values_per_tag = 100000,
  String $max_index_log_file_size = '1m',
  Integer $series_id_set_cache_size = 100,

# coordinator
  String $write_timeout = '10s',
  Integer $max_concurrent_queries = 0,
  String $query_timeout = '0s',
  String $log_queries_after = '0s',
  Integer $max_select_point = 0,
  Integer $max_select_series = 0,
  Integer $max_select_buckets = 0,

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
  Array[String] $access_log_status_filters = [],
  Boolean $write_tracing = false,
  Boolean $pprof_enabled = true,
  Boolean $pprof_auth_enabled = false,
  Boolean $debug_pprof_enabled = false,
  Boolean $ping_auth_enabled = false,
  Boolean $https_enabled = false,
  String $https_certificate = '/etc/ssl/influxdb.pem',
  String $https_private_key = '',
  String $shared_secret = '',
  Integer $max_row_limit = 0,
  Integer $max_connection_limit = 0,
  Boolean $unix_socket_enabled = false,
  String $bind_socket = '/var/run/influxdb.sock',
  Integer $max_body_size = 25000000,
  Integer $max_concurrent_write_limit = 0,
  Integer $max_enqueued_write_limit = 0,
  Integer $enqueued_write_timeout = 0,

# logging
  String $format = 'auto',
  String $level = 'info',
  Boolean $suppress_logo = false,

# subscriber
  Boolean $subsriber_enabled = true,
  String $http_timeout = '30s',
  Boolean $insecure_skip_verify = false,
  String $ca_certs = '',
  Integer $write_concurrency = 40,
  Integer $write_buffer_size = 1000,

# graphite
  Boolean $graphite_enabled = false,
  String $graphite_database = 'graphite',
  String $graphite_retention_policy = '',
  String $graphite_bind_address = ':2003',
  String $graphite_protocol = 'tcp',
  String $graphite_consistency_level = 'one',
  Integer $graphite_batch_size = 5000,
  Integer $graphite_batch_pending = 10,
  String $graphite_batch_timeout = '1s',
  Integer $graphite_udp_read_buffer = 0,
  String $graphite_separator = '.',
  Array[String] $graphite_tags = ['region=us-east', 'zone=1c'],
  Array[String] $graphite_templates = ['*.app env.service.resource.measurement', 'server.*,'],

# collectd
  Boolean $collectd_enabled = false,
  String $collectd_bind_address = ':25826',
  String $collectd_database = 'collectd',
  String $collectd_retention_policy = '',
  String $collectd_typesdb = '/usr/local/share/collectd',
  String $collectd_security_level = 'none',
  String $collectd_auth_file = '/etc/collectd/auth_file',
  Integer $collectd_batch_size = 5000,
  Integer $collectd_batch_pending = 10,
  String $collectd_batch_timeout = '10s',
  Integer $collectd_read_buffer = 0,
  Enum['split', 'join'] $parse_multivalue_plugin = 'split',

# opentsdb
  Boolean $opentsdb_enabled = false,
  String $opentsdb_bind_address = ':4242',
  String $opentsdb_database = 'opentsdb',
  String $opentsdb_retention_policy = '',
  String $opentsdb_consistency_level = 'one',
  Boolean $opentsdb_tls_enabled = false,
  String $opentsdb_certificate= '/etc/ssl/influxdb.pem',
  Boolean $opentsdb_log_point_errors = true,
  Integer $opentsdb_batch_size = 1000,
  Integer $opentsdb_batch_pending = 5,
  String $opentsdb_batch_timeout = '1s',

# udp
  Boolean $udp_enabled = false,
  String $udp_bind_address = ':8089',
  String $udp_database = 'udp',
  String $udp_retention_policy = '',
  Enum['', 'n', 'u', 'ms', 's', 'm', 'h'] $udp_precision = '',
  Integer $udp_batch_size = 5000,
  Integer $udp_batch_pending = 10,
  String $udp_batch_timeout = '1s',
  Integer $udp_read_buffer = 0,

# continuous queries - cntqry
  Boolean $cntqry_enabled = true,
  Boolean $cntqry_log_enabled = true,
  Boolean $cntqry_query_stats_enabled = false,
  String $cntqry_run_interval = '1s',

# tls
  Array[String] $tls_ciphers = ['TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305', 'TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256'],
  String $tls_min_version = 'tls1.2',
  String $tls_max_version = 'tls1.2',

# database, user, privilege
  String $admin_username = 'admin',
  String $admin_password = 'test123',
  Hash $users = {},
  Hash $users_privileges = {},
  Hash $databases = {},

){

  include ::influxdb::repo
  include ::influxdb::install
  include ::influxdb::config
  contain ::influxdb::service

  Class['influxdb::repo'] ~> Class['influxdb::install']
  Class['influxdb::install'] ~> Class['influxdb::config', 'influxdb::service']

$databases.each | $database_name, $database_config | {
    influxdb::user { $database_name:
      * => $database_config,
    }
  }

$users.each | $user_name, $user_config | {
    influxdb::user { $user_name:
      * => $user_config,
    }
  }

$users_privileges.each | $user_name, $user_privilege | {
    influxdb::privileges { $user_name:
      * => $user_privilege,
    }
  }
}
