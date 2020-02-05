# @summary Manages an InfluxDB server
#
# @example
#   include influxdb
class influxdb (

) inherits influxdb::params {
  include ::influxdb::repo
  include ::influxdb::install
  include ::influxdb::config
  contain ::influxdb::service

  Class['influxdb::repo'] ~> Class['influxdb::install']
  Class['influxdb::install'] ~> Class['influxdb::config', 'influxdb::service']
}
