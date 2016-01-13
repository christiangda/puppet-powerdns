#
define powerdns::service (
    $service_name    = $name,
    $service_ensure  = 'running',
    $service_enable  = true,
    $service_manage  = true,
    $service_restart = true,
    $service_status  = true,
  ) {

  if $service_manage == true {
    service { $service_name:
      ensure     => $service_ensure,
      name       => $service_name,
      enable     => $service_enable,
      hasrestart => $service_restart,
      hasstatus  => $service_status,
    }
  }
}
