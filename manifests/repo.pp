# @summary Manages gpg key information and repository, if necessary
#
# @example
#   include influxdb::repo
class influxdb::repo (
  Boolean $manage_repo = $influxdb::manage_repo,
  String $ensure_package = $influxdb::ensure_package,
  String $package_name = $influxdb::package_name,
){

  if $manage_repo {

    case $facts['os']['distro']['id'] {
      'Ubuntu': {
        apt::source { 'influxdata':
          comment  => 'InfluxDB repository',
          location => 'https://repos.influxdata.com/ubuntu',
          release  => $facts[os][distro][codename],
          repos    => 'stable',
          key      => {
            'id'     => '05CE15085FC09D18E99EFB22684A14CF2582E0C5',
            'source' => 'https://repos.influxdata.com/influxdb.key',
          },
        }
        exec { 'influxdb_apt_get_update':
          command     => 'apt-get update',
          cwd         => '/tmp',
          path        => ['/usr/bin'],
          require     => Apt::Source['influxdata'],
          subscribe   => Apt::Source['influxdata'],
          refreshonly => true,
        }

        package { $package_name:
          ensure  => $ensure_package,
          require => Exec['influxdb_apt_get_update'],
        }
      }

      'Debian': {
      }

      'CentOS': {
      }

      default: {
        fail('Only Ubuntu, Debian and CentOS are supported')
      }
    }
    } else {
      exec { 'influxdb_apt_get_update':
        command     => 'apt-get update',
        cwd         => '/tmp',
        path        => ['/usr/bin'],
        require     => Apt::Source['influxdata'],
        subscribe   => Apt::Source['influxdata'],
        refreshonly => true,
      }

      package { $package_name:
        ensure  => $ensure_package,
        require => Exec['influxdb_apt_get_update'],
      }
  }
}
