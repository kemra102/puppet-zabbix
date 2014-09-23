class zabbix::client::install {

  include ::zabbix::repo

  package { 'zabbix-agent':
    ensure	=> present,
    require	=> Yumrepo{'zabbix'],
  }

  file { '/etc/zabbix/zabbix_agentd.conf':
    ensure	=> file,
    content	=> template('zabbix/zabbix_agentd.conf.erb'),
    mode	=> '644',
    owner	=> 'root',
    group	=> 'root',
  }

}
