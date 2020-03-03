require 'spec_helper'

describe 'influxdb::repo', type: :class do
  on_supported_os.each do |facts|
    context 'with :name => "Ubuntu"' do
      if facts[:name] == 'Ubuntu'
        let :params do
          {
            keys => lookup('influxdb::gpg_keys', Hash, 'deep', {}),
            key_resource: 'apt::key',
            resource: 'apt::source',
            repositories => lookup('influxdb::repositories', Hash, 'deep', {}),
          }
        end

        it { is_expected.to compile }
      end
    end

    context 'with :name => "Debian"' do
      if facts[:name] == 'Debian'
        let :params do
          {
            keys => lookup('influxdb::gpg_keys', Hash, 'deep', {}),
            key_resource: 'apt::key',
            resource: 'apt::source',
            repositories => lookup('influxdb::repositories', Hash, 'deep', {}),
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
            key_resource: '',
            resource: 'yumrepo',
            repositories => lookup('influxdb::repositories', Hash, 'deep', {}),
          }
        end

        it { is_expected.to compile }
      end
    end
  end
end
