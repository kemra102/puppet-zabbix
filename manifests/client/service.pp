class zabbix::client::service {

  # check ensure has the correct variable
  if !($::zabbix::client_service_ensure in ['running', 'stopped']) {
    fail('client_service_ensure parameter must be running or stopped')
  }

  # manage the service only if asked
  if $::zabbix::client_service_manage == true {
    service { 'zabbix-agent':
      ensure		=> $::zabbix::client_service_ensure
      enable		=> $::zabbix::client_service_enable
      hasstatus		=> true,
      hasrestart	=> true,
    }

}
