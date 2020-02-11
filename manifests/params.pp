# @summary Parameters of configuration and installation
#
# This class defines parameters and sets defaults
#
# @example
#   include influxdb::params
class influxdb::params (
  String $package_manager = 'undef',
  String $keyid = '05CE15085FC09D18E99EFB22684A14CFE0C5',
  String $keyid_source = 'https://repos.influxdata.com/influxdb.key',
  String $keyid_server ='eu.pool.sks-keyservers.net',
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
}
