require 'spec_helper'

describe 'influxdb::service', type: :class do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:params) {
        {
          'service_name' => 'influxdb',
          'service_ensure' => 'running',
          'service_enable' => true,
          'service_has_status' => true,
          'service_has_restart' => true,
          'service_provider' => 'systemd',
          'manage_service' => true,
        }
      }

      it do

        is_expected.to contain_class('influxdb::service')
        is_expected.to compile.with_all_deps
        is_expected.to contain_service('influxdb')

      end

    end
  end
end
