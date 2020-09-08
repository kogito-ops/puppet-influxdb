# @summary Manages databases
#    depending on http / https authorization parameters
#
# @example
#   influxdb::database { 'database': }
define influxdb::database (
  Enum['present', 'absent'] $ensure = 'present',
  String $database = $title,
  Stdlib::Unixpath $path = '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin',
  Boolean $https_enabled = $influxdb::https_enabled,
  Boolean $auth_enabled = $influxdb::auth_enabled,
  String $admin = $influxdb::admin,
  String $admin_password = $influxdb::admin_password,
) {
  include influxdb::params

  if $https_enabled {
  $cmd = 'influx -ssl -unsafeSsl' }
  else {
  $cmd = 'influx' }

  if $auth_enabled {
  $cmd_admin = "-username ${admin} -password \'${admin_password}\'" }
  else {
  $cmd_admin = '' }

  influxdb_database { "influxdb_database_${database}":
    ensure         => $ensure,
    cmd            => $cmd,
    cmd_admin      => $cmd_admin,
    admin          => $admin,
    admin_password => $admin_password,
    auth_enabled   => $auth_enabled,
    database       => $database,
    require        => Exec['is_influx_already_listening'],
  }
}
