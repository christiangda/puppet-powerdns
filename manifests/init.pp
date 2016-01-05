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
# Author Name <christiangda@gmail.com>
#
# === Copyright
#
# Copyright 2016 Christian González.
#
class powerdns (
  $package_name   = $powerdns::params::package_name,
  $package_ensure = $powerdns::params::package_ensure,
  $package_extra  = $powerdns::params::package_extra,
) inherits powerdns::params {

  # Fail fast if we're not using a new Puppet version.
  if versioncmp($::puppetversion, '3.7.0') < 0 {
    fail('This module requires the use of Puppet v3.7.0 or newer.')
  }

  validate_string($package_name)

  if ! ($package_ensure in [ 'present', 'installed', 'absent', 'purged', 'held', 'latest' ]) {
    fail("\"${status}\" is not a valid status parameter value")
  }

  validate_array($package_extra)


}
