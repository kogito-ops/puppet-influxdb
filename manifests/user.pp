# @summary Manages influxdb users.
#
# Manages influxdb users
#  - depending on http / https authorization enabled or not

# @example
#   influxdb::user { 'user': }
define influxdb::user (
  String $user = $title,
  String $cmd = 'influx',
  String $cmd_admin = '',
  String $passwd = '12345',
  Enum['present', 'absent'] $ensure = 'present',
  String $arg_p = 'WITH PASSWORD',
  String $arg_a = 'WITH ALL PRIVILEGES',
  String $path = '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin',
  String $https_enable = $influxdb::https_enable,
  String $http_auth_enabled = $influxdb::http_auth_enabled,
  String $admin_username = $influxdb::admin_username,
  String $admin_password = $influxdb::admin_password,
) {

if $https_enable {
  $cmd = 'influx -ssl -unsafeSsl'}
    else {
      $cmd = 'influx'}

if ($http_auth_enabled == true) {
  $cmd_admin = "-username ${admin_username} -password ${admin_password}" }
  else {
    $cmd_admin = ''}


  if ($ensure == 'absent') {
    exec { "drop_user_${title}":
      path    => $path,
      command =>
        "${cmd} ${cmd_admin} \
        -execute 'DROP USER \"${title}\"'",
      onlyif  =>
        "${cmd} ${cmd_admin} \
        '-execute 'SHOW USERS' | tail -n+3 | awk '{print \$1}' |\
         grep -x' ${user}"
    }
  } elsif ($ensure == 'present') {
    $arg_p = "'${arg_p}' '${passwd}'"

    exec { "create_user_${title}":
      path    => $path,
      command =>
        "${cmd} ${cmd_admin} \
        -execute \"CREATE USER \\\"${title}\\\" ${arg_p} ${arg_a}\"",
      unless  =>
        "${cmd} ${cmd_admin} \
        -execute 'SHOW USERS' | tail -n+3 | awk '{print \$1}' |\
        grep -x ${user}"
    }
  }
}
