#
class powerdns::service inherits powerdns {

  service { 'pdns':,
    ensure     => $service_ensure,
    name       => $service_name,
    enable     => $service_enable,
    hasrestart => true,
    hasstatus  => true,
    require    => Class['powerdns::install']
  }
}
