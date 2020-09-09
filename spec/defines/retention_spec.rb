# frozen_string_literal: true

require 'spec_helper'

describe 'influxdb::retention' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      let(:title) { 'foo on foo' }

      context 'with auth_enabled => true' do
        let :pre_condition do
          "class {'influxdb': }"
        end

        context 'when ensure => present' do
          let :params do
            {
              ensure:         'present',
              auth_enabled:   true,
              database:       'foo',
              retention:      'foo',
              admin:          'foo',
              admin_password: 'bar',
            }
          end

          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_influxdb__retention('foo on foo').with(
            'ensure' => 'present',
            'database' => 'foo',
            'retention' => 'foo',
            'auth_enabled'   => true,
            'admin' => 'foo',
            'admin_password' => 'bar') }
        end

        context 'when ensure => absent' do
          let :params do
            {
              ensure:         'absent',
              auth_enabled:   true,
              database:       'foo',
              admin:          'foo',
              admin_password: 'bar',
            }
          end

          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_influxdb__retention('foo on foo').with(
            'ensure' => 'absent',
            'database' => 'foo',
            'auth_enabled'   => true,
            'admin' => 'foo',
            'admin_password' => 'bar') }
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
              database:       'foo',
              admin:          'foo',
              admin_password: 'bar',
            }
          end

          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_influxdb__retention('foo on foo').with(
            'ensure' => 'present',
            'database' => 'foo',
            'auth_enabled'   => false,
            'admin' => 'foo',
            'admin_password' => 'bar') }
        end

        context 'when ensure => absent' do
          let :params do
            {
              ensure:         'absent',
              auth_enabled:   false,
              database:       'foo',
              admin:          'foo',
              admin_password: 'bar',
            }
          end

          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_influxdb__retention('foo on foo').with(
            'ensure' => 'absent',
            'database' => 'foo',
            'auth_enabled'   => false,
            'admin' => 'foo',
            'admin_password' => 'bar') }
        end
      end
    end
  end
end
