# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include influxdb::params
class influxdb::params (
  # directories
  String $directory_metadataraft = '/var/lib/influxdb/meta',
  String $directory_tsmdata = '/var/lib/influxdb/data',
  String $directory_tsmwal = '/var/lib/influxdb/wal',
){

}
