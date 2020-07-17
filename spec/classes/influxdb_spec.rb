# frozen_string_literal: true

require 'spec_helper'

describe 'influxdb', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os} " do
      let :facts do
        facts
      end

      it do
        is_expected.to compile.with_all_deps
        is_expected.to contain_class('influxdb')
        is_expected.to contain_class('influxdb::repo').that_comes_before('Class[influxdb::install]')
        is_expected.to contain_class('influxdb::install').that_comes_before(['Class[influxdb::config]', 'Class[influxdb::service]'])
        is_expected.to contain_exec('is_influx_already_listening')

        case facts[:os]['name']
        when 'Debian', 'Ubuntu'
          is_expected.to have_class_count(10)
          is_expected.to have_resource_count(26)
        when 'CentOS'
          is_expected.to have_class_count(7)
          is_expected.to have_resource_count(12)
        end
      end
    end
  end
end
