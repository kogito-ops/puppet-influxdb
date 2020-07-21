# frozen_string_literal: true

require 'spec_helper'

describe 'influxdb::database' do
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
              :ensure         => 'present',
              :auth_enabled   => true,
              :admin          => 'foo',
              :admin_password => 'bar',
            }
          end

          it { is_expected.to contain_exec('create_database_foo').with_command("influx -username foo -password bar -execute 'CREATE DATABASE foo'") }
        end

        context 'when ensure => absent' do
          let :params do
            {
              :ensure         => 'absent',
              :auth_enabled   => true,
              :admin          => 'foo',
              :admin_password => 'bar',
            }
          end

          it { is_expected.to contain_exec('drop_database_foo').with_command("influx -username foo -password bar -execute 'DROP DATABASE foo'") }
        end
      end

      context 'with auth_enabled => false' do
        let :pre_condition do
          "class {'influxdb': }"
        end

        context 'when ensure => present' do
          let :params do
            {
              :ensure         => 'present',
              :auth_enabled   => false,
              :admin          => 'foo',
              :admin_password => 'bar',
            }
          end

          it { is_expected.to contain_exec('create_database_foo').with_command("influx -execute 'CREATE DATABASE foo'") }
        end

        context 'when ensure => absent' do
          let :params do
            {
              :ensure         => 'absent',
              :auth_enabled   => false,
              :admin          => 'foo',
              :admin_password => 'bar',
            }
          end

          it { is_expected.to contain_exec('drop_database_foo').with_command("influx -execute 'DROP DATABASE foo'") }
        end
      end
    end
  end
end
