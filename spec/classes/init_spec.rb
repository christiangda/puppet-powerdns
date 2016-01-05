require 'spec_helper'
describe 'powerdns' do

  context 'with defaults for all parameters' do
    it { should contain_class('powerdns') }
  end
end
