require 'spec_helper'

describe 'influxdb::service', type: :class do
  on_supported_os.each do
    context 'with all defaults' do
      let :params do
        {
          service_name: 'influxdb',
          service_manage: 'running',
          service_enable: true,
          service_has_status: true,
          service_has_restart: true,
          service_provider: 'systemd',
        }
      end

      it { is_expected.to compile }
    end
  end
end
