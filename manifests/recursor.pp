#
class powerdns::recursor (
  $package_ensure     = $::powerdns::params::package_ensure,
  $service_enable     = $::powerdns::params::service_enable,
  $service_ensure     = $::powerdns::params::service_ensure,
  $service_manage     = $::powerdns::params::service_manage,
  $config_file_path   = $::powerdns::params::config_file_path,
  $config_file        = $::powerdns::params::recursor_config_file,
  $config_file_backup = $::powerdns::params::config_file_backup,
  $config             = {},
  ) inherits powerdns::params {

  if ! ($package_ensure in [ 'present', 'installed', 'absent', 'purged', 'held', 'latest' ]) {
    fail("\"${status}\" is not a valid status parameter value")
  }

  validate_bool($service_enable)
  validate_bool($service_manage)

  if ! ($service_ensure in [ 'running', 'stopped' ]) {
    fail("\"${status}\" is not a valid status parameter value")
  }

  validate_string($config_file_path)
  validate_string($config_file)
  validate_bool($config_file_backup)
  validate_hash($config)
  validate_array($recursor_package_name)

  # Variable used to merge configd
  $config_options = merge($::powerdns::params::recursor_default_config, $config)

  ::powerdns::install { $recursor_package_name: } ->
  ::powerdns::config { $recursor_config_file:
    values       => $config_options,
    file_path    => $config_file_path,
    service_name => $recursor_service_name,
  } ->
  ::powerdns::service { $recursor_service_name: }
}
