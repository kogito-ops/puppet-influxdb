require 'spec_helper'

describe 'influxdb::repo', type: :class do
  on_supported_os.each do
    context 'with all defaults' do
      let :params do
        {
          key_resource: '',
          resource: '',
          manage_repo: true
        }
      end

      it { is_expected.to compile }
    end
  end
end
