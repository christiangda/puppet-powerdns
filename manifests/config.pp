#
define powerdns::config (
    $file_name     = $name,
    $user          = undef,
    $group         = undef,
    $config        = undef,
    $file_path     = undef,
    $service_name  = undef,
    $config_backup = true,
  ) {

  # Variable used in template file
  $options = $config
  $file    = "${file_path}/${file_name}"

  file { $file:
    ensure  => 'file',
    path    => $file,
    content => template("${module_name}/config/KEY-VALUE-conf-file.erb"),
    mode    => '0644',
    owner   => $user,
    group   => $group,
    backup  => $config_backup,
  }
}
