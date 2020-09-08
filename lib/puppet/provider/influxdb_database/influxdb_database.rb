# frozen_string_literal: true

require 'json'

Puppet::Type.type(:influxdb_database).provide(:database_management) do
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
    influx_cli('SHOW DATABASES').include?(resource[:database])
  end

  def create
    influx_cli("CREATE DATABASE #{resource[:database]}")
  end

  def destroy
    influx_cli("DROP DATABASE #{resource[:database]}")
  end
end
