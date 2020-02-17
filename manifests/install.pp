# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include influxdb::install
class influxdb::install  {

  package { $::influxdb::package:
    ensure => $::influxdb::package_manage
  }

  group { $influxdb::group:
    ensure => $::influxdb::group_manage,
    system => $::influxdb::group_system,
  }

  user { $influxdb::user:
    ensure     => $::influxdb::user_manage,
    gid        => $influxdb::group,
    home       => "/home/${influxdb::user}",
    managehome => $::influxdb::user_manage_home,
    system     => $::influxdb::user_system,
    require    => Group[$influxdb::group],
  }

}
