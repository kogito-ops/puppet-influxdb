# @summary Manages gpg key information and repository, if necessary
#
# @example
#   include influxdb::repo
class influxdb::repo (
  String $key_resource = $influxdb::key_resource,
  String $resource = $influxdb::resource,
  Boolean $manage_repo = $influxdb::manage_repo,
){
  if $manage_repo {

    $keys = lookup('influxdb::gpg_keys', Hash, 'deep', {})
    $repositories = lookup('influxdb::repositories', Hash, 'deep', {})

    if $keys != {} {
      create_resources($key_resource, $keys)
    }
    if $repositories != {} {
      create_resources($resource, $repositories)
    }
  }
}
