Puppet::Type.newtype(:influxdb_database) do
    @doc = 'Create or drop a database in InfluxDB'
    feature :database_management, 'require rest api', methods: [:database_management]
    ensurable
    newparam(:name, namevar: true) do
        desc 'Unique name of resource'
    end
    newparam(:cmd) do
        desc 'Command depending on https_enabled'
    end
    newparam(:cmd_admin) do
        desc 'Admin and password depending on auth_enabled'
    end
    newparam(:admin) do
        desc 'Admin'
    end
    newparam(:admin_password) do
        desc 'Admin password'
    end
    newparam(:auth_enabled) do
        desc 'Authentication enabled'
    end
    newparam(:database) do
        desc 'Database to create or to drop'
    end
  end
