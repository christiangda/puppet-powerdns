#
class powerdns::install (
    $package_name = undef
  ) {

  package { $package_name:
    ensure => $package_ensure,
  }
}
