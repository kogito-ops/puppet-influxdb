# @summary This class creates gpg key information and repository, if necessary

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
