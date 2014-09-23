class zabbix::repo {

  yumrepo { 'zabbix':
    ensure	=> present,
    descr	=> 'Zabbix Official Repository - $basearch',
    baseurl	=> "http://repo.zabbix.com/zabbix/%{::zabbix::version}/rhel/%{::operatingsystemmajrelease}/$basearch/",
    enabled	=> true,
    gpgkey	=> 'http://repo.zabbix.com/RPM-GPG-KEY-ZABBIX',
    gpgcheck	=> true,
  }

}
