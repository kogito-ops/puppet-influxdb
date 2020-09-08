# @summary Manages an InfluxDB server
#
# @example
#   include influxdb
class influxdb (
  Boolean $manage_repo = $influxdb::params::manage_repo,
  String $package_name = $influxdb::params::package_name,
  String $ensure = $influxdb::params::ensure,
  Stdlib::HTTPSUrl $repo_location = $influxdb::params::repo_location,
  String $repo_type = $influxdb::params::repo_type,

  String $group = $influxdb::params::group,
  String $user = $influxdb::params::user,

  Stdlib::Absolutepath $configuration_path = $influxdb::params::configuration_path,
  String $configuration_file = $influxdb::params::configuration_file,
  String $configuration_template= $influxdb::params::configuration_template,
  Stdlib::Absolutepath $service_defaults = $influxdb::params::service_defaults,
  String $service_default_template = $influxdb::params::service_default_template,
  Stdlib::Absolutepath $service_definition = $influxdb::params::service_definition,
  String $service_definition_template = $influxdb::params::service_definition_template,
  String $service_name = $influxdb::params::service_name,
  String $service_provider = $influxdb::params::service_provider,
  Stdlib::Ensure::Service $service_ensure = $influxdb::params::service_ensure,
  Boolean $service_enable = $influxdb::params::service_enable,
  Boolean $service_has_status = $influxdb::params::service_has_status,
  Boolean $service_has_restart = $influxdb::params::service_has_restart,
  Boolean $manage_service = $influxdb::params::manage_service,

# database, user, grant, retention
  String $admin = $influxdb::params::admin,
  String $admin_password = $influxdb::params::admin_password,
  Boolean $is_admin = $influxdb::params::is_admin,
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

#  data
  String $tsm_data = $influxdb::params::tsm_data,
  String $tsm_wal = $influxdb::params::tsm_wal,
  Integer $series_id_set_cache_size = $influxdb::params::series_id_set_cache_size,

#  http
  Boolean $https_enabled = $influxdb::params::https_enabled,
  Boolean $auth_enabled = $influxdb::params::auth_enabled,

  Hash $meta = $influxdb::params::data,
  Hash $data = $influxdb::params::data,
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

  Hash $meta_obligatory = $influxdb::params::meta_obligatory,
  Hash $data_obligatory = $influxdb::params::data_obligatory,
  Hash $http_obligatory = $influxdb::params::http_obligatory,
)
  inherits influxdb::params {
  include ::influxdb::repo
  include ::influxdb::install
  include ::influxdb::config
  contain ::influxdb::service

  Class['influxdb::repo'] ~> Class['influxdb::install']
  Class['influxdb::install'] ~> Class['influxdb::config', 'influxdb::service']

  if $service_ensure == 'running' {
    if $https_enabled {
    $cmd = 'influx -ssl -unsafeSsl' }
    else {
    $cmd = 'influx' }
      exec { 'is_influx_already_listening':
        command   => "${cmd} -execute quit",
        unless    => "${cmd} -execute quit",
        tries     => '3',
        try_sleep => '10',
        require   => Service[$service_name],
        path      => '/bin:/usr/bin',
      }
  }

  if ($auth_enabled == true) {
    influxdb::user { $admin:
      password => $admin_password,
      is_admin => true,
    }
  }

  create_resources('influxdb::database', $databases)
  create_resources('influxdb::retention', $retentions)

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
}
