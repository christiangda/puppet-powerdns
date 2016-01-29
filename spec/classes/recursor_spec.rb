describe 'powerdns::recursor' do
  shared_examples 'a Linux distribution' do |osfamily|

    context "with default parameters on #{osfamily}" do
      let (:facts) do
        {
          :operatingsystem => osfamily,
          :osfamily        => osfamily,
        }
      end

      it { should compile.with_all_deps }
      it { should create_class('powerdns::recursor') }
      it { should contain_class('powerdns::params') }

      if osfamily == 'Debian'
        it { should create_file('/etc/powerdns/recursor.conf') }
        it { should contain_package('pdns-recursor') }
        it { should contain_powerdns__config('recursor.conf') }
        it { should contain_powerdns__install('pdns-recursor') }
        it { should contain_powerdns__service('pdns-recursor') }
        it { should contain_service('pdns-recursor') }
      end
      if osfamily == 'RedHat'
        it { should create_file('/etc/pdns/recursor.conf') }
        it { should contain_package('pdns-recursor') }
        it { should contain_powerdns__config('recursor.conf') }
        it { should contain_powerdns__install('pdns-recursor') }
        it { should contain_powerdns__service('pdns-recursor') }
        it { should contain_service('pdns-recursor') }
      end

    end
  end

  it_behaves_like 'a Linux distribution', 'RedHat'
  it_behaves_like 'a Linux distribution', 'Debian'
end
