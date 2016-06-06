#
define powerdns::config (
    $file_name     = $name,
    $values        = undef,
    $file_path     = undef,
    $service_name  = undef,
    $config_backup = true,
  ) {

  # Variable used in template file
  $options = $values

  $file = "${file_path}/${file_name}"

  file { $file:
    ensure  => present,
    path    => $file,
    content => template("${module_name}/config/KEY-VALUE-conf-file.erb"),
    mode    => '0600',
    backup  => $config_backup,
    nofity  => Service["$service_name"]
  }

  # Create the log file
  # get the path for log file
  $key = 'logfile'
  if is_hash($options) and has_key($options, $key) {

    $logfile  = $options[$key]

    file { $logfile:
      ensure => present,
      mode   => '0622',
    }

  }
}
