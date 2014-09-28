# == Class: zabbix
#
# Full description of class zabbix here.
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
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { zabbix:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Danny Roberts <danny.roberts@reconnix.com>
#
# === Copyright
#
# Copyright 2014 Danny Roberts
#
class zabbix (

  # Allow for overrides of variables in params.pp
  $client::service_ensure	= $zabbix::params::client::service_ensure,
  $client::service_enable	= $zabbix::params::client::service_enable,

  $client::pidfile		= $zabbix::params::client::pidfile,
  $client::logfile		= $zabbix::params::client::logfile,
  $client::logfilesize		= $zabbix::params::client::logfilesize,
  $client::debuglevel		= $zabbix::params::client::debuglevel,
  $client::sourceip		= $zabbix::params::client::sourceip,
  $client::enableremotecommands	= $zabbix::params::client::enableremotecommands,
  $client::logremotecommands	= $zabbix::params::client::logremotecommands,
  $client::server		= $zabbix::params::client::server,
  $client::listenport		= $zabbix::params::client::listenport,
  $client::listenip		= $zabbix::params::client::listenip,
  $client::startagents		= $zabbix::params::client::startagents,
  $client::serveractive		= $zabbix::params::client::serveractive,
  $client::hostname		= $zabbix::params::client::hostname,
  $client::hostnameitem		= $zabbix::params::client::hostnameitem,
  $client::refreshactivechecks	= $zabbix::params::client::refreshactivechecks,
  $client::buffersend		= $zabbix::params::client::buffersend,
  $client::buffersize		= $zabbix::params::client::buffersize,
  $client::maxlinespersecond	= $zabbix::params::client::maxlinespersecond,
  $client::allowroot		= $zabbix::params::client::allowroot,
  $client::alias		= $zabbix::params::client::alias,
  $client::timeout		= $zabbix::params::client::timeout,
  $client::include		= $zabbix::params::client::include,
  $client::unsafeuserparameters	= $zabbix::params::client::unsafeuserparameters,
  $client::userparameter	= $zabbix::params::client:userparameter,

) inherits zabbix::params {

  # Validate our variables
  validate_string($client::service_ensure)
  validate_bool($client::service_enable)

  validate_absolute_path($client::pidfile)
  validate_absolute_path($client::logfile)
  validate_string($client::logfilesize)
  validate_debuglevel($client::debuglevel)
  validate_string($client::sourecip)
  validate_string($client::enableremotecommands)
  validate_string($client::logremotecommands)
  validate_string($client::server)
  validate_string($client::listenport)
  validate_string($client::listenip)
  validate_string($client::startagents)
  validate_string($client::serveractive)
  validate_string($client::hostname)
  validate_string($client::hostnameitem)
  validate_string($client::refreshactivechecks)
  validate_string($client::buffersend)
  validate_string($client::buffersize)
  validate_string($client::maxlinespersecond)
  validate_string($client::allowroot)
  validate_string($client::alias)
  validate_string($client::timeout)
  validate_absolute_path($client::include)
  validate_string($client::unsafeuserparameters)
  validate_string($client::userparameter)

}
