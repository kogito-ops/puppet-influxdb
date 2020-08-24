include ::influxdb

# is there another influxdata module, which handles already the gpg key and the repo
class { 'influxdb':
  manage_repo => false,
}

# influxdb handels the gpg key and the repo
class { 'influxdb':
  manage_repo => true,
}

# define a database
influxdb::database { 'telegraf1':
  ensure => present,
}
# and a user
influxdb::user { 'telegraf1':
  password => 'metricsmetricsmetrics',
}
# with proper access
influxdb::grant { 'telegraf1':
  grant    => 'WRITE',
  database => 'telegraf',
}
