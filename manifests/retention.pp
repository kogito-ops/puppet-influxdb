# @summary Manages retentions of databases
#     depending on http / https authorization parameters
#
# @example
#   influxdb::retention { 'retention': }
define influxdb::retention (
  Stdlib::Unixpath $path = '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin',
  String $retention = $title,
  String $database = 'database1',
  Enum['create', 'alter', 'drop'] $ensure = 'create',
  String $duration = '23h59m',
  Integer $replication = 1,
  String $default = 'DEFAULT',
  String $shard_duration = '2h',
  Boolean $https_enabled = $influxdb::https_enabled,
  Boolean $auth_enabled = $influxdb::auth_enabled,
  String $admin = $influxdb::admin,
  String $admin_password = $influxdb::admin_password,
) {
  Influxdb::Database <| database == $database |> -> Influxdb::Retention[$title]

  if ($https_enabled == true) {
  $cmd = 'influx -ssl -unsafeSsl' }
  else {
  $cmd = 'influx' }

  if ($auth_enabled == true) {
  $cmd_admin = " -username ${admin} -password ${admin_password}" }
  else {
  $cmd_admin = '' }

  case $ensure {
    'create': {
      exec { "create_retention_policy_${retention}_on_${database}":
        path    => $path,
        command => "${cmd}${cmd_admin} -execute 'CREATE RETENTION POLICY \"${retention}\" ON \"${database}\" \
DURATION ${duration} REPLICATION ${replication} SHARD DURATION ${shard_duration} ${default}'",
        unless  => "${cmd}${cmd_admin} -execute 'SHOW RETENTION POLICIES ON \"${database}\"' | grep ${retention}",
      }
    }
    'alter': {
      exec { "alter_retention_policy_${retention}_on_${database}":
        path    => $path,
        command => "${cmd}${cmd_admin} -execute 'ALTER RETENTION POLICY \"${retention}\" ON \"${database}\" \
DURATION ${duration} REPLICATION ${replication} SHARD DURATION ${shard_duration} ${default}'",
        onlyif  => "${cmd}${cmd_admin} -execute 'SHOW RETENTION POLICIES ON \"${database}\"' | grep ${retention}",
      }
    }
    'drop': {
      exec { "drop_retention_policy_${retention}_on_${database}":
        path    => $path,
        command => "${cmd}${cmd_admin} -execute 'DROP RETENTION POLICY \"${retention}\" ON \"${database}\"'",
        onlyif  => "${cmd}${cmd_admin} -execute 'SHOW RETENTION POLICIES ON \"${database}\"' | grep ${retention}",
      }
    }
    default: {}
  }
}
