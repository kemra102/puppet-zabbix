class zabbix::server::install (

  $database        = $zabbix::server::database,
  $web             = $zabbix::server::web,
  $web_packagename = $zabbix::server::web_packagename,
  $web_japanese    = $zabbix::server::web_japanese,

) inherits zabbix::server {

  require ::zabbix::repo
  include ::zabbix::repo

  package { 'zabbix-server':
    ensure => present,
    name   => "zabbix-server-${database}",
  }

  if $web == true {
    package { 'zabbix-web':
      ensure  => present,
      name    => $web_packagename,
      require => Package['zabbix-server'],
    }
  }

  if $web_japanese == true and $::osfamily == 'RedHat' {
    package { 'zabbix-web-japanese':
      ensure  => present,
      require => Package['zabbix-web'],
    }
  }

  file { '/etc/zabbix/zabbix_server.conf':
    ensure  => file,
    content => template('zabbix/zabbix_server.conf.erb'),
    mode    => '0640',
    owner   => 'root',
    group   => 'root',
    require => Package['zabbix-server'],
  }

}
