require 'spec_helper'

describe 'influxdb::install', type: :class do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
    end

    context 'with all defaults' do
      let :params do
        {
          package: 'influxdb',
          package_manage: 'present',
          group: 'influxdb',
          group_manage: 'present',
          group_system: true,
          user: 'influxdb',
          user_manage: 'present',
          user_home: '/var/lib/',
          user_manage_home: true,
          user_system: true,
        }
      end

      it { is_expected.to compile }
    end
  end
end
