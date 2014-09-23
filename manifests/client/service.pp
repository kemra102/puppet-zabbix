class zabbix::client::service {

  # manage the service only if asked
  if $::zabbix::client_service_manage == true {
    service { 'zabbix-agent':
      ensure		=> $::zabbix::client_service_ensure,
      enable		=> $::zabbix::client_service_enable,
      hasstatus		=> true,
      hasrestart	=> true,
    }
  }

}
