require 'spec_helper'

describe 'powerdns::service', type: 'define' do

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

      let(:service_name)    { 'service_name' }
      let(:title)           { "#{service_name}" }
      let(:service_ensure)  { 'running' }
      let(:service_enable)  { true }
      let(:service_manage)  { true }
      let(:service_restart) { true }
      let(:service_status)  { true }

      context 'tests with the default parameters' do

        it { is_expected.to compile.with_all_deps }

        it do
          is_expected.to contain_service("#{title}").with(
            'ensure'     => "#{service_ensure}",
            'name'       => "#{service_name}",
            'enable'     => "#{service_enable}",
            'hasrestart' => "#{service_restart}",
            'hasstatus'  => "#{service_status}"
          )
        end

      end # en contex init class

    end # contex distro

  end # do distro

end # powerdns
