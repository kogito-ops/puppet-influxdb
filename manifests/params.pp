# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include influxdb::params
class influxdb::params {
# directories
$directory_var = '/var/lib/influxdb'
$directory_metadataraft = '/var/lib/influxdb/meta'
$directory_tsmdata = '/var/lib/influxdb/data'
$directory_tsmwal = '/var/lib/influxdb/wal'

}
