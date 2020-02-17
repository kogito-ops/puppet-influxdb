# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include influxdb::repo
class influxdb::repo {

  $keys = lookup('influxdb::gpg_keys', Hash, 'deep', {})
  $repositories = lookup('influxdb::repositories', Hash, 'deep', {})

  if $keys != {} {
    create_resources($::influxdb::key_resource, $keys)
  }
  if $repositories != {} {
    create_resources($::influxdb::resource, $repositories)
  }

}
