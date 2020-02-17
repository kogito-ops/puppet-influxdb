# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include influxdb::install
class influxdb::install  {

  $package     = lookup('influxdb::packages')

  package { $package:
    ensure => $::influxdb::package_manage
  }

  $group = lookup('influxdb::group')

  group { $group:
    ensure => $::influxdb::group_manage,
    system => $::influxdb::group_system,
  }

  $user = lookup('influxdb::user')

  user { $user:
    ensure     => $::influxdb::user_manage,
    gid        => $group,
    home       => "/home/${user}",
    managehome => $::influxdb::user_manage_home,
    system     => $::influxdb::user_system,
    require    => Group[$group],
  }
}
