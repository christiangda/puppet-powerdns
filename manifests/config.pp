#
class powerdns::config inherits powerdns {

  # Variable used by template file
  $options = merge($::powerdns::params::default_config, $config)

  file { $config_file:
    ensure  => present,
    path    => $config_file,
    content => template("${module_name}/config/pdns.conf.erb"),
    mode    => '0600',
    backup  => $config_file_backup,
  }
}
