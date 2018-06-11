require 'spec_helper'

describe 'multipath' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "multipath class without any parameters" do
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_class('multipath') }
          it { is_expected.to contain_class('multipath::params') }
          it { is_expected.to contain_class('multipath::install') }
          it { is_expected.to contain_class('multipath::service') }
          it { is_expected.to contain_class('multipath::config') }

          it { is_expected.to contain_augeas('conf_comment') }
          it { is_expected.to contain_augeas('verbosity') }
          it { is_expected.to contain_file('/etc/multipath.conf') }

          case facts[:operatingsystem]
          when 'Debian'
            it { is_expected.to contain_package('multipath-tools') }
            it { is_expected.to contain_service('multipath-tools') }
            it { is_expected.to contain_package('multipath-tools-boot').with_ensure('purged') }
          when 'RedHat', 'CentOS', 'ScientificLinux'
            it { is_expected.to contain_package('device-mapper-multipath') }
            it { is_expected.to contain_service('multipathd') }
          end

          # Test of create_resources through hiera
          it { is_expected.to have_multipath__alias_resource_count(0) }
        end

        context "multipath class aliases in hash" do
          let :params do
          {
            :aliases => {'mylun' => { 'wwid' => '3600a098000b4c129000003e959fff7b3' }}
          }
          end

          it { is_expected.to compile.with_all_deps }
          it { is_expected.to have_multipath__alias_resource_count(1) }
          it { is_expected.to contain_multipath__alias('mylun') }
          it { is_expected.to contain_augeas('alias_mylun') }
        end

        context "multipath class device in hash" do
          let :params do
          {
            :devices => {'mydevice' => { 'vendor' => 'myvendor' }}
          }
          end

          it { is_expected.to compile.with_all_deps }
          it { is_expected.to have_multipath__device_resource_count(1) }
          it { is_expected.to contain_multipath__device('mydevice') }
          it { is_expected.to contain_augeas('device_mydevice') }
        end
      end
    end
  end

end
