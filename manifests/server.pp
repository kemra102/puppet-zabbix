class zabbix::server (

  # Allow for overrides of variables in params.pp
  $database		= $zabbix::params::server_database,
  $web			= $zabbix::params::server_web,
  $web_packagename	= $zabbix::params::server_web_packagename,
  $web_japanese		= $zabbix::params::server_web_japanese,

  $service_manage	= $zabbix::params::server_service_manage,
  $service_ensure	= $zabbix::params::server_service_ensure,
  $service_enable	= $zabbix::params::server_service_enable,

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
