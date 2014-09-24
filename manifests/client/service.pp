class zabbix::client::service inherits zabbix::params {

  if ($client_startagents != '0' and $client_server == '') {
    fail("Your StartAgents cannot be greater than 0 or null when Server is also null. Set StartAgents to 0 or set Server.")
  }
  if ($client_server == '' and $client_serveractive == '') {
    fail("You must set either passvie or active (or both) checks via the Server or ServerActive options.")
  }
  else {
    service { 'zabbix-agent':
      ensure            => $client_service_ensure,
      enable            => $client_service_enable,
      hasstatus         => true,
      hasrestart        => true,
      require           => File['/etc/zabbix/zabbix_agentd.conf'],
    }
  }

}
