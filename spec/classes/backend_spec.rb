describe 'powerdns::backend' do
  shared_examples 'a Linux distribution' do |osfamily|

    context "with default parameters on #{osfamily}" do
      let (:facts) do
        {
          :operatingsystem => osfamily,
          :osfamily        => osfamily,
        }
      end

      it { should compile.with_all_deps }
      it { should create_class('powerdns::backend') }
      it { should contain_class('powerdns::params') }

      if osfamily == 'Debian'
        it { should create_file('/etc/powerdns/bindbackend.conf') }
        it { should create_file('/etc/powerdns/pdns.d/pdns.local.conf') }
        it { should create_file('/etc/powerdns/pdns.d/pdns.simplebind.conf') }
      end
      if osfamily == 'RedHat'
        it { should create_file('/etc/pdns/bindbackend.conf') }
        it { should create_file('/etc/pdns/pdns.d/pdns.local.conf') }
        it { should create_file('/etc/pdns/pdns.d/pdns.simplebind.conf') }
      end

      it { should create_file('/pdns.local.gmysql.conf') }
      it { should contain_package('pdns-backend-mysql') }

    end
  end

  it_behaves_like 'a Linux distribution', 'RedHat'
  it_behaves_like 'a Linux distribution', 'Debian'
end
