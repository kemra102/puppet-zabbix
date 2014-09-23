class zabbix::repo inherits zabbix::params {

  yumrepo { 'zabbix':
    ensure	=> present,
    descr	=> 'Zabbix Official Repository - $basearch',
    baseurl	=> "http://repo.zabbix.com/zabbix/$::zabbix::versio/rhel/$::operatingsystemmajrelease/$::architecture/",
    enabled	=> true,
    gpgkey	=> 'http://repo.zabbix.com/RPM-GPG-KEY-ZABBIX',
    gpgcheck	=> true,
  }

}
