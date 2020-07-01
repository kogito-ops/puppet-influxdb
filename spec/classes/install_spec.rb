require 'spec_helper'

describe 'influxdb::install', type: :class do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:params) {
        {
          'group' => 'influxdb',
          'group_system' => true,
          'user' => 'influxdb',
          'user_home' => '/var/lib/',
          'user_manage_home' => true,
          'user_system' => true,
        }
      }

      it do
        is_expected.to contain_class('influxdb::install')
        is_expected.to compile.with_all_deps
        is_expected.to contain_group('influxdb')
        is_expected.to contain_user('influxdb')
      end
    end
  end
end
