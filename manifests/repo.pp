# @summary Manages gpg key information and repository, if necessary
#
# @example
#   include influxdb::repo
class influxdb::repo (
  Boolean $manage_repo = $influxdb::manage_repo,
  String $package = $influxdb::package,
  Enum['present', 'absent']  $ensure = $influxdb::ensure,
){

  if $manage_repo {

    case $facts['os']['distro']['id'] {
      'Ubuntu': {
        apt::source { 'influxdb':
          comment  => 'InfluxDB repository',
          location => 'https://repos.influxdata.com/ubuntu',
          release  => $facts[os][distro][codename],
          repos    => 'stable',
          key      => {
            'id'     => '05CE15085FC09D18E99EFB22684A14CF2582E0C5',
            'source' => 'https://repos.influxdata.com/influxdb.key',
          },
        }
        Class['apt::update'] -> Package[$package]
      }

      'Debian': {
      }

      'CentOS': {
      }

      default: {
        fail('Only Ubuntu, Debian and CentOS are supported')
      }
    }
  }

  else {
    ensure_packages([$package],
    {
      ensure => $ensure,
    })
  }
}
