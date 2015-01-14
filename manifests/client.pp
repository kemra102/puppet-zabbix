class zabbix::client (

  # Allow for overrides of variables in params.pp
  $service_manage       = $zabbix::params::client_service_manage,
  $service_ensure       = $zabbix::params::client_service_ensure,
  $service_enable       = $zabbix::params::client_service_enable,

  $pidfile              = $zabbix::params::client_pidfile,
  $logfile              = $zabbix::params::client_logfile,
  $logfilesize          = $zabbix::params::client_logfilesize,
  $debuglevel           = $zabbix::params::client_debuglevel,
  $sourceip             = $zabbix::params::client_sourceip,
  $enableremotecommands = $zabbix::params::client_enableremotecommands,
  $logremotecommands    = $zabbix::params::client_logremotecommands,
  $server               = $zabbix::params::client_server,
  $listenport           = $zabbix::params::client_listenport,
  $listenip             = $zabbix::params::client_listenip,
  $startagents          = $zabbix::params::client_startagents,
  $serveractive         = $zabbix::params::client_serveractive,
  $hostname             = $zabbix::params::client_hostname,
  $hostnameitem         = $zabbix::params::client_hostnameitem,
  $refreshactivechecks  = $zabbix::params::client_refreshactivechecks,
  $buffersend           = $zabbix::params::client_buffersend,
  $buffersize           = $zabbix::params::client_buffersize,
  $maxlinespersecond    = $zabbix::params::client_maxlinespersecond,
  $allowroot            = $zabbix::params::client_allowroot,
  $parameteralias       = $zabbix::params::client_parameteralias,
  $timeout              = $zabbix::params::client_timeout,
  $include              = $zabbix::params::client_include,
  $unsafeuserparameters = $zabbix::params::client_unsafeuserparameters,
  $userparameter        = $zabbix::params::client_userparameter,

  $version              = undef,

  ) inherits zabbix::params {

  # Validate our variables
  validate_bool($client::service_manage)
  validate_string($client::service_ensure)
  validate_bool($client::service_enable)

  validate_absolute_path($client::pidfile)
  validate_absolute_path($client::logfile)
  validate_string($client::logfilesize)
  validate_string($client::debuglevel)
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

  include ::zabbix::client::install
  include ::zabbix::client::service

}
