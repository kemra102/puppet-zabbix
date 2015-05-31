class zabbix::client::install (

) inherits zabbix::client {

  require '::zabbix::repo'
  include '::zabbix::repo'

  package { 'zabbix-agent':
    ensure => present,
  }

  file { '/etc/zabbix/zabbix_agentd.conf':
    ensure  => file,
    content => template('zabbix/zabbix_agentd.conf.erb'),
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    require => Package['zabbix-agent'],
  }

}
