# @summary Manages users of databases
#    depending on http / https authorization parameters
#
# @example
#   influxdb::user { 'user': }
define influxdb::user (
  String $user = $title,
  String $password = '12345',
  Enum['present', 'absent'] $ensure = 'present',
  Stdlib::Unixpath $path = '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin',
  Boolean $https_enabled = $influxdb::https_enabled,
  Boolean $auth_enabled = $influxdb::auth_enabled,
  String $admin = $influxdb::admin,
  String $admin_password = $influxdb::admin_password,
  Boolean $is_admin = $influxdb::is_admin,
) {
  include influxdb::params

  if $https_enabled {
  $cmd = 'influx -ssl -unsafeSsl' }
  else {
  $cmd = 'influx' }

  if $auth_enabled {
  $cmd_admin = " -username ${admin} -password \'${admin_password}\'" }
  else {
  $cmd_admin = '' }

  if ($ensure == 'absent') {
    exec { "drop_user_${user}":
      path    => $path,
      command => "${cmd}${cmd_admin} -execute 'DROP USER \"${user}\"'",
      onlyif  => "${cmd}${cmd_admin} -execute 'SHOW USERS' | tail -n+3 | awk '{print \$1}' | grep -x ${user}",
    }
  } else {
    $arg_x = "WITH PASSWORD \'${password}\'"
    if $is_admin {
      $arg_y = 'WITH ALL PRIVILEGES'
    }
    else {
      $arg_y = ''
    }
    exec { "create_user_${user}":
      path    => $path,
      command => "${cmd}${cmd_admin} -execute \"CREATE USER \\\"${user}\\\" ${arg_x} ${arg_y}\"",
      unless  => "${cmd}${cmd_admin} -execute 'SHOW USERS' | tail -n+3 | awk '{print \$1}' | grep -x ${user}",
      require => Exec['is_influx_already_listening'],
    }
  }
}
