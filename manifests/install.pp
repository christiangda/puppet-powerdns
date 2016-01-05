#
class powerdns::install inherits powerdns {

  package { $package_name:
    ensure => $package_ensure,
  }
}
