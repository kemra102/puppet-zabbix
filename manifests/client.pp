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

  ) inherits zabbix::params {

  # Validate our variables
  validate_bool($service_manage)
  validate_string($service_ensure)
  validate_bool($service_enable)

  validate_absolute_path($pidfile)
  validate_absolute_path($logfile)
  validate_string($logfilesize)
  validate_string($debuglevel)
  validate_string($sourecip)
  validate_string($enableremotecommands)
  validate_string($logremotecommands)
  validate_string($server)
  validate_string($listenport)
  validate_string($listenip)
  validate_string($startagents)
  validate_string($serveractive)
  validate_string($hostname)
  validate_string($hostnameitem)
  validate_string($refreshactivechecks)
  validate_string($buffersend)
  validate_string($buffersize)
  validate_string($maxlinespersecond)
  validate_string($allowroot)
  validate_string($alias)
  validate_string($timeout)
  validate_absolute_path($include)
  validate_string($unsafeuserparameters)
  validate_string($userparameter)

  include '::zabbix::client::install'
  include '::zabbix::client::service'

}
