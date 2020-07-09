require 'spec_helper'

describe 'influxdb', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os} " do
      let :facts do
        facts
      end

      context 'with all defaults' do
        let :params do
          {
            'manage_repo' => true,
            'package_name' => 'influxdb',
            'ensure' => 'present',
            'repo_location' => 'https://repos.influxdata.com/',
            'repo_type' => 'stable',
            'group' => 'influxdb',
            'group_system' => true,
            'user' => 'influxdb',
            'user_system' => true,
            'user_manage_home' => true,
            'user_home' => '/var/lib/',
            'configuration_path' => '/etc/influxdb',
            'configuration_file' => 'influxdb.conf',
            'configuration_template' => 'influxdb/influxdb.conf.erb',
            'service_defaults' => '/etc/default/influxdb',
            'service_default_template' => 'influxdb/service-defaults.erb',
            'service_definition' => '/lib/systemd/system/influxdb.service',
            'service_definition_template' => 'influxdb/systemd.service.erb',
            'service_name' => 'influxdb',
            'service_provider' => 'systemd',
            'service_ensure' => 'running',
            'service_enable' => true,
            'service_has_status' => true,
            'service_has_restart' => true,
            'manage_service' => true,
            'notify_service' => true,
            'admin' => 'admin',
            'admin_password' => '',
            'users' => {},
            'grants' => {},
            'databases' => {},
            'retentions' => {},
            'reporting_disabled' => false,
            'rpc_bind_address' => '127.0.0.1:8088',
            'metadata_raft' => '/var/lib/influxdb/meta',
            'meta_obligatory' => {
              'dir' => '/var/lib/influxdb/meta',
            },
            'tsm_data' => '/var/lib/influxdb/data',
            'tsm_wal' => '/var/lib/influxdb/wal',
            'series_id_set_cache_size' => 100,
            'data_obligatory' => {
              'dir' => '/var/lib/influxdb/data',
              'wal-dir' => '/var/lib/influxdb/wal',
              'series-id-set-cache-size' => 100,
            },
            'https_enabled' => false,
            'auth_enabled' => false,
            'http_obligatory' => {
              'https-enabled' => false,
              'auth-enabled' => false,
            },
            'meta' => {},
            'data' => {},
            'coordinator' => {},
            'retention' => {},
            'shard_precreation' => {},
            'monitor' => {},
            'http' => {},
            'logging' => {},
            'subscriber' => {},
            'graphite' => {},
            'collectd' => {},
            'opentsdb' => {},
            'udp' => {},
            'continuous_queries' => {},
            'tls' => {},
          }
        end

        it do
          is_expected.to compile.with_all_deps
          if facts[:osfamily] == 'Debian'
            is_expected.to contain_class('influxdb')
            is_expected.to have_class_count(9)
            is_expected.to have_resource_count(27)
            is_expected.to contain_class('influxdb::repo').that_comes_before('Class[influxdb::install]')
            is_expected.to contain_class('influxdb::install').that_comes_before(['Class[influxdb::config]', 'Class[influxdb::service]'])
            is_expected.to contain_class('influxdb::config').that_notifies('Class[influxdb::service]')
            is_expected.to contain_exec('is_influx_already_listening')
          end
          # TODO: CentOS yumrepo
        end
      end
    end
  end
end
