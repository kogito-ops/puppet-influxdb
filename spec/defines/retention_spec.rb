# frozen_string_literal: true

require 'spec_helper'

describe 'influxdb::retention' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      let(:title) { 'foo' }

      context 'with auth_enabled => true' do
        let :pre_condition do
          "class {'influxdb': }"
        end

        context 'when ensure => create' do
          let :params do
            {
              ensure:         'create',
              auth_enabled:   true,
              database:       'foo',
              admin:          'foo',
              admin_password: 'bar',
            }
          end

          it { is_expected.to contain_exec('create_retention_policy_foo_on_foo')
            .with_command("influx -username foo -password bar -execute 'CREATE RETENTION POLICY \"foo\" ON \"foo\" DURATION 23h59m REPLICATION 1 SHARD DURATION 2h DEFAULT'") }
        end

        context 'when ensure => alter' do
          let :params do
            {
              ensure:         'alter',
              auth_enabled:   true,
              database:       'foo',
              admin:          'foo',
              admin_password: 'bar',
            }
          end

          it { is_expected.to contain_exec('alter_retention_policy_foo_on_foo')
            .with_command("influx -username foo -password bar -execute 'ALTER RETENTION POLICY \"foo\" ON \"foo\" DURATION 23h59m REPLICATION 1 SHARD DURATION 2h DEFAULT'") }
        end

        context 'when ensure => drop' do
          let :params do
            {
              ensure:         'drop',
              auth_enabled:   true,
              database:       'foo',
              admin:          'foo',
              admin_password: 'bar',
            }
          end

          it { is_expected.to contain_exec('drop_retention_policy_foo_on_foo')
            .with_command("influx -username foo -password bar -execute 'DROP RETENTION POLICY \"foo\" ON \"foo\"'") }
        end
      end

      context 'with auth_enabled => false' do
        let :pre_condition do
          "class {'influxdb': }"
        end

        context 'when ensure => create' do
          let :params do
            {
              ensure:         'create',
              auth_enabled:   false,
              database:       'foo',
              admin:          'foo',
              admin_password: 'bar',
            }
          end

          it { is_expected.to contain_exec('create_retention_policy_foo_on_foo')
            .with_command("influx -execute 'CREATE RETENTION POLICY \"foo\" ON \"foo\" DURATION 23h59m REPLICATION 1 SHARD DURATION 2h DEFAULT'") }
        end

        context 'when ensure => alter' do
          let :params do
            {
              ensure:         'alter',
              auth_enabled:   false,
              database:       'foo',
              admin:          'foo',
              admin_password: 'bar',
            }
          end

          it { is_expected.to contain_exec('alter_retention_policy_foo_on_foo')
            .with_command("influx -execute 'ALTER RETENTION POLICY \"foo\" ON \"foo\" DURATION 23h59m REPLICATION 1 SHARD DURATION 2h DEFAULT'") }
        end

        context 'when ensure => drop' do
          let :params do
            {
              ensure:         'drop',
              auth_enabled:   false,
              database:       'foo',
              admin:          'foo',
              admin_password: 'bar',
            }
          end

          it { is_expected.to contain_exec('drop_retention_policy_foo_on_foo')
            .with_command("influx -execute 'DROP RETENTION POLICY \"foo\" ON \"foo\"'") }
        end
      end
    end
  end
end
