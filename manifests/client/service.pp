class zabbix::client::service (

  $service_manage       = $zabbix::client::service_manage,
  $service_ensure       = $zabbix::client::service_ensure,
  $service_enable       = $zabbix::client::service_enable,

) inherits zabbix::client {

  if $service_manage == true {
    service { 'zabbix-agent':
      ensure            => $service_ensure,
      enable            => $service_enable,
      hasstatus         => true,
      hasrestart        => true,
      require           => File['/etc/zabbix/zabbix_agentd.conf'],
      subscribe         => File['/etc/zabbix/zabbix_agentd.conf'],
    }
  }

}
