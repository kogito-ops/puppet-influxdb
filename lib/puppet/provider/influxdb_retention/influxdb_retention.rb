# frozen_string_literal: true

require 'json'

Puppet::Type.type(:influxdb_retention).provide(:retention_management) do
  def influx_cli(command)
    if (resource[:auth_enabled])
      `"#{resource[:cmd]}" -execute "#{command}" -username "#{resource[:admin]}" -password "#{resource[:admin_password]}" -format json`
    else
      `"#{resource[:cmd]}" -execute "#{command}" -format json`
    end
  end

  mk_resource_methods

  # OVERRIDDEN PUPPET FUNCTIONS #
  def exists?
    influx_cli("SHOW RETENTION POLICIES on #{resource[:database]}").include?(resource[:retention])
  end

  def create
    influx_cli("CREATE RETENTION POLICY #{resource[:retention]} ON #{resource[:database]} DURATION #{resource[:duration]} REPLICATION #{resource[:replication]} SHARD DURATION #{resource[:shard_duration]} #{resource[:default]}")
  end

  def destroy
    influx_cli("DROP RETENTION POLICY #{resource[:retention]} ON #{resource[:database]}")
  end
end
