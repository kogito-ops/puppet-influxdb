# @summary Manages influxdb database.
#
# Manages influxdb database
#  - depending on http / https authorization enabled or not

# @example
#   influxdb::database { 'database': }
define influxdb::database (
  String $cmd = 'influx',
  String $cmd_admin = '',
  Enum['present', 'absent'] $ensure = 'present',
  String $database = $title,
  String $path = '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin',
  String $https_enable = $influxdb::https_enable,
  String $http_auth_enabled = $influxdb::http_auth_enabled,
  String $admin_username = $influxdb::admin_username,
  String $admin_password = $influxdb::admin_password,
) {

if ($https_enable == true) {
  $cmd = 'influx -ssl -unsafeSsl'}
    else {
      $cmd = 'influx'}

if ($http_auth_enabled == true) {
  $cmd_admin = "-username ${admin_username} -password ${admin_password}" }
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
      require => Class['influxdb']
    }
  } elsif ($ensure == 'present') {
    exec {"create_database_${database}":
      path    => $path,
      command =>
        "${cmd} ${cmd_admin} \
        -execute 'CREATE DATABASE ${database}'",
      unless  =>
        "${cmd} ${cmd_admin} \
        -execute 'SHOW DATABASES' | tail -n+3 | grep -x ${database}",
      requiry => Class['influxdb']

    }
  }
}
