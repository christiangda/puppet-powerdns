#
class powerdns::backend (
  $backend_name = $powerdns::params::default_backend_name,
  $ensure       = $powerdns::params::default_backend_ensure,
  $config       = {},
) inherits powerdns {

  # check if backend backend_name is valid
  if ! ("pdns-backend-${backend_name}" in $powerdns::package_backends) {
    fail("\"${::status}\" is not a valid backend name")
  }
  # check valid values for package ensure param
  if ! ($ensure in [ 'present', 'installed', 'absent', 'purged', 'held', 'latest' ]) {
    fail("\"${::status}\" is not a valid status parameter value")
  }

  validate_hash($config)

  # get the path for backend config file
  $key = 'include-dir'
  $config_options = $powerdns::default_config

  if is_hash($config_options) and has_key($config_options, $key) {
    $backend_conf_path  = $config_options[$key]
  }

  $config_file = "${backend_conf_path}/${powerdns::default_backend_config_file_prefix}.g${backend_name}.conf"

  # check valid values for package ensure param
  if ($backend_name == 'mysql') {
    $options = merge($powerdns::default_backend_config, $config)
  } else {
    $options = $config
  }

  powerdns::install { "pdns-backend-${backend_name}": } ->
  file { $config_file:
    ensure  => 'file',
    path    => $config_file,
    content => template("${module_name}/config/KEY-VALUE-conf-file.erb"),
    mode    => '0600',
    owner   => $powerdns::user,
    group   => $powerdns::group,
    backup  => $powerdns::backend_config_file_backup,
  }

  if ($backend_name != 'bind') {
    # Only one backend engine will be working, so, disable default backend
    file { $powerdns::package_backends_bind_files:
      ensure => 'absent',
      owner  => $powerdns::user,
      group  => $powerdns::group,
      backup => $powerdns::backend_config_file_backup,
    }
  }

}
