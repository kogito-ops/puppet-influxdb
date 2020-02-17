# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include influxdb::service
class influxdb::service {

  service { $::influxdb::service_name:
    ensure     => $::influxdb::service_manage,
    enable     => $::influxdb::service_enable,
    hasstatus  => $::influxdb::service_hasstatus,
    hasrestart => $::influxdb::service_hasrestart,
    provider   => $::influxdb::service_provider,
  }

}
