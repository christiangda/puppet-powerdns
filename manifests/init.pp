# == Class: powerdns
#
# Full description of class powerdns here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the function of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'powerdns':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Christian Gonzalez <christiangda@gmail.com>
#
# === Copyright
#
# Copyright 2016 Christian Gonzalez.
#
class powerdns (
  $package_ensure     = $::powerdns::params::package_ensure,
  $service_enable     = $::powerdns::params::service_enable,
  $service_ensure     = $::powerdns::params::service_ensure,
  $config_file_path   = $::powerdns::params::config_file_path,
  $config_file        = $::powerdns::params::config_file,
  $config_file_backup = $::powerdns::params::config_file_backup,
  $config             = {},
) inherits powerdns::params {

  # Fail fast if we're not using a new Puppet version.
  if versioncmp($::puppetversion, '3.7.0') < 0 {
    fail('This module requires the use of Puppet v3.7.0 or newer.')
  }

  if ! ($package_ensure in [ 'present', 'installed', 'absent', 'purged', 'held', 'latest' ]) {
    fail("\"${status}\" is not a valid status parameter value")
  }

  validate_bool($service_enable)

  if ! ($service_ensure in [ 'running', 'stopped' ]) {
    fail("\"${status}\" is not a valid status parameter value")
  }

  validate_string($config_file_path)
  validate_string($config_file)
  validate_bool($config_file_backup)
  validate_hash($config)

  # Variable used by template file in config.pp
  $config_options = merge($::powerdns::params::default_config, $config)

  class{'powerdns::install':} ->
  class{'powerdns::config':} ->
  class{'powerdns::service':} ->
  Class['powerdns']

}
