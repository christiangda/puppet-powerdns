#
define powerdns::install (
    $package_name   = $name,
    $package_ensure = 'present',
  ) {

  package { $package_name:
    ensure => $package_ensure,
  }
}
