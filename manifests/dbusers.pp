# @summary Manages influxdb users.
#
# Manages influxdb db users

# @example
#   influxdb::dbuser
class influxdb::dbuser (
  $https_enable = $influxdb::https_enable,
  $http_auth_enabled = $influxdb::http_auth_enabled,
  Hash $defaults = [],
  String $dbuser_ssl = $influxdb::dbuser_ssl,
  String $dbuser_no_ssl = $influxdb::dbuser_no_ssl,
  $admin_username = $influxdb::admin_username,
  $admin_password = $influxdb::admin_password,
){

if $https_enable {
  $defaults = {'cmd' => $dbuser_ssl}
    } else {
    $defaults = {'cmd' => $dbuser_no_ssl}
}

if ($http_auth_enabled == true) {
  $defaults = {'cmd_admin' => "-username ${admin_username} -password' ${admin_password}"}
  } else {
  $defaults = {'cmd_admin' => ''}
}

$dbusers = lookup('influxdb::dbusers', Hash, 'deep', {})

  if $dbusers != {} {
    create_resources('influxdb::dbuser', $dbusers, $defaults)
  }

}
