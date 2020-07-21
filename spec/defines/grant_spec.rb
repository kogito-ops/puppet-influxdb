# frozen_string_literal: true

require 'spec_helper'

describe 'influxdb::grant' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      let(:title) { 'foo' }

      context 'with auth_enabled => true' do
        let :pre_condition do
          "class {'influxdb': }"
        end

        context 'when ensure => present' do
          let :params do
            {
              ensure:         'present',
              auth_enabled:   true,
              grant:          'ALL',
              database:       'foo',
              admin:          'foo',
              admin_password: 'bar',
            }
          end

          it { is_expected.to contain_exec('grant_ALL_on_foo_to_foo').with_command("influx -username foo -password bar -execute 'GRANT ALL ON \"foo\" TO \"foo\"'") }
        end

        context 'when ensure => absent' do
          let :params do
            {
              ensure:         'absent',
              auth_enabled:   true,
              grant:          'ALL',
              database:       'foo',
              admin:          'foo',
              admin_password: 'bar',
            }
          end

          it { is_expected.to contain_exec('revoke_ALL_on_foo_for_foo').with_command("influx -username foo -password bar -execute 'REVOKE ALL ON \"foo\" TO \"foo\"'") }
        end
      end

      context 'with auth_enabled => false' do
        let :pre_condition do
          "class {'influxdb': }"
        end

        context 'when ensure => present' do
          let :params do
            {
              ensure:         'present',
              auth_enabled:   false,
              grant:          'ALL',
              database:       'foo',
              admin:          'foo',
              admin_password: 'bar',
            }
          end

          it { is_expected.to contain_exec('grant_ALL_on_foo_to_foo').with_command("influx -execute 'GRANT ALL ON \"foo\" TO \"foo\"'") }
        end

        context 'when ensure => absent' do
          let :params do
            {
              ensure:         'absent',
              auth_enabled:   false,
              grant:          'ALL',
              database:       'foo',
              admin:          'foo',
              admin_password: 'bar',
            }
          end

          it { is_expected.to contain_exec('revoke_ALL_on_foo_for_foo').with_command("influx -execute 'REVOKE ALL ON \"foo\" TO \"foo\"'") }
        end
      end
    end
  end
end
