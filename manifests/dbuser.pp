# @summary Manages influxdb users.
#
# Manages influxdb users
#  - depending on http enabled or not

# @example
#   influxdb::dbuser { 'dbuser': }
define influxdb::dbuser (
  $dbuser_path = $influxdb::dbuser_path,
  String $cmd = 'influx',
  String $cmd_admin = '',
  String $passwd = '12345',
  Enum['present', 'absent'] $ensure = 'present',
  String $arg_p = 'WITH PASSWORD',
  String $arg_a = 'WITH ALL PRIVILEGES',
  String $cmd_show = "-execute 'SHOW USERS' | tail -n+3 | awk '{print \$1}' | grep -x",
) {

  if ($ensure == 'absent') {
    exec { "drop_user_${title}":
      path    => $dbuser_path,
      command =>
        "${cmd} ${cmd_admin} \
        -execute 'DROP USER \"${title}\"'",
      onlyif  =>
        "${cmd} ${cmd_admin} ${cmd_show}"
    }
  } elsif ($ensure == 'present') {
    $arg_p = "'${arg_p}' '${passwd}'"

    exec { "create_user_${title}":
      path    => $dbuser_path,
      command =>
        "${cmd} ${cmd_admin} \
        -execute \"CREATE USER \\\"${title}\\\" ${arg_p} ${arg_a}\"",
      unless  =>
        "${cmd} ${cmd_admin} ${cmd_show}"
    }
  }
}
