#
define powerdns::service (
    $service_name   = $name,
    $service_ensure = 'running',
    $service_enable = true,
    $service_manage = true,
  ) {

  if $service_manage == true {
    service { $service_name:
      ensure     => $service_ensure,
      name       => $service_name,
      enable     => $service_enable,
      hasrestart => true,
      hasstatus  => true,
    }
  }
}
