# @summary Manages the service
#
# @example
#   include influxdb::service
class influxdb::service {
  service { $::influxdb::service_name:
    ensure     => $::influxdb::service_manage,
    enable     => $::influxdb::service_enable,
    hasstatus  => $::influxdb::service_has_status,
    hasrestart => $::influxdb::service_has_restart,
    provider   => $::influxdb::service_provider,
  }
}
