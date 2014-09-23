class zabbix::params {

  # Zabbix Client (Agent) service variables
  $client_service_manage	= 'true'
  $client_service_ensure	= 'running'
  $client_service_enable	= 'true'

  # Zabbix Client (Agent) configuration items
  $client_pidfile		= '/var/run/zabbix/zabbix_agentd.pid'
  $client_logfile		= '/var/log/zabbix/zabbix_agentd.log'
  $client_logfilesize		= ''
  $client_debuglevel		= '3'
  $client_sourceip		= ''
  $client_enableremotecommands	= ''
  $client_logremotecommands	= ''
  $client_server		= ''
  $client_listenport		= '10050'
  $client_listenip		= ''
  $client_startagents		= ''
  $client_serveractive		= ''
  $client_hostname		= ''
  $client_hostnameitem		= ''
  $client_refreshactivechecks	= ''
  $client_buffersend		= ''
  $client_buffersize		= ''
  $client_maxlinespersecond	= ''
  $client_allowroot		= ''
  $client_alias			= ''
  $client_tiemout		= ''
  $client_include		= '/etc/zabbix/zabbix_agentd.d/'
  $client_unsafeuserparameters	= ''
  $client_userparameter		= ''

  # Set the version of Zabbix to be installed
  # CentOS 5 only goes up to Zabbix 2.2 so we need a case here
  case $::operatingsystemmajrelease {
    '5': {
      $version = '2.2'
    }
    '6': {
      $version = '2.4'
    }
    default: {
      $version = ''
    }
  }

}
