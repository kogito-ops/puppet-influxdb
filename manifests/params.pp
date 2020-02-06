# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include influxdb::params
class influxdb::params (
  String $configuration_path = '/etc/influxdb',
  String $configuration_file = 'influxdb.conf',
  String $service_defaults = '/etc/default/influxdb',
  String $service_definition = '/lib/systemd/system/influxdb.service',
  String $directory_metadataraft = '/var/lib/influxdb/meta',
  String $directory_tsmdata = '/var/lib/influxdb/data',
  String $directory_tsmwal = '/var/lib/influxdb/wal',
  String $user = 'influxdb',
  String $group = 'influxdb',
  String $package = 'influxdb',
  String $service_name = 'influxdb',
  String $service_provider = 'systemd',
  String $service_ensure = 'running',
) {
}
