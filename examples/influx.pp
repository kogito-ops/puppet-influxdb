include ::influxdb

class { 'influxdb':
  manage_repo => true,
}
