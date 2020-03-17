# @summary Manages influxdb database retention.
#
# Manages influxdb database retention
#  - depending on http / https authorization enabled or not

# @example
#   influxdb::retention { 'retention': }
define influxdb::retention (
  String $cmd = 'influx',
  String $cmd_admin = '',
  String $path = '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin',
  String $retention = $title,
  String $database = 'database1',
  Enum['create', 'alter', 'drop'] $action = 'create',
  String $policy = 'retention1',
  String $duration = '23h60m',
  Integer $replication = 1,
  String $default = 'DEFAULT',
  String $shard_duration = '2h',
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

  case $action {
  'create': {
    exec {"create_retention_${retention}":
      path    => $path,
      command =>
        "${cmd} ${cmd_admin} \
        -execute 'CREATE RETENTION POLICY ${retention} ON \"${database}\" \
        DURATION \"${duration}\" REPLICATION \"${replication}\" \
        SHARD DURATION \"${shard_duration}\" \"${default}\"'",
      unless  =>
        "${cmd} ${cmd_admin} \
        -execute 'SHOW RETENTION POLICIES ON \"${database}\"'",
      require => Class['influxdb']
    }
  }
  'alter': {
    exec {"alter_retention_${retention}":
      path    => $path,
      command =>
        "${cmd} ${cmd_admin} \
        -execute 'ALTER RETENTION POLICY ${retention} ON \"${database}\" \
        DURATION \"${duration}\" REPLICATION \"${replication}\" \
        SHARD DURATION \"${shard_duration}\" \"${default}\"'",
      unless  =>
        "${cmd} ${cmd_admin} \
        -execute 'SHOW RETENTION POLICIES ON \"${database}\"'",
      require => Class['influxdb']
    }
  }
  'drop': {
    exec { "drop_retention_${retention}_on_${database}":
      path    => $path,
      command =>
        "${cmd} ${cmd_admin} \
        -execute 'DROP RETENTION POLICY ${retention} ON \"${database}\"'",
      onlyif  =>
        "${cmd} ${cmd_admin} \
        '-execute 'SHOW RETENTION POLICIES ON \"${database}\"'",
      require => Class['influxdb']
    }
  }
  default: {}
}
