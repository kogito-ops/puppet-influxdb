# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include influxdb::config
class influxdb::config(
  String $file_resource = 'file',     # As in native file
){

  $file = lookup('influxdb::file', Hash, 'deep', {})

  if $file != {} {
    create_resources($file_resource, $file)
  }
}
