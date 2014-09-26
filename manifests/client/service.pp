class zabbix::client::service inherits zabbix::params {

  service { 'zabbix-agent':
    ensure            => $client_service_ensure,
    enable            => $client_service_enable,
    hasstatus         => true,
    hasrestart        => true,
    require           => File['/etc/zabbix/zabbix_agentd.conf'],
  }

}
