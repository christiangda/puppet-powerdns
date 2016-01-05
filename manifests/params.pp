#
#
class powerdns::params {
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
      ]
    }
    default: {
      fail("\"${module_name}\" provides no package default value
            for \"${::operatingsystem}\"")
    }
  }

  $package_ensure = 'present'
}
