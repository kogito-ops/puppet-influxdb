# @summary Manages the service
#
# @example
#   include influxdb::service
class influxdb::service (
    String $service_name = $influxdb::service_name,
    Stdlib::Ensure::Service $service_ensure = $influxdb::service_ensure,
    Boolean $service_enable = $influxdb::service_enable,
    Boolean $service_has_status = $influxdb::service_has_status,
    Boolean $service_has_restart = $influxdb::service_has_restart,
    String $service_provider = $influxdb::service_provider,
    Boolean $manage_service = $influxdb::manage_service,
    Stdlib::Absolutepath $service_definition = $influxdb::service_definition,
){
  if $manage_service {
    service { $service_name:
      ensure     => $service_ensure,
      enable     => $service_enable,
      hasstatus  => $service_has_status,
      hasrestart => $service_has_restart,
      provider   => $service_provider,
      subscribe  => [ File[$service_definition],
                    ]
    }
  }
}
