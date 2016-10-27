require 'spec_helper'

describe 'powerdns', type: 'class' do

  ['RedHat', 'CentOS', 'Fedora', 'Scientific', 'Amazon', 'OracleLinux'].each do |distro|

    context "on #{distro} OS" do

      let(:facts) { {
        operatingsystem: distro,
        kernel:          'Linux',
        osfamily:        'RedHat'
      } }


      let(:config_file_path) { '/etc/pdns' }
      let(:service_name)     { 'pdns' }
      let(:package_name)     { ['pdns', 'pdns-tools'] }
      let(:config_file)      { 'pdns.conf' }

      context 'tests with the default parameters' do

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to create_class('powerdns') }
        it { is_expected.to contain_class('powerdns::params') }

        it { is_expected.to contain_powerdns__config("#{config_file}") }
        it { is_expected.to create_file("#{config_file_path}/#{config_file}") }

        it do
          package_name.each do |package|
            is_expected.to contain_powerdns__install(package)
            is_expected.to contain_package(package)
          end
        end

        it { is_expected.to contain_powerdns__service("#{service_name}") }
        it { is_expected.to contain_service("#{service_name}") }

      end # en contex init class

    end # contex distro

  end # do distro

end # powerdns
