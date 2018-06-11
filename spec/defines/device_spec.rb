require 'spec_helper'

describe 'multipath::device', type: :define do

  let(:title) { 'mydevice' }
  let(:default_params) { {
    :vendor => 'DELL',
  } }

  let(:pre_condition) {
    "
    include ::multipath
    "
  }
  # Not testing on all supported operating systems but just debian since
  # we don't have any os specific config in our define.
  #on_supported_os( supported_os: [ operatingsystem: 'Debian' ]).each do |os, facts|
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) {
        facts
      }

      context 'no parameters' do
        let(:params) { default_params.merge({
        }) }
        it { is_expected.to compile }
        it { is_expected.to contain_augeas('device_mydevice').with({
          :context => '/files/etc/multipath.conf/devices',
          :notify  => 'Class[Multipath::Service]',
        }) }

      end

    end
  end
end
