# @summary Manages influxdb users.
#
# Manages influxdb users
#  - depending on http / https authorization enabled or not

# @example
#   influxdb::user { 'user': }
define influxdb::user (
  String $user = $title,
  String $passwd = '12345',
  Enum['present', 'absent'] $ensure = 'present',
  String $arg_p = 'WITH PASSWORD',
  String $arg_a = 'WITH ALL PRIVILEGES',
  String $path = '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin',
  Boolean $https_enabled = $influxdb::https_enabled,
  Boolean $auth_enabled = $influxdb::auth_enabled,
  String $http_admin = $influxdb::http_admin,
  String $http_password = $influxdb::http_password,
) {

if $https_enabled {
  $cmd = 'influx -ssl -unsafeSsl'}
    else {
      $cmd = 'influx'}

if ($auth_enabled == true) {
  $cmd_admin = "-username ${http_admin} -password ${http_password}" }
  else {
    $cmd_admin = ''}

  if ($ensure == 'absent') {
    exec { "drop_user_${user}":
      path    => $path,
      command =>
        "${cmd} ${cmd_admin} \
        -execute 'DROP USER ${user}'",
      onlyif  =>
        "${cmd} ${cmd_admin} \
        '-execute 'SHOW USERS' | tail -n+3 | awk '{print \$1}' |\
         grep -x' ${user}",
    }
  } else {
      $arg_x = "${arg_p} \'${passwd}\'"
      exec { "create_user_${user}":
        path    => $path,
        command =>
          "${cmd} ${cmd_admin} \
          -execute \"CREATE USER \\\"${user}\\\" ${arg_x} ${arg_a}\"",
        unless  =>
          "${cmd} ${cmd_admin} \
          -execute 'SHOW USERS' | tail -n+3 | awk '{print \$1}' |\
          grep -x ${user}",
      }
    }
}
