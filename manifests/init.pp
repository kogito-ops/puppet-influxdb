# @summary Manages an InfluxDB server
#
# @example
#   include influxdb
class influxdb (

  $apt_keys = {
#   'influxdb'?
    ensure =>  present,
    id => '05CE15085FC09D18E99EFB22684A14CF2582E0C5',
    server => 'eu.pool.sks-keyservers.net',
    source => 'https://repos.influxdata.com/influxdb.key' },

  $apt_repos = {
#   'influxdb'?
    ensure =>  present,
    comment => 'InfluxData repository',
    location => 'https://repos.influxdata.com/ubuntu',
    release => '%{::os.distro.codename}',
    repos => 'stable',
    include => {
      src => false,
      deb => true }},

  $packages = {
#   'influxdb'?
    ensure =>  present,},

  String $configuration_path = '/etc/influxdb',
  String $configuration_file = 'influxdb.conf',
  String $service_defaults = '/etc/default/influxdb',
  String $service_definition = '/lib/systemd/system/influxdb.service',
  String $metadata_raft = '/var/lib/influxdb/meta',
  String $tsm_data = '/var/lib/influxdb/data',
  String $tsm_wal = '/var/lib/influxdb/wal',
  String $user = 'influxdb',
  String $group = 'influxdb',
  String $service_name = 'influxdb',
  String $service_provider = 'systemd',
  String $service_ensure = 'running',

) {

  include ::influxdb::repo
  include ::influxdb::install
  include ::influxdb::config
  contain ::influxdb::service

  Class['influxdb::repo'] ~> Class['influxdb::install']
  Class['influxdb::install'] ~> Class['influxdb::config', 'influxdb::service']
}
