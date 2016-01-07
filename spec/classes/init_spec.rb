# spec/classes/init_spec.rb
require 'spec_helper'

describe 'Class powerdns', :type => 'class' do

  context 'On a Debian OS with defaults for all parameters' do
     let :facts do
      {
        :osfamily => 'Debian'
      }
    end
    it {
      should contain_class('powerdns')
      should contain_package('pdns-server')
      should contain_service('pdns')
    }
  end

  context 'On a RedHat OS with defaults for all parameters' do
     let :facts do
      {
        :osfamily => 'RedHat'
      }
    end
    it {
      should contain_class('powerdns')
      should contain_package('pdns')
      should contain_package('pdns-tools')
      should contain_service('pdns')
    }
  end

end
