class zabbix::params {

  # Zabbix Client (Agent) service variables
  $client::service_ensure	= 'running'
  $client::service_enable	= 'true'

  # Zabbix Client (Agent) configuration items
  $client::pidfile		= '/var/run/zabbix/zabbix_agentd.pid'
  $client::logfile		= '/var/log/zabbix/zabbix_agentd.log'
  $client::logfilesize		= ''
  $client::debuglevel		= '3'
  $client::sourceip		= ''
  $client::enableremotecommands	= ''
  $client::logremotecommands	= ''
  $client::server		= ''
  $client::listenport		= '10050'
  $client::listenip		= ''
  $client::startagents		= ''
  $client::serveractive		= ''
  $client::hostname		= ''
  $client::hostnameitem		= ''
  $client::refreshactivechecks	= ''
  $client::buffersend		= ''
  $client::buffersize		= ''
  $client::maxlinespersecond	= ''
  $client::allowroot		= ''
  $client::alias		= ''
  $client::timeout		= ''
  $client::include		= '/etc/zabbix/zabbix_agentd.d/'
  $client::unsafeuserparameters	= ''
  $client::userparameter	= ''

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
