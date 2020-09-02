# frozen_string_literal: true

require 'spec_helper'

describe 'influxdb::repo', type: :class do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'on manage repo' do
        let :params do
          {
            'manage_repo' => true,
            'repo_location' => 'https://repos.influxdata.com/',
            'repo_type' => 'stable',
          }
        end

        it do
          is_expected.to compile.with_all_deps
          is_expected.to contain_class('influxdb::repo')

          case facts[:os]['family']
          when 'Debian'
            is_expected.to contain_apt__source('influxdata').with(
              'comment' => 'InfluxData repository',
              'location'   => "https://repos.influxdata.com/#{facts[:os]['name'].downcase}",
              'repos'      => 'stable',
              'key' => { 'id' => '05CE15085FC09D18E99EFB22684A14CF2582E0C5',
                         'source' => 'https://repos.influxdata.com/influxdb.key' },
            )
          when 'RedHat'
            is_expected.to contain_yumrepo('influxdata').with(
              'descr' => 'InfluxData Repository',
              'enabled'  => 1,
              'baseurl'  => "https://repos.influxdata.com/rhel/#{facts[:os]['release']['major']}/#{facts[:os]['architecture']}/stable",
              'gpgkey'   => 'https://repos.influxdata.com/influxdb.key',
              'gpgcheck' => 1,
            )
          end
        end
      end

      context 'on not manage repo' do
        let :params do
          {
            'manage_repo' => false,
            'repo_location' => 'https://repos.influxdata.com/',
            'repo_type' => 'stable',
          }
        end

        it do
          is_expected.to compile.with_all_deps
          is_expected.to contain_class('influxdb::repo')

          case facts[:os]['family']
          when 'Debian'
            is_expected.not_to contain_apt__source('influxdata')
          when 'RedHat'
            is_expected.not_to contain_yumrepo('influxdata')
          end
        end
      end
    end
  end
end
