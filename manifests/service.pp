# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include influxdb::service
class influxdb::service {
  service { $::influxdb::params::service_name:
    ensure     => $::influxdb::params::service_ensure,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    provider   => $::influxdb::params::service_provider,
  }
}
