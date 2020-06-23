# @summary Manages databases
#    depending on http / https authorization parameters
#
# @example
#   influxdb::database { 'database': }
define influxdb::database (
  Enum['present', 'absent'] $ensure = 'present',
  String $database = $title,
  String $path = '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin',
  Boolean $https_enabled = $influxdb::https_enabled,
  Boolean $auth_enabled = $influxdb::auth_enabled,
  String $http_admin = $influxdb::http_admin,
  String $http_password = $influxdb::http_password,
) {

include influxdb::config
include influxdb::params

if ($https_enabled == true) {
  $cmd = 'influx -ssl -unsafeSsl'}
    else {
      $cmd = 'influx'}

if ($auth_enabled == true) {
  $cmd_admin = "-username ${http_admin} -password ${http_password}" }
  else {
    $cmd_admin = ''}

  if ($ensure == 'absent') {
    exec { "drop_database_${database}":
      path    => $path,
      command =>
        "${cmd} ${cmd_admin} \
        -execute 'DROP DATABASE ${database}'",
      onlyif  =>
        "${cmd} ${cmd_admin} \
        '-execute 'SHOW DATABASES' | tail -n+3 | grep -x ${database}",
      }
  } else {
    exec {"create_database_${database}":
      path    => $path,
      command =>
        "${cmd} ${cmd_admin} \
        -execute 'CREATE DATABASE ${database}'",
      unless  =>
        "${cmd} ${cmd_admin} \
        -execute 'SHOW DATABASES' | tail -n+3 | grep -x ${database}",
    }
  }
}
