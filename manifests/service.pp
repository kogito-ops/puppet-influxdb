# @summary Manages the service
#
# @example
#   include influxdb::service
class influxdb::service (
    String $service_name = $influxdb::service_name,
    Enum['running', 'absent'] $service_manage = $influxdb::service_manage,
    Boolean $service_enable = $influxdb::service_enable,
    Booelan $service_has_status = $influxdb::service_has_status,
    Boolean $service_has_restart = $influxdb::service_has_restart,
    String $service_provider = $influxdb::service_provider,
){
  service { $service_name:
    ensure     => $service_manage,
    enable     => $service_enable,
    hasstatus  => $service_has_status,
    hasrestart => $service_has_restart,
    provider   => $service_provider,
  }
}
