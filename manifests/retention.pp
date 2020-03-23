# @summary Manages influxdb database retention.
#
# Manages influxdb database retention
#  - depending on http / https authorization enabled or not

# @example
#   influxdb::retention { 'retention': }
define influxdb::retention (
  String $path = '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin',
  String $retention = $title,
  String $database = 'database1',
  Enum['create', 'alter', 'drop'] $action = 'create',
  String $duration = '23h59m',
  Integer $replication = 1,
  String $default = 'DEFAULT',
  String $shard_duration = '2h',
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

  case $action {
  'create': {
    exec {"create_retention_${retention}":
      path    => $path,
      command =>
        "${cmd} ${cmd_admin} \
        -execute 'CREATE RETENTION POLICY \"${retention}\" ON \"${database}\" \
        DURATION ${duration} REPLICATION ${replication} \
        SHARD DURATION ${shard_duration} ${default}\'",
      unless  =>
        "${cmd} ${cmd_admin} \
        -execute 'SHOW RETENTION POLICIES ON \"${database}\"'",
    }
  }
  'alter': {
    exec {"alter_retention_${retention}":
      path    => $path,
      command =>
        "${cmd} ${cmd_admin} \
        -execute 'ALTER RETENTION POLICY \"${retention}\" ON \"${database}\" \
        DURATION ${duration} REPLICATION ${replication} \
        SHARD DURATION ${shard_duration} ${default}'",
      unless  =>
        "${cmd} ${cmd_admin} \
        -execute 'SHOW RETENTION POLICIES ON \"${database}\"'",
    }
  }
  'drop': {
    exec { "drop_retention_${retention}_on_${database}":
      path    => $path,
      command =>
        "${cmd} ${cmd_admin} \
        -execute 'DROP RETENTION POLICY \"${retention}\" ON \"${database}\"'",
      onlyif  =>
        "${cmd} ${cmd_admin} \
        '-execute 'SHOW RETENTION POLICIES ON \"${database}\"'",
    }
  }
  default: {}
  }
}
