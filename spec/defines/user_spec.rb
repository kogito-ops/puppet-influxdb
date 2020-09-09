# frozen_string_literal: true

require 'spec_helper'

describe 'influxdb::user' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      let(:title) { 'foo' }

      context 'with auth_enabled => true' do
        let :pre_condition do
          "class {'influxdb': }"
        end

        context 'when ensure => present and is_admin => true' do
          let :params do
            {
              ensure:         'present',
              auth_enabled:   true,
              password:       'bar',
              admin:          'foo',
              admin_password: 'bar',
              is_admin:       true,
            }
          end

          it { is_expected.to contain_exec('create_user_foo').with_command("influx -username foo -password 'bar' -execute \"CREATE USER \\\"foo\\\" WITH PASSWORD 'bar' WITH ALL PRIVILEGES\"") }
        end

        context 'when ensure => absent and is_admin => true' do
          let :params do
            {
              ensure:         'absent',
              auth_enabled:   true,
              password:       'bar',
              admin:          'foo',
              admin_password: 'bar',
              is_admin:       true,
            }
          end

          it { is_expected.to contain_exec('drop_user_foo').with_command("influx -username foo -password 'bar' -execute 'DROP USER \"foo\"'") }
        end

        context 'when ensure => present and is_admin => false' do
          let :params do
            {
              ensure:         'present',
              auth_enabled:   true,
              password:       'bar',
              admin:          'foo',
              admin_password: 'bar',
              is_admin:       false,
            }
        end

          it { is_expected.to contain_exec('create_user_foo').with_command("influx -username foo -password 'bar' -execute \"CREATE USER \\\"foo\\\" WITH PASSWORD 'bar' \"") }
        end

        context 'when ensure => absent and is_admin => false' do
          let :params do
            {
              ensure:         'absent',
              auth_enabled:   true,
              password:       'bar',
              admin:          'foo',
              admin_password: 'bar',
              is_admin:       false,
            }
          end

          it { is_expected.to contain_exec('drop_user_foo').with_command("influx -username foo -password 'bar' -execute 'DROP USER \"foo\"'") }
        end
      end

      context 'with auth_enabled => false' do
        let :pre_condition do
          "class {'influxdb': }"
        end

        context 'when ensure => present and is_admin => true' do
          let :params do
            {
              ensure:         'present',
              auth_enabled:   false,
              password:       'bar',
              admin:          'foo',
              admin_password: 'bar',
              is_admin:       true
            }
          end

          it { is_expected.to contain_exec('create_user_foo').with_command("influx -execute \"CREATE USER \\\"foo\\\" WITH PASSWORD 'bar' WITH ALL PRIVILEGES\"") }
        end

        context 'when ensure => absent and is_admin => true' do
          let :params do
            {
              ensure:         'absent',
              auth_enabled:   false,
              password:       'bar',
              admin:          'foo',
              admin_password: 'bar',
              is_admin:       true
            }
          end

          it { is_expected.to contain_exec('drop_user_foo').with_command("influx -execute 'DROP USER \"foo\"'") }
        end

        context 'when ensure => present and is_admin => false' do
          let :params do
            {
              ensure:         'present',
              auth_enabled:   false,
              password:       'bar',
              admin:          'foo',
              admin_password: 'bar',
              is_admin:       false
            }
          end

          it { is_expected.to contain_exec('create_user_foo').with_command("influx -execute \"CREATE USER \\\"foo\\\" WITH PASSWORD 'bar' \"") }
        end

      end
    end
  end
end
