# @summary Manages package, group and user
#
# @example
#   include influxdb::install
class influxdb::install (
  String $package= $influxdb::package,
  Enum['present', 'absent'] $package_manage = $influxdb::package_manage,
  String $group = $influxdb::group,
  Boolean $group_system = $influxdb::group_system,
  String $user = $influxdb::user,
  Boolean $user_system = $influxdb::user_system,
  Boolean $user_manage_home = $influxdb::user_manage_home,
  String $user_home = $influxdb::user_home,
){
  package { $package:
    ensure => $package_manage
  }

  group { $group:
    ensure => 'present',
    system => $group_system,
  }

  user { $user:
    ensure     => 'present',
    gid        => $group,
    home       => "${user_home}${user}",
    managehome => $user_manage_home,
    system     => $user_system,
    require    => Group[$group],
  }
}
