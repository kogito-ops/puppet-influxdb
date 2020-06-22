# @summary Manages the service
#
# @example
#   include influxdb::service
class influxdb::service (
    String $service_name = $influxdb::service_name,
    Enum['running', 'absent'] $service_manage = $influxdb::service_manage,
    Boolean $service_enable = $influxdb::service_enable,
    Boolean $service_has_status = $influxdb::service_has_status,
    Boolean $service_has_restart = $influxdb::service_has_restart,
    String $service_provider = $influxdb::service_provider,
    String $configuration_path = $influxdb::configuration_path,
    String $configuration_file = $influxdb::configuration_file,
    String $service_defaults = $influxdb::service_defaults,
    String $package_name = $influxdb::package_name,
){
  service { $service_name:
    ensure     => $service_manage,
    enable     => $service_enable,
    hasstatus  => $service_has_status,
    hasrestart => $service_has_restart,
    provider   => $service_provider,
    require    =>  Package[$package_name],
  }
}
