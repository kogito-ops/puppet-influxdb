require 'spec_helper'

describe 'influxdb::install', type: :class do
  on_supported_os.each do
    context 'with all defaults' do
      let :params do
        {
          package: 'influxdb',
          ensure: 'present',
          group: 'influxdb',
          group_system: true,
          user: 'influxdb',
          user_home: '/var/lib/',
          user_manage_home: true,
          user_system: true,
        }
      end

      it { is_expected.to compile }
    end
  end
end
