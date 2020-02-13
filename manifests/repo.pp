# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include influxdb::repo
class influxdb::repo (
  String $apt_key_resource = 'apt::key',    # As in puppetlabs-apt
  String $apt_resource     = 'apt::source', # As in puppetlabs-apt
  ) {

  $apt_repos    = lookup('influxdb::apt_repos', Hash, 'deep', {})
  $apt_keys     = lookup('influxdb::apt_keys', Hash, 'deep', {})

  if $apt_keys != {} {
    create_resources($apt_key_resource, $apt_keys)
  }
  if $apt_repos != {} {
    create_resources($apt_resource, $apt_repos)
  }
}
