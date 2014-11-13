class zabbix::server (

  # Allow for overrides of variables in params.pp
  $database			= $zabbix::params::server_database,
  $web				= $zabbix::params::server_web,
  $web_packagename		= $zabbix::params::server_web_packagename,
  $web_japanese			= $zabbix::params::server_web_japanese,

  $service_manage		= $zabbix::params::server_service_manage,
  $service_ensure		= $zabbix::params::server_service_ensure,
  $service_enable		= $zabbix::params::server_service_enable,
  $listenport			= $zabbix::params::server_listenport,
  $sourceip			= $zabbix::params::server_sourceip,
  $logfile			= $zabbix::params::server_logfile,
  $logfilesize			= $zabbix::params::server_logfilesize,
  $debuglevel			= $zabbix::params::server_debuglevel,
  $pidfile			= $zabbix::params::server_pidfile,
  $dbhost			= $zabbix::params::server_dbhost,
  $dbname			= $zabbix::params::server_dbname,
  $dbuser			= $zabbix::params::server_dbuser,
  $dbpassword			= $zabbix::params::server_dbpassword,
  $dbsocket			= $zabbix::params::server_dbsocket,
  $dbport			= $zabbix::params::server_dbport,
  $startpollers			= $zabbix::params::server_startpollers,
  $startipmipollers		= $zabbix::params::server_startipmipollers,
  $startpollersunreachable	= $zabbix::params::server_startpollersunreachable,
  $startpingers			= $zabbix::params::server_startpingers,
  $startdiscoverers		= $zabbix::params::server_startdiscoverers,
  $starthttppollers		= $zabbix::params::server_starthttppollers,
  $starttimers			= $zabbix::params::server_starttimers,
  $javagateway			= $zabbix::params::server_javagateway,
  $javagatewayport		= $zabbix::params::server_javagatewayport,
  $startjavapollers		= $zabbix::params::server_startjavapollers,
  $startvmwarecollectors	= $zabbix::params::server_startvmwarecollectors,
  $vmwarecachesize		= $zabbix::params::server_vmwarecachesize,
  $snmptrapperfile		= $zabbix::params::server_snmptrapperfile,
  $startsnmptrapper		= $zabbix::params::server_startsnmptrapper,
  $listenip			= $zabbix::params::server_listenip,
  $housekeepingfrequency	= $zabbix::params::server_housekeepingfrequency,
  $maxhousekeeperdelete		= $zabbix::params::server_maxhousekeeperdelete,
  $senderfrequency		= $zabbix::params::server_senderfrequency,
  $cachesize			= $zabbix::params::server_cachesize,
  $cacheupdatefrequency		= $zabbix::params::server_cacheupdatefrequency,
  $startdbsyncers		= $zabbix::params::server_startdbsyncers,
  $historycachesize		= $zabbix::params::server_historycachesize,
  $trendcachesize		= $zabbix::params::server_trendcachesize,
  $historytextcachesize		= $zabbix::params::server_historytextcachesize,
  $valuecachesize		= $zabbix::params::server_valuecachesize,
  $timeout			= $zabbix::params::server_timeout,
  $trappertimeout		= $zabbix::params::server_trappertimeout,
  $unreachableperiod		= $zabbix::params::server_unreachableperiod,
  $unavailabledelay		= $zabbix::params::server_unavailabledelay,
  $unreachabledelay		= $zabbix::params::server_unreachabledelay,
  $alertscriptspath		= $zabbix::params::server_alertscriptspath,
  $externalscripts		= $zabbix::params::server_externalscripts,
  $fpinglocation		= $zabbix::params::server_fpinglocation,
  $fping6location		= $zabbix::params::server_fping6location,
  $sshkeylocation		= $zabbix::params::server_sshkeylocation,
  $logslowqueries		= $zabbix::params::server_logslowqueries,
  $tmpdir			= $zabbix::params::server_tmpdir,
  $startproxypollers		= $zabbix::params::server_startproxypollers,
  $proxyconfigfrequency		= $zabbix::params::server_proxyconfigfrequency,
  $proxydatafrequency		= $zabbix::params::server_proxydatafrequency,
  $allowroot			= $zabbix::params::server_allowroot,
  $user				= $zabbix::params::server_user,
  $include			= $zabbix::params::server_include,
  $sslcertlocation		= $zabbix::params::server_sslcertlocation,
  $sslkeylocation		= $zabbix::params::server_sslkeylocation,
  $sslcalocation		= $zabbix::params::server_sslcalocation,
  $loadmodulepath		= $zabbix::params::server_loadmodulepath,
  $loadmodule			= $zabbix::params::server_loadmodule,

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
