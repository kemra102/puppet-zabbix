class zabbix::server (

  # Allow for overrides of variables in params.pp
  $database				= $zabbix::params::server_database,
  $web					= $zabbix::params::server_web,
  $web_packagename			= $zabbix::params::server_web_packagename,
  $web_japanese				= $zabbix::params::server_web_japanese,

  $service_manage			= $zabbix::params::server_service_manage,
  $service_ensure			= $zabbix::params::server_service_ensure,
  $service_enable			= $zabbix::params::server_service_enable,
  $server_listenport			= $zabbix::params::server_listenport,
  $server_sourceip			= $zabbix::params::server_sourceip,
  $server_logfile			= $zabbix::params::server_logfile,
  $server_logfilesize			= $zabbix::params::server_logfilesize,
  $server_debuglevel			= $zabbix::params::server_debuglevel,
  $server_pidfile			= $zabbix::params::server_pidfile,
  $server_dbhost			= $zabbix::params::server_dbhost,
  $server_dbname			= $zabbix::params::server_dbname,
  $server_dbuser			= $zabbix::params::server_dbuser,
  $server_dbpassword			= $zabbix::params::server_dbpassword,
  $server_dbsocket			= $zabbix::params::server_dbsocket,
  $server_dbport			= $zabbix::params::server_dbport,
  $server_startpollers			= $zabbix::params::server_startpollers,
  $server_startipmipollers		= $zabbix::params::server_startipmipollers,
  $server_startpollersunreachable	= $zabbix::params::server_startpollersunreachable,
  $server_startpingers			= $zabbix::params::server_startpingers,
  $server_startdiscoverers		= $zabbix::params::server_startdiscoverers,
  $server_starthttppollers		= $zabbix::params::server_starthttppollers,
  $server_starttimers			= $zabbix::params::server_starttimers,
  $server_javagateway			= $zabbix::params::server_javagateway,
  $server_javagatewayport		= $zabbix::params::server_javagatewayport,
  $server_startjavapollers		= $zabbix::params::server_startjavapollers,
  $server_startvmwarecollectors		= $zabbix::params::server_startvmwarecollectors,
  $server_vmwarecachesize		= $zabbix::params::server_vmwarecachesize,
  $server_snmptrapperfile		= $zabbix::params::server_snmptrapperfile,
  $server_startsnmptrapper		= $zabbix::params::server_startsnmptrapper,
  $server_listenip			= $zabbix::params::server_listenip,
  $server_housekeepingfrequency		= $zabbix::params::server_housekeepingfrequency,
  $server_maxhousekeeperdelete		= $zabbix::params::server_maxhousekeeperdelete,
  $server_senderfrequency		= $zabbix::params::server_senderfrequency,
  $server_cachesize			= $zabbix::params::server_cachesize,
  $server_cacheupdatefrequency		= $zabbix::params::server_cacheupdatefrequency,
  $server_startdbsyncers		= $zabbix::params::server_startdbsyncers,
  $server_historycachesize		= $zabbix::params::server_historycachesize,
  $server_trendcachesize		= $zabbix::params::server_trendcachesize,
  $server_historytextcachesize		= $zabbix::params::server_historytextcachesize,
  $server_valuecachesize		= $zabbix::params::server_valuecachesize,
  $server_timeout			= $zabbix::params::server_timeout,
  $server_trappertimeout		= $zabbix::params::server_trappertimeout,
  $server_unreachableperiod		= $zabbix::params::server_unreachableperiod,
  $server_unavailabledelay		= $zabbix::params::server_unavailabledelay,
  $server_unreachabledelay		= $zabbix::params::server_unreachabledelay,
  $server_alertscriptspath		= $zabbix::params::server_alertscriptspath,
  $server_externalscripts		= $zabbix::params::server_externalscripts,
  $server_fpinglocation			= $zabbix::params::server_fpinglocation,
  $server_fping6location		= $zabbix::params::server_fping6location,
  $server_sshkeylocation		= $zabbix::params::server_sshkeylocation,
  $server_logslowqueries		= $zabbix::params::server_logslowqueries,
  $server_tmpdir			= $zabbix::params::server_tmpdir,
  $server_startproxypollers		= $zabbix::params::server_startproxypollers,
  $server_proxyconfigfrequency		= $zabbix::params::server_proxyconfigfrequency,
  $server_proxydatafrequency		= $zabbix::params::server_proxydatafrequency,
  $server_allowroot			= $zabbix::params::server_allowroot,
  $server_user				= $zabbix::params::server_user,
  $server_include			= $zabbix::params::server_include,
  $server_sslcertlocation		= $zabbix::params::server_sslcertlocation,
  $server_sslkeylocation		= $zabbix::params::server_sslkeylocation,
  $server_sslcalocation			= $zabbix::params::server_sslcalocation,
  $server_loadmodulepath		= $zabbix::params::server_loadmodulepath,
  $server_loadmodule			= $zabbix::params::server_loadmodule,

) inherits zabbix::params {

  # Validate the variables
  validate_string($database)
  validate_bool($web)
  validate_string($web_packagename)
  validate_bool($web_japanese)

  validate_bool($service_manage)
  validate_string($service_ensure)
  validate_bool($service_enable)

  include ::zabbix::server::install
  include ::zabbix::server::service

}
