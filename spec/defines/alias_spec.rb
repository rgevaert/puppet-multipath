require 'spec_helper'

describe 'multipath::alias', type: :define do

  let(:title) { 'test' }
  let(:default_params) { {
    wwid: '3600a098000b4c129000003e959fff7b3',
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
        it { is_expected.to contain_augeas('alias_test').with({
          :context => '/files/etc/multipath.conf/multipaths',
          :notify  => 'Class[Multipath::Service]',
        }) }

      end

#      context 'commands' do
#        describe 'no commands given' do
#          let(:params) { default_params.merge({
#            for_tags: 'not-important',
#            commands: [],
#          }) }
#          it { is_expected.to compile }
#        end
#      end

    end
  end
end
