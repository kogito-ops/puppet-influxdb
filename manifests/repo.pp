# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include influxdb::repo
class influxdb::repo {
  include ::apt

  apt::key {'influxdb':
      ensure => present,
      id     => '05CE15085FC09D18E99EFB22684A14CF2582E0C5',
      server => 'eu.pool.sks-keyservers.net',
      source => 'https://repos.influxdata.com/influxdb.key',
  }

  apt::source{'influxdb':
      ensure       => present,
      comment      => 'InfluxData repository',
      location     => 'https://repos.influxdata.com/ubuntu',
      release      => $facts['os']['distro']['codename'],
      repos        => 'stable',
      include      => {
          src => false,
          deb => true,
      },
      architecture => 'amd64',
      key          => {
          id     => '05CE15085FC09D18E99EFB22684A14CF2582E0C5',
      }
  }
}
