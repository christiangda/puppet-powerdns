describe 'powerdns::setting' do
  shared_examples 'a Linux distribution' do |osfamily, config|
    let (:pre_condition) { 'include ::powerdns' }

    let (:title) { 'cache-ttl' }

    let (:params) do
      {
        :ensure => 'present',
        :value  => '20',
      }
    end

    let (:facts) do
      {
        :operatingsystem => osfamily,
        :osfamily        => osfamily,
      }
    end

    context "on #{osfamily}" do
      it do
        should contain_concat__fragment('cache-ttl')
          .with({
            :content => "#{title}=20\n",
            :ensure  => 'present',
            :target  => config,
          })
      end
    end
  end

  it_behaves_like 'a Linux distribution', 'RedHat', '/etc/pdns/pdns.conf'
  it_behaves_like 'a Linux distribution', 'Debian', '/etc/powerdns/pdns.conf'
end
