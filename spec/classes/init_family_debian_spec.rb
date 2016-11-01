require 'spec_helper'

describe 'powerdns', type: 'class' do

  ['Debian', 'Ubuntu'].each do |distro|

    context "on #{distro} OS" do

      let :facts do
        {
          'operatingsystem' => distro,
          'kernel'          => 'Linux',
          'osfamily'        => 'Debian',
          'lsbdistid'       => 'Debian'
        }
      end

      let(:config_file_path) { '/etc/powerdns' }
      let(:service_name)     { 'pdns' }
      let(:package_name)     { 'pdns-server' }
      let(:config_file)      { 'pdns.conf' }
      let(:include_dir)      { "#{config_file_path}/pdns.d" }


      context 'tests with the default parameters' do

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to create_class('powerdns') }
        it { is_expected.to contain_class('powerdns::params') }

        it { is_expected.to contain_powerdns__config("#{config_file}") }
        it { is_expected.to create_file("#{config_file_path}/#{config_file}") }
        it { is_expected.to create_file("#{include_dir}") }

        it { is_expected.to contain_powerdns__install("#{package_name}") }
        it { is_expected.to contain_package("#{package_name}") }

        it { is_expected.to contain_powerdns__service("#{service_name}") }
        it { is_expected.to contain_service("#{service_name}") }

      end # en contex init class

    end # contex distro

  end # do distro

end # powerdns
