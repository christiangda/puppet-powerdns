describe 'powerdns' do
  shared_examples 'a Linux distribution' do |osfamily|

    context "with default parameters on #{osfamily}" do
      let (:facts) do
        {
          :operatingsystem => osfamily,
          :osfamily        => osfamily,
        }
      end

      it { should compile.with_all_deps }
      it { should create_class('powerdns') }
      it { should contain_class('powerdns::params') }

      if osfamily == 'Debian'
        it { should create_file('/etc/powerdns/pdns.conf') }
        it { should contain_package('pdns-server') }
        it { should contain_powerdns__config('pdns.conf') }
        it { should contain_powerdns__install('pdns-server') }
        it { should contain_powerdns__service('pdns') }
        it { should contain_service('pdns') }
      end
      if osfamily == 'RedHat'
        it { should create_file('/etc/pdns/pdns.conf') }
        it { should contain_package('pdns') }
        it { should contain_package('pdns-tools') }
        it { should contain_powerdns__config('pdns.conf') }
        it { should contain_powerdns__install('pdns') }
        it { should contain_powerdns__install('pdns-tools') }
        it { should contain_powerdns__service('pdns') }
        it { should contain_service('pdns') }
        it { should contain_powerdns__config('pdns.conf') }
      end

    end
  end

  it_behaves_like 'a Linux distribution', 'RedHat'
  it_behaves_like 'a Linux distribution', 'Debian'
end
