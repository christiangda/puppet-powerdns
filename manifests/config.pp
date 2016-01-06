#
class powerdns::config inherits powerdns {

  # Variable used by template file
  $options = $config_options

  $file = "${config_file_path}/${config_file}"

  file { $file:
    ensure  => present,
    path    => $file,
    content => template("${module_name}/config/KEY-VALUE-conf-file.erb"),
    mode    => '0600',
    backup  => $config_file_backup,
  }

  # Create the log file
  # get the path for log file
  $key = 'logfile'
  if is_hash($config_options) and has_key($config_options, $key) {

    $logfile  = $config_options[$key]

    file { $logfile:
      ensure => present,
      mode   => '0622',
    }

  }
}
