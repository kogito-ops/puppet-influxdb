require 'spec_helper'

describe 'influxdb::repo', type: :class do
  on_supported_os.each do |facts|
    context 'with all defaults' do
      let :params do
        {
          key_resource: '',
          resource: '',
        }
      end

      it { is_expected.to compile }
    end
  end
end
