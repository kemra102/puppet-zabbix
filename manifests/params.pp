class zabbix::params {

  # Zabbix Client (Agent) service variables
  $client_service_manage        	= true
  $client_service_ensure        	= 'running'
  $client_service_enable        	= true

  # Zabbix Client (Agent) configuration items
  $client_pidfile               	= '/var/run/zabbix/zabbix_agentd.pid'
  $client_logfile               	= '/var/log/zabbix/zabbix_agentd.log'
  $client_logfilesize           	= ''
  $client_debuglevel            	= '3'
  $client_sourceip              	= ''
  $client_enableremotecommands  	= ''
  $client_logremotecommands     	= ''
  $client_server                	= ''
  $client_listenport            	= '10050'
  $client_listenip              	= ''
  $client_startagents           	= ''
  $client_serveractive          	= ''
  $client_hostname              	= ''
  $client_hostnameitem          	= ''
  $client_refreshactivechecks   	= ''
  $client_buffersend            	= ''
  $client_buffersize            	= ''
  $client_maxlinespersecond     	= ''
  $client_allowroot             	= ''
  $client_parameteralias        	= ''
  $client_timeout               	= ''
  $client_include               	= '/etc/zabbix/zabbix_agentd.d/'
  $client_unsafeuserparameters  	= ''
  $client_userparameter         	= ''

  # Zabbix Server package variables
  $server_database			= 'mysql'
  $server_web				= true
  $server_web_japanese			= false

  # Zabbix Server service variables
  $server_service_manage        	= true
  $server_service_ensure        	= 'running'
  $server_service_enable        	= true

  # Zabbix Server configuration items
  $server_listenport			= '10051'
  $server_sourceip			= undef
  $server_logfile			= '/var/log/zabbix/zabbix_server.log'
  $server_logfilesize			= '0'
  $server_debuglevel			= '3'
  $server_pidfile			= '/var/run/zabbix/zabbix_server.pid'

  case $server_database {
    'mysql': { $server_dbhost = 'localhost' }
    'pgsql': { $server_dbhost = '' }
  }

  $server_dbname			= 'zabbix'
  $server_dbuser			= 'zabbix'
  $server_dbpassword			= undef

  case $server_database {
    'mysql': { $server_dbsocket = '/var/lib/mysql/mysql.sock' }
    default: { $server_dbsocket = undef }
  }

  if $server_database == 'mysql' and $server_dbhost != 'localhost' {
    $server_dbport = '3306'
  }
  elsif $server_database == 'pgsql' and $server_dbhost != undef {
    $server_dbport = '5432'
  }
  else {
    $server_dbport = undef
  }

  $server_startpollers			= undef
  $server_startipmipollers		= undef
  $server_startpollersunreachable	= undef
  $server_startpingers			= undef
  $server_startdiscoverers		= undef
  $server_starthttppollers		= undef
  $server_starttimers			= undef
  $server_javagateway			= undef
  $server_javagatewayport		= undef
  $server_startjavapollers		= undef
  $server_startvmwarecollectors		= undef
  $server_vmwarecachesize		= undef
  $server_snmptrapperfile		= undef
  $server_startsnmptrapper		= undef
  $server_listenip			= undef
  $server_housekeepingfrequency		= undef
  $server_maxhousekeeperdelete		= undef
  $server_senderfrequency		= undef
  $server_cachesize			= undef
  $server_cacheupdatefrequency		= undef
  $server_startdbsyncers		= undef
  $server_historycachesize		= undef
  $server_trendcachesize		= undef
  $server_historytextcachesize		= undef
  $server_valuecachesize		= undef
  $server_timeout			= undef
  $server_trappertimeout		= undef
  $server_unreachableperiod		= undef
  $server_unavailabledelay		= undef
  $server_unreachabledelay		= undef
  $server_alertscriptspath		= '/usr/lib/zabbix/alertscripts'
  $server_externalscripts		= '/usr/lib/zabbix/externalscripts'
  $server_fpinglocation			= undef
  $server_fping6location		= undef
  $server_sshkeylocation		= undef
  $server_logslowqueries		= undef
  $server_tmpdir			= undef
  $server_startproxypollers		= undef
  $server_proxyconfigfrequency		= undef
  $server_proxydatafrequency		= undef
  $server_allowroot			= undef
  $server_user				= undef
  $server_include			= undef
  $server_sslcertlocation		= undef
  $server_sslkeylocation		= undef
  $server_sslcalocation			= undef
  $server_loadmodulepath		= undef
  $server_loadmodule			= undef

  # Set OS & OS release specific variables
  case $::operatingsystem {
    'CentOS','RedHat','Scientific','OracleLinux': {
      case $::operatingsystemmajrelease {
        '5': { $version = '2.2' }
        '6': { $version = '2.4' }
        default: {
          fail("${::operatingsystem} ${::operatingsystemmajrelease} is not supported by this module.")
        }
      }
      $server_web_packagename = "zabbix-web-$server_database"
    }
    'Ubuntu': {
      case $::operatingsystemmajrelease {
        '10.04': { $version = '2.0' }
        '12.04': { $version = '2.2' }
        '14.04': { $version = '2.4' }
        default: {
          fail("${::operatingsystem} ${::operatingsystemmajrelease} is not supported by this module.")
        }
      }
      $server_web_packagename = 'zabbix-frontend-php'
    }
    'Debian': {
      case $::operatingsystemmajrelease {
        '7': { $version = '2.4' }
        '6': { $version = '2.2' }
        default: {
          fail("${::operatingsystem} ${::operatingsystemmajrelease} is not supported by this module.")
        }
      }
      $server_web_packagename = 'zabbix-frontend-php'
    }
  }

}
