class zabbix::server::service (

  $service_manage       = $zabbix::server::service_manage,
  $service_ensure       = $zabbix::server::service_ensure,
  $service_enable       = $zabbix::server::service_enable,

) inherits zabbix::server {

  if $service_manage == true {
    service { 'zabbix-server':
      ensure            => $service_ensure,
      enable            => $service_enable,
      hasstatus         => true,
      hasrestart        => true,
      require           => File['/etc/zabbix/zabbix_server.conf'],
      subscribe         => File['/etc/zabbix/zabbix_server.conf'],
    }
    service { 'httpd':
      ensure            => $service_ensure,
      enable            => $service_enable,
      hasstatus         => true,
      hasrestart        => true,
      require           => Service['zabbix-server'],
      subscribe         => Service['zabbix-server'],
    }
  }

}
