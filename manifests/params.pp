#
#
class powerdns::params {
  $user           = 'pdns'
  $group          = 'pdns'
  $package_ensure = 'present'
  # packages
  case $facts['os']['name'] {
    'RedHat', 'CentOS', 'Fedora', 'Scientific', 'Amazon', 'OracleLinux': {
      # main application
      $package_name     = ['pdns', 'pdns-tools']
      $package_backends = [
        'pdns-backend-bind',
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
      $package_backends_bind_files = [
        '/etc/pdns/bindbackend.conf',
        '/etc/pdns/pdns.d/pdns.simplebind.conf',
        '/etc/pdns/pdns.d/pdns.local.conf',
      ]
      $config_file_path            = '/etc/pdns'
      $config_file                 = 'pdns.conf'
      $recursor_config_file        = 'recursor.conf'
      $recursor_config_file_path   = '/etc/pdns-recursor'
      $recursor_user               ='pdns-recursor'
      $recursor_group              ='pdns-recursor'
      $backend_file_perms          = '0600'
      $service_status_cmd          = '/usr/bin/pdns_control rping 2>/dev/null 1>/dev/null'
      $recursor_service_status_cmd = '/usr/bin/rec_control ping 2>/dev/null 1>/dev/null'
    }
    'Debian', 'Ubuntu': {
      # main application
      $package_name          = ['pdns-server']
      $package_backends = [
        'pdns-backend-bind',
        'pdns-backend-geo',
        'pdns-backend-ldap',
        'pdns-backend-lua',
        'pdns-backend-mysql',
        'pdns-backend-pgsql',
        'pdns-backend-pipe',
        'pdns-backend-sqlite3',
      ]
      $package_backends_bind_files = [
        '/etc/powerdns/bindbackend.conf',
        '/etc/powerdns/pdns.d/pdns.simplebind.conf',
        '/etc/powerdns/pdns.d/pdns.local.conf',
      ]
      $config_file_path          = '/etc/powerdns'
      $config_file               = 'pdns.conf'
      $recursor_config_file      = 'recursor.conf'
      $recursor_config_file_path = '/etc/powerdns'
      $recursor_user             ='pdns'
      $recursor_group            ='pdns'
      $backend_file_perms        = '0640'

      case $facts['os']['distro']['codename'] {
        'xenial': {
          $service_status_cmd          = '/usr/bin/pdns_control rping 2>/dev/null 1>/dev/null'
          $recursor_service_status_cmd = '/usr/bin/rec_control ping 2>/dev/null 1>/dev/null'
        }
        default: {
          $service_status_cmd          = '/usr/bin/pdns_control ping 2>/dev/null 1>/dev/null'
          $recursor_service_status_cmd = '/usr/bin/rec_control ping 2>/dev/null 1>/dev/null'
        }
      }
    }
    default: {
      fail("\"${module_name}\" provides no package default value
            for \"${facts['os']['name']}\"")
    }
  }

  $service_name       = 'pdns'
  $service_enable     = true
  $service_ensure     = 'running'
  $service_manage     = true
  $service_restart    = true
  $service_status     = true
  $config_include_dir = "${config_file_path}/pdns.d"
  $config_file_backup = true
  $default_config     = {
    'allow-recursion'           => '127.0.0.1',
    'config-dir'                => $config_file_path,
    'local-address'             => '0.0.0.0',
    'local-port'                => '53',
    'setgid'                    => $group,
    'setuid'                    => $user,
    'include-dir'               => $config_include_dir,
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

  # Recursor independent OS variables
  $recursor_package_name       = 'pdns-recursor'
  $recursor_service_name       = 'pdns-recursor'
  $recursor_service_restart    = true
  $recursor_service_status     = true
  $recursor_default_config     = {
    'allow-from'               => '127.0.0.1',
    'config-dir'               => $recursor_config_file_path,
    'setgid'                   => $recursor_user,
    'setuid'                   => $recursor_group,
  }
}
