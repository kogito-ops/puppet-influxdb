require 'spec_helper'

describe 'influxdb::config', type: :class do
  on_supported_os.each do
    context 'with all defaults' do
      let :params do
        {
          configuration_path: '/etc/influxdb',
          configuration_path_manage: 'directory',
          configuration_file: 'influxdb.conf',
          configuration_file_manage: 'present',
          configuration_template: 'influxdb/influxdb.conf.erb',
          service_defaults: '/etc/default/influxdb',
          service_defaults_manage: 'present',
          service_default_template: 'influxdb/service-defaults.erb',
          service_definition: '/lib/systemd/system/influxdb.service',
          service_definition_manage: 'present',
          service_definition_template: 'influxdb/systemd.service.erb',
          tsm_data: '/var/lib/influxdb/data',
          tsm_data_manage: 'directory',
          tsm_wal: '/var/lib/influxdb/wal',
          tsm_wal_manage: 'directory',
          metadata_raft: '/var/lib/influxdb/meta',
          metadata_raft_manage: 'directory',
          group: 'influxdb',
          user: 'influxdb',
        }
      end

      it { is_expected.to compile }
    end
  end
end
