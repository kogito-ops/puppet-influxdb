# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include influxdb::service
class influxdb::service {
  service { 'influxdb':
    ensure     => 'running',
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    provider   => 'systemd',
    subscribe  => package['influxdb'],
  }
}
