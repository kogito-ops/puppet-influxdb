# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include influxdb::install
class influxdb::install (
  String $package_resource = 'package',     # As in native package
  ) {

  $packages     = lookup('influxdb::packages', Hash, 'deep', {})

  if $packages != {} {
    create_resources($package_resource, $packages)
  }

  $group = lookup('influxdb::group')

  group { $group:
    ensure => present,
    system => true,
  }

  $user = lookup('influxdb::user')

  user { $user:
    ensure     => present,
    gid        => $group,
    home       => "/home/${user}",
    managehome => true,
    system     => true,
    require    => Group[$group],
  }
}
