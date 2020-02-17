# @summary This class deals with the service
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
