#
class powerdns::service inherits powerdns {

  if $powerdns::service_manage == true {
    service { 'pdns':,
      ensure     => $service_ensure,
      name       => $service_name,
      enable     => $service_enable,
      hasrestart => true,
      hasstatus  => true,
      require    => Class['powerdns::install']
    }
  }
}
