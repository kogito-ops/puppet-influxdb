# @summary Manages influxdb user privileges.
#
# Manages influxdb user privileges
#  - depending on http / https authorization enabled or not

# @example
#   influxdb::privilege { 'privilege': }
define influxdb::privilege (
  String $user = $title,
  Enum['present', 'absent'] $ensure = 'present',
  Enum['ALL', 'READ', 'WRITE'] $privilege = 'ALL',
  String $database = 'database1',
  String $path = '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin',
  Boolean $https_enabled = $influxdb::https_enabled,
  Boolean $auth_enabled = $influxdb::auth_enabled,
  String $admin_username = $influxdb::admin_username,
  String $admin_password = $influxdb::admin_password,
) {

if ($https_enabled == true) {
  $cmd = 'influx -ssl -unsafeSsl'}
    else {
      $cmd = 'influx'}

if ($auth_enabled == true) {
  $cmd_admin = "-username ${admin_username} -password ${admin_password}" }
  else {
    $cmd_admin = ''}

$matches = "grep ${database} | grep ${privilege}"


  if ($ensure == 'absent') {
    exec { "revoke_${privilege}_on_${database}_to_${user}":
      path    => $path,
      command =>
        "${cmd} ${cmd_admin} \
        -execute 'REVOKE ${privilege} ON \"${database}\" TO \"${user}\"'",
      onlyif  =>
        "${cmd} ${cmd_admin} \
        '-execute 'SHOW GRANTS FOR \"${user}\"' | ${matches}"
    }
  } elsif ($ensure == 'present') {
    exec {"grant_${privilege}_on_${database}_to_${user}":
      path    => $path,
      command =>
        "${cmd} ${cmd_admin} \
        -execute 'GRANT ${privilege} ON \"${database}\" \
        TO \"${user}\"'",
      unless  =>
        "${cmd} ${cmd_admin} \
        -execute 'SHOW GRANTS FOR \"${database}\"' | ${matches}"
    }
  }
}
