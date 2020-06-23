# @summary Manages gpg key information and repository, if necessary
#
# @example
#   include influxdb::repo
class influxdb::repo (
  Boolean $manage_repo = $influxdb::manage_repo,
  String $ensure_package = $influxdb::ensure_package,
  String $package_name = $influxdb::package_name,
){

  if $facts['os']['family'] == 'Debian' {
    if $manage_repo {
      apt::source { 'influxdata':
        comment  => 'InfluxDB repository',
        location => "https://repos.influxdata.com/${facts['os']['name'].downcase}",
        release  => $facts[os][distro][codename],
        repos    => 'stable',
        key      => {
          'id'     => '05CE15085FC09D18E99EFB22684A14CF2582E0C5',
          'source' => 'https://repos.influxdata.com/influxdb.key',
        },
      }
    }
    include apt
    Class['::apt::update'] -> Package[$package_name]
    package { $package_name:
      ensure => $ensure_package,
    }
  }
}
