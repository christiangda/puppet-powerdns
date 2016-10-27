require 'spec_helper'

describe 'powerdns::backend', type: 'class' do

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

      let(:user)  { 'pdns' }
      let(:group) { 'pdns' }

      let(:backend_name)       { 'mysql' }
      let(:config_file_backup) { true }
      let(:config_file_path)   { '/etc/powerdns' }
      let(:backend_conf_path)  { "#{config_file_path}/pdns.d" }
      let(:default_backend_config_file_prefix) { 'pdns.local' }

      let(:config_file) { "#{backend_conf_path}/#{default_backend_config_file_prefix}.g#{backend_name}.conf" }

      let(:package_backends_bind_files) {
        [
          '/etc/powerdns/bindbackend.conf',
          '/etc/powerdns/pdns.d/pdns.simplebind.conf',
          '/etc/powerdns/pdns.d/pdns.local.conf'
        ]
      }

      context 'tests with the default parameters' do

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to create_class('powerdns::backend') }

        it { is_expected.to contain_powerdns__install("pdns-backend-#{backend_name}") }
        it { is_expected.to contain_package("pdns-backend-#{backend_name}") }

        it do
          is_expected.to create_file("#{config_file}").with(
            'ensure' => 'file',
            'path'   => "#{config_file}",
            'mode'   => '0600',
            'owner'  => "#{user}",
            'group'  => "#{group}",
            'backup' => "#{config_file_backup}"
          )
        end

        it do
          package_backends_bind_files.each do |file|
            is_expected.to contain_file(file).with(
              'ensure' => 'absent',
              'owner'  => "#{user}",
              'group'  => "#{group}",
              'backup' => "#{config_file_backup}"
            )
          end
        end

      end # en contex init class

    end # contex distro

  end # do distro

end # powerdns
