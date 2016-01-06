#
#
class powerdns::params {

  $package_ensure = 'present'
  # packages
  case $::operatingsystem {
    'RedHat', 'Fedora', 'CentOS': {
      # main application
      $package_name  = 'pdns'
      $package_extra = [
        'pdns-backend-geo',
        'pdns-backend-lua',
        'pdns-backend-ldap',
        'pdns-backend-lmdb',
        'pdns-backend-pipe',
        'pdns-backend-geoip',
        'pdns-backend-mydns',
        'pdns-backend-mysql',
        'pdns-backend-remote',
        'pdns-backend-sqlite',
        'pdns-backend-opendbx',
        'pdns-backend-tinydns',
        'pdns-backend-postgresql',
      ]
      $config_file_path = '/etc/pdns'
      $config_file      = 'pdns.conf'
    }
    'Debian', 'Ubuntu': {
      # main application
      $package_name  = 'pdns-server'
      $package_extra = [
        'pdns-backend-geo',
        'pdns-backend-ldap',
        'pdns-backend-lua',
        'pdns-backend-mysql',
        'pdns-backend-pgsql',
        'pdns-backend-pipe',
        'pdns-backend-sqlite3',
        'pdns-recursor',
      ]
      $package_extra_backend_bind_files = [
        '/etc/powerdns/bindbackend.conf',
        '/etc/powerdns/pdns.d/pdns.simplebind.conf',
        '/etc/powerdns/pdns.d/pdns.local.conf',
      ]
      $config_file_path = '/etc/powerdns'
      $config_file      = 'pdns.conf'
    }
    default: {
      fail("\"${module_name}\" provides no package default value
            for \"${::operatingsystem}\"")
    }
  }

  $service_name   = 'pdns'
  $service_enable = true
  $service_ensure = 'running'
  $service_manage = true

  $config_file_backup = true
  $default_config     = {
    'allow-recursion'           => '127.0.0.1',
    'cache-ttl'                 => '20',
    'config-dir'                => $config_file_path,
    'daemon'                    => 'yes',
    'disable-tcp'               => 'no',
    'guardian'                  => 'yes',
    'local-address'             => '0.0.0.0',
    'local-port'                => '53',
    'logging-facility'          => '0',
    'master'                    => 'no',
    'max-tcp-connections'       => '10',
    'module-dir'                => '/usr/lib/powerdns',
    'setgid'                    => 'pdns',
    'setuid'                    => 'pdns',
    'slave'                     => 'no',
    'soa-minimum-ttl'           => '3600',
    'soa-refresh-default'       => '10800',
    'soa-retry-default'         => '3600',
    'soa-expire-default'        => '604800',
    'soa-serial-offset'         => '0',
    'socket-dir'                => '/var/run',
    'webserver'                 => 'no',
    'webserver-address'         => '127.0.0.1',
    'webserver-password'        => 'password',
    'webserver-port'            => '8081',
    'webserver-print-arguments' => 'no',
    'wildcard-url'              => 'no',
    'include-dir'               => "${config_file_path}/pdns.d",
  }

  # Default backend configuration
  $default_backend_config_file_prefix = 'pdns.local'
  $default_backend_name   = 'mysql'
  $default_backend_ensure = 'present'
  $default_backend_config = {
    'launch'          => 'gmysql',
    'gmysql-host'     => 'localhost',
    'gmysql-port'     => '3306',
    'gmysql-dbname'   => 'pdns',
    'gmysql-user'     => 'pdns',
    'gmysql-password' => 'password',
    'gmysql-dnssec'   => 'yes',
  }
  $backend_config_file_backup = true
}
