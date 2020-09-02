# @summary Manages package, group and user
#
# @example
#   include influxdb::install
class influxdb::install (
  String $ensure = $influxdb::ensure,
  String $package_name = $influxdb::package_name,
){
  case $facts['os']['family'] {
  'Debian': {
    include apt
    Class['::apt::update'] -> Package[$package_name]
  }
  'RedHat': {
    Yumrepo['influxdata'] -> Package[$package_name]
  }
    default: {
      # do nothing
    }
  }

    package { $package_name:
      ensure => $ensure,
    }
}
