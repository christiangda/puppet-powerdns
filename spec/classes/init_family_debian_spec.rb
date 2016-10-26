require 'spec_helper'

describe 'powerdns', type: 'class' do

  ['Debian', 'Ubuntu'].each do |distro|

    context "on #{distro} OS" do

      let(:facts) { {
        operatingsystem: distro,
        kernel:          'Linux',
        osfamily:        'Debian',
        lsbdistid:       'Debian'
      } }

      context 'Init class tests' do

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to create_class('powerdns') }
        it { is_expected.to contain_class('powerdns::params') }

        it { is_expected.to contain_class('powerdns::install') }
        it { is_expected.to contain_class('powerdns::config').that_requires('Class[powerdns::install]') }
        it { is_expected.to contain_class('powerdns::service').that_requires('Class[powerdns::config]') }

      end # en contex init class

    end # contex distro

  end # do distro

end # powerdns
