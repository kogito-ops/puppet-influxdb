# @summary Manages user grants within the databases
#   depending on http / https authorization parameters
#
# @example
#   influxdb::grant { 'grant': }
define influxdb::grant (
  String $user = $title,
  Enum['present', 'absent'] $ensure = 'present',
  Enum['ALL', 'READ', 'WRITE'] $grant = 'ALL',
  String $database = 'database1',
  String $path = '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin',
  Boolean $https_enabled = $influxdb::https_enabled,
  Boolean $auth_enabled = $influxdb::auth_enabled,
  String $admin = $influxdb::admin,
  String $admin_password = $influxdb::admin_password,
) {

  Influxdb::Database <| database == $database |> -> Influxdb::Grant[$title]
  Influxdb::User <| user == $user |> -> Influxdb::Grant[$title]

if ($https_enabled == true) {
  $cmd = 'influx -ssl -unsafeSsl'}
    else {
      $cmd = 'influx'}

if ($auth_enabled == true) {
  $cmd_admin = "-username ${admin} -password ${admin_password}" }
  else {
    $cmd_admin = ''}

$matches = "grep ${database} | grep ${grant}"

  if ($ensure == 'absent') {
    exec { "revoke_${grant}_on_${database}_to_${user}":
      path    => $path,
      command =>
        "${cmd} ${cmd_admin} \
        -execute 'REVOKE ${grant} ON \"${database}\" TO \"${user}\"'",
      onlyif  =>
        "${cmd} ${cmd_admin} \
        '-execute 'SHOW GRANTS FOR \"${user}\"' | ${matches}",
    }
  } elsif ($ensure == 'present') {
    exec {"grant_${grant}_on_${database}_to_${user}":
      path    => $path,
      command =>
        "${cmd} ${cmd_admin} \
        -execute 'GRANT ${grant} ON \"${database}\" \
        TO \"${user}\"'",
      unless  =>
        "${cmd} ${cmd_admin} \
        -execute 'SHOW GRANTS FOR \"${user}\"' | ${matches}",
    }
  }
}
