# @summary Manages an InfluxDB server
#
# @example
#   include influxdb
class influxdb (
  String $package_manager,
  String $key_id,
  String $key_source,
  String $key_server,

) inherits influxdb::params {
  include ::influxdb::repo
  include ::influxdb::install
  include ::influxdb::config
  contain ::influxdb::service

  Class['influxdb::repo'] ~> Class['influxdb::install']
  Class['influxdb::install'] ~> Class['influxdb::config', 'influxdb::service']
}
