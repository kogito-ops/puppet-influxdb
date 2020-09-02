#include ::influxdb

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
  ensure         => present,
  https_enabled  => false,
  auth_enabled   => true,
  admin          => 'admin',
  admin_password => 'foo',
}

# retention policies
influxdb::retention { 'foo':
  ensure         => 'create',
  database       => 'telegraf1',
  duration       => '7h30m',
  replication    => 1,
  default        => 'DEFAULT',
  shard_duration => '3h59m',
  https_enabled  => false,
  auth_enabled   => true,
  admin          => 'admin',
  admin_password => 'foo',
}

influxdb::retention { 'bar':
  ensure         => 'create',
  database       => 'telegraf1',
  duration       => '5h20m',
  replication    => 1,
  default        => '',
  shard_duration => '0h5m',
  https_enabled  => false,
  auth_enabled   => true,
  admin          => 'admin',
  admin_password => 'foo',
}

# and a user
influxdb::user { 'telegraf1':
  ensure         => present,
  password       => 'metricsmetricsmetrics',
  https_enabled  => false,
  auth_enabled   => true,
  admin          => 'admin',
  admin_password => 'foo',
}

# with proper access
influxdb::grant { 'telegraf1':
  grant          => 'WRITE',
  database       => 'telegraf1',
  https_enabled  => false,
  auth_enabled   => true,
  admin          => 'admin',
  admin_password => 'foo',
}
