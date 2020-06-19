require 'spec_helper'

describe 'influxdb::config', type: :class do
  on_supported_os.each do
    context 'with all defaults' do
      let :params do
        {
          configuration_path: '/etc/influxdb',
          configuration_file: 'influxdb.conf',
          configuration_template: 'influxdb/influxdb.conf.erb',
          service_defaults: '/etc/default/influxdb',
          service_default_template: 'influxdb/service-defaults.erb',
          service_definition: '/lib/systemd/system/influxdb.service',
          service_definition_template: 'influxdb/systemd.service.erb',
          tsm_data: '/var/lib/influxdb/data',
          tsm_wal: '/var/lib/influxdb/wal',
          metadata_raft: '/var/lib/influxdb/meta',
          group: 'influxdb',
          user: 'influxdb',
        }
      end

      it { is_expected.to compile }
    end
  end
end
