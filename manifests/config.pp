#
class powerdns::config inherits powerdns {

  # Variable used by template file
  $options = $config_options

  file { $config_file:
    ensure  => present,
    path    => $config_file,
    content => template("${module_name}/config/KEY-VALUE-conf-file.erb"),
    mode    => '0600',
    backup  => $config_file_backup,
  }
}
