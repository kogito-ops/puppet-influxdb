# @summary Manages retentions of databases
#     depending on http / https authorization parameters
#
# @example
#   influxdb::retention { 'retention': }
define influxdb::retention (
  Stdlib::Unixpath $path = '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin',
  String $retention = regsubst($title, '^(\S+)\s+on\s+(\S+)$', '\1'),
  String $database = regsubst($title, '^(\S+)\s+on\s+(\S+)$', '\1'),
  Enum['present', 'absent'] $ensure = 'present',
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

  if $https_enabled {
  $cmd = 'influx -ssl -unsafeSsl' }
  else {
  $cmd = 'influx' }

  if $auth_enabled {
  $cmd_admin = " -username ${admin} -password \'${admin_password}\'" }
  else {
  $cmd_admin = '' }

  influxdb_retention { "${retention} on ${database}":
    ensure         => $ensure,
    cmd            => $cmd,
    cmd_admin      => $cmd_admin,
    admin          => $admin,
    admin_password => $admin_password,
    auth_enabled   => $auth_enabled,
    retention      => $retention,
    database       => $database,
    duration       => $duration,
    replication    => $replication,
    default        => $default,
    shard_duration => $shard_duration,
  }
}
