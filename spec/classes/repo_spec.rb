require 'spec_helper'

describe 'influxdb::repo', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }
    end

    context 'with :name => "Debian"' do
      if facts[:name] == 'Debian'
        let :params do
          {
            keys: '',
            keys_resource: 'apt::key',
            resource: 'apt::source',
            repositories: '',
          }
        end

        it { is_expected.to compile }
      end
    end

    context 'with :name => "Ubuntu"' do
      if facts[:name] == 'Ubuntu'
        let :params do
          {
            keys: '',
            keys_resource: 'apt::key',
            resource: 'apt::source',
            repositories: '',
          }
        end

        it { is_expected.to compile }
      end
    end

    context 'with :name => "CentOS"' do
      if facts[:name] == 'CentOS'
        let :params do
          {
            keys: '',
            keys_resource: '',
            resource: 'yumrepo',
            repositories: '',
          }
        end

        it { is_expected.to compile }
      end
    end
  end
end
