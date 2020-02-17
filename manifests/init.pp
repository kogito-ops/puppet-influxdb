# @summary Manages an InfluxDB server
#
# @example
#   include influxdb
class influxdb (

  String $gpg_manage = 'present',
  String $gpg_id = '05CE15085FC09D18E99EFB22684A14CF2582E0C5',
  String $gpg_server = 'eu.pool.sks-keyservers.net',
  String $gpg_source = 'https://repos.influxdata.com/influxdb.key',

  String $package= 'influxdb',
  String $package_manage= 'present',

  String $group = 'influxdb',
  String $group_manage = 'present',
  Boolean $group_system ='true',
  String $user = 'influxdb',
  String $user_manage = 'present',
  Boolean $user_system ='true',
  Boolean $user_manage_home ='true',

  String $configuration_path = '/etc/influxdb',
  String $configuration_path_manage = 'directory',
  String $configuration_file = 'influxdb.conf',
  String $configuration_file_manage = 'present',
  String $configuration_template= 'influxdb/influxdb.conf.erb',
  String $service_defaults = '/etc/default/influxdb',
  String $service_defaults_manage = 'present',
  String $service_default_template = 'influxdb/service-defaults.erb',
  String $service_definition = '/lib/systemd/system/influxdb.service',
  String $service_definition_manage = 'present',
  String $service_definition_template = 'influxdb/systemd.service.erb',
  String $metadata_raft = '/var/lib/influxdb/meta',
  String $metadata_raft_manage = 'directory',
  String $tsm_data = '/var/lib/influxdb/data',
  String $tsmdata_manage = 'directory',
  String $tsm_wal = '/var/lib/influxdb/wal',
  String $tsm_wal_manage = 'directory',
  String $service_name = 'influxdb',
  String $service_provider = 'systemd',
  String $service_manage = 'running',
  Boolean $service_enable = true,
  Boolean $service_hasstatus = true,
  Boolean $service_hasrestart = true,
) {

  include ::influxdb::repo
  include ::influxdb::install
  include ::influxdb::config
  contain ::influxdb::service

  Class['influxdb::repo'] ~> Class['influxdb::install']
  Class['influxdb::install'] ~> Class['influxdb::config', 'influxdb::service']
}
