#
class powerdns::backend (
  $backend_name = $::powerdns::params::default_backend_name,
  $ensure       = $::powerdns::params::default_backend_ensure,
  $config       = {},
) inherits powerdns {

  require powerdns

  # check if backend backend_name is valid
  if ! ("pdns-backend-${backend_name}" in $::powerdns::params::package_backends) {
    fail("\"${status}\" is not a valid status parameter value")
  }
  # check valid values for package ensure param
  if ! ($ensure in [ 'present', 'installed', 'absent', 'purged', 'held', 'latest' ]) {
    fail("\"${status}\" is not a valid status parameter value")
  }

  # install related package
  package { "pdns-backend-${backend_name}":
    ensure => $ensure,
  }

  # get the path for backend config file
  $key = 'include-dir'
  if is_hash($config_options) and has_key($config_options, $key) {
    $backend_conf_path  = $config_options[$key]
  }
  $config_file = "${backend_conf_path}/${::powerdns::params::default_backend_config_file_prefix}.g${backend_name}.conf"

  # Variable used by template file
  $options = merge($::powerdns::params::default_backend_config, $config)

  file { $config_file:
    ensure  => present,
    path    => $config_file,
    content => template("${module_name}/config/KEY-VALUE-conf-file.erb"),
    mode    => '0600',
    backup  => $::powerdns::params::backend_config_file_backup,
  }

  # Only one backend engine will be working, so, disable default backend
  file { $::powerdns::params::package_backends_bind_files:
    ensure => absent,
    backup => $::powerdns::params::backend_config_file_backup,
  }

}
