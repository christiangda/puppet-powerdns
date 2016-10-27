#
class powerdns::recursor (
  $package_ensure     = $::powerdns::params::package_ensure,
  $service_enable     = $::powerdns::params::service_enable,
  $service_ensure     = $::powerdns::params::service_ensure,
  $service_manage     = $::powerdns::params::service_manage,
  $service_restart    = $::powerdns::params::recursor_service_restart,
  $service_status     = $::powerdns::params::recursor_service_status,
  $service_status_cmd = $::powerdns::params::recursor_service_status_cmd,
  $config_file_path   = $::powerdns::params::config_file_path,
  $config_file        = $::powerdns::params::recursor_config_file,
  $config_file_backup = $::powerdns::params::config_file_backup,
  $config             = {},
  ) inherits powerdns {

  if ! ($package_ensure in [ 'present', 'installed', 'absent', 'purged', 'held', 'latest' ]) {
    fail("\"${::status}\" is not a valid status parameter value")
  }

  validate_bool($service_enable)
  validate_bool($service_manage)

  if ! ($service_ensure in [ 'running', 'stopped' ]) {
    fail("\"${::status}\" is not a valid status parameter value")
  }

  validate_string($config_file_path)
  validate_string($config_file)
  validate_bool($config_file_backup)
  validate_hash($config)
  validate_string($powerdns::recursor_package_name)
  validate_string($powerdns::recursor_service_name)
  validate_bool($service_restart)
  validate_bool($service_status)

  # Variable used to merge configd
  $config_options = merge($powerdns::recursor_default_config, $config)

  powerdns::install { $powerdns::recursor_package_name: } ->
  powerdns::config { $config_file:
    config       => $config_options,
    file_path    => $config_file_path,
    service_name => $powerdns::recursor_service_name,
  } ->
  powerdns::service { $powerdns::recursor_service_name:
    service_restart    => $service_restart,
    service_status     => $service_status,
    service_status_cmd => $service_status_cmd,
  }
}
