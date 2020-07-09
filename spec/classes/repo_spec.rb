require 'spec_helper'

describe 'influxdb::repo', type: :class do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let :params do
        {
          'manage_repo' => true,
          'package_name' => 'influxdb',
          'ensure' => 'present',
          'repo_location' => 'https://repos.influxdata.com/',
          'repo_type' => 'stable',
        }
      end

      it { is_expected.to compile.with_all_deps }

      it do
        if facts[:osfamily] == 'Debian'
          is_expected.to contain_class('influxdb::repo')
          is_expected.to contain_package('influxdb')
          is_expected.to contain_class('apt')
        end

        if facts[:osname] == 'CentOS'
          is_expected.to contain_class('influxdb::repo')
          is_expected.to contain_package('influxdb')
          is_expected.to contain_yumrepo('influxdata')
        end
      end
    end
  end
end
