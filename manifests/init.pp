# @summary Manages an InfluxDB server
#
# @example
#   include influxdb
class influxdb (

  String $package_manager = 'default',
  String $key_id = '05CE15085FC09D18E99EFB22684A14CF2582E0C5',
  String $key_source = 'https://repos.influxdata.com/influxdb.key',
  String $key_server = 'eu.pool.sks-keyservers.net',
  String $configuration_path = '/etc/influxdb',
  String $configuration_file = 'influxdb.conf',
  String $service_defaults = '/etc/default/influxdb',
  String $service_definition = '/lib/systemd/system/influxdb.service',
  String $metadata_raft = '/var/lib/influxdb/meta',
  String $tsm_data = '/var/lib/influxdb/data',
  String $tsm_wal = '/var/lib/influxdb/wal',
  String $user = 'influxdb',
  String $group = 'influxdb',
  String $package = 'influxdb',
  String $service_name = 'influxdb',
  String $service_provider = 'systemd',
  String $service_ensure = 'running',

) {

  include ::influxdb::repo
  include ::influxdb::install
  include ::influxdb::config
  contain ::influxdb::service

  Class['influxdb::repo'] ~> Class['influxdb::install']
  Class['influxdb::install'] ~> Class['influxdb::config', 'influxdb::service']
}
