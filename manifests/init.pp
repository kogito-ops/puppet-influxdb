# @summary Manages an InfluxDB server
#
# @example
#   include influxdb

class influxdb (

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
  Boolean $repos_gpgcheck = true,
  Boolean $repos_enable = true,

  String $package= 'influxdb',
  Enum['present', 'absent'] $package_manage= 'present',

  String $group = 'influxdb',
  Enum['present', 'absent'] $group_manage = 'present',
  Boolean $group_system = true,
  String $user = 'influxdb',
  Enum['present', 'absent'] $user_manage = 'present',
  Boolean $user_system = true,
  Boolean $user_manage_home = true,

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
  String $metadata_raft = '/var/lib/influxdb/meta',
  Enum['directory', 'absent'] $metadata_raft_manage = 'directory',
  String $tsm_data = '/var/lib/influxdb/data',
  Enum['directory', 'absent'] $tsm_data_manage = 'directory',
  String $tsm_wal = '/var/lib/influxdb/wal',
  Enum['directory', 'absent'] $tsm_wal_manage = 'directory',
  String $service_name = 'influxdb',
  String $service_provider = 'systemd',
  Enum['running', 'absent'] $service_manage = 'running',
  Boolean $service_enable = true,
  Boolean $service_has_status = true,
  Boolean $service_has_restart = true,
  String $key_resource,
  String $resource,
) {

  include ::influxdb::repo
  include ::influxdb::install
  include ::influxdb::config
  contain ::influxdb::service

  Class['influxdb::repo'] ~> Class['influxdb::install']
  Class['influxdb::install'] ~> Class['influxdb::config', 'influxdb::service']
}
