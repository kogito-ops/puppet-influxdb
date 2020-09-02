# frozen_string_literal: true

require 'spec_helper'

describe 'influxdb::config', type: :class do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'with all defaults' do
        let :params do
          {
            'configuration_path' => '/etc/influxdb',
            'configuration_file' => 'influxdb.conf',
            'configuration_template' => 'influxdb/influxdb.conf.erb',
            'service_defaults' => '/etc/default/influxdb',
            'service_default_template' => 'influxdb/service-defaults.erb',
            'service_definition' => '/lib/systemd/system/influxdb.service',
            'service_definition_template' => 'influxdb/systemd.service.erb',
            'group' => 'bar',
            'user' => 'foo',
            'reporting_disabled' => false,
            'rpc_bind_address' => '127.0.0.1:9999',
            'metadata_raft' => '/var/lib/influxdb/meta',
            'tsm_data' => '/var/lib/influxdb/data',
            'tsm_wal' => '/var/lib/influxdb/wal',
            'series_id_set_cache_size' => 100,
            'https_enabled' => false,
            'auth_enabled' => false,
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
            'meta_obligatory' => {
              'dir' => '/var/lib/influxdb/meta',
            },
            'data_obligatory' => {
              'dir' => '/var/lib/influxdb/data',
              'wal-dir' => '/var/lib/influxdb/wal',
              'series-id-set-cache-size' => 777,
            },
            'http_obligatory' => {
              'https-enabled' => false,
              'auth-enabled' => false,
            },
          }
        end

        it do
          is_expected.to compile.with_all_deps
          is_expected.to contain_file('/etc/influxdb')
          is_expected.to contain_file('/etc/influxdb/influxdb.conf')
            .with_content(%r{reporting-disabled = false})
            .with_content(%r{bind-address = \"127.0.0.1:9999\"})
            .with_content(%r{[data]})
            .with_content(%r{dir = \"\/var\/lib\/influxdb\/data\"})
            .with_content(%r{wal-dir = \"\/var\/lib\/influxdb\/wal\"})
            .with_content(%r{series-id-set-cache-size = 777})
          is_expected.to contain_file('/etc/default/influxdb')
          is_expected.to contain_file('/var/lib/influxdb/data')
            .with(owner: 'foo', group: 'bar')
          is_expected.to contain_file('/var/lib/influxdb/wal')
            .with(owner: 'foo', group: 'bar')
          is_expected.to contain_file('/var/lib/influxdb/meta')
            .with(owner: 'foo', group: 'bar')
          is_expected.to contain_class('influxdb::config')
          if facts[:os]['family'] == 'Debian'
            is_expected.to contain_file('/lib/systemd/system/influxdb.service')
              .with_content(%r{User=foo})
              .with_content(%r{Group=bar})
              .with_content(%r{EnvironmentFile=-\/etc\/default\/influxdb})
              .with_content(%r{ExecStart=\/usr\/bin\/influxd -config \/etc\/influxdb\/influxdb.conf \$INFLUXD_OPTS})
          end
        end
      end

      context 'on RedHat' do
        let :params do
          {
            'configuration_path' => '/etc/influxdb',
            'configuration_file' => 'influxdb.conf',
            'configuration_template' => 'influxdb/influxdb.conf.erb',
            'service_defaults' => '/etc/default/influxdb',
            'service_default_template' => 'influxdb/service-defaults.erb',
            'service_definition' => '/etc/systemd/system/influxdb.service',
            'service_definition_template' => 'influxdb/systemd.service.erb',
            'group' => 'foo',
            'user' => 'bar',
            'reporting_disabled' => false,
            'rpc_bind_address' => '127.0.0.1:9999',
            'metadata_raft' => '/var/lib/influxdb/meta',
            'tsm_data' => '/var/lib/influxdb/data',
            'tsm_wal' => '/var/lib/influxdb/wal',
            'series_id_set_cache_size' => 100,
            'https_enabled' => false,
            'auth_enabled' => false,
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
            'meta_obligatory' => {
              'dir' => '/var/lib/influxdb/meta',
            },
            'data_obligatory' => {
              'dir' => '/var/lib/influxdb/data',
              'wal-dir' => '/var/lib/influxdb/wal',
              'series-id-set-cache-size' => 100,
            },
            'http_obligatory' => {
              'https-enabled' => false,
              'auth-enabled' => false,
            },
          }
        end

        it do
          if facts[:os]['family'] == 'RedHat'
            is_expected.to contain_file('/etc/systemd/system/influxdb.service')
              .with_content(%r{User=bar})
              .with_content(%r{Group=foo})
              .with_content(%r{EnvironmentFile=-\/etc\/default\/influxdb})
              .with_content(%r{ExecStart=\/usr\/bin\/influxd -config \/etc\/influxdb\/influxdb.conf \$INFLUXD_OPTS})
          end
        end
      end
    end
  end
end
