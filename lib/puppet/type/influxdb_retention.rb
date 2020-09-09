Puppet::Type.newtype(:influxdb_retention) do
  @doc = 'Create or drop a retention within InfluxDB'
  feature :retention_management, 'require rest api', methods: [:retention_management]
  ensurable
  newparam(:name) do
      desc 'Name of the resource'
  end
  newparam(:cmd) do
    desc 'Command depending on https_enabled'
  end
  newparam(:cmd_admin) do
    desc 'Admin and password depending on auth_enabled'
  end
  newparam(:admin) do
      desc 'Admin of the resource'
  end
  newparam(:admin_password) do
      desc 'Admin password'
  end
  newparam(:auth_enabled) do
    desc 'Authentication enabled'
  end
  newparam(:retention, namevar: true) do
    desc 'Retention to manage'
  end
  newparam(:database, namevar: true) do
    desc 'On which database retention is managed'
  end
  newparam(:duration) do
    desc 'Duration'
  end
  newparam(:replication) do
    desc 'Replication'
  end
  newparam(:default) do
    desc 'Is retention the default'
  end
  newparam(:shard_duration) do
    desc 'Shard duration'
  end
  def self.title_patterns
    [
      [
        /^((\S+)\s+on\s+(.+))$/,
        [
          [ :name ],
          [ :retention ],
          [ :database ],
        ],
      ],
      [
        /(.*)/,
        [
          [ :name ],
        ],
      ],
    ]
  end
end
