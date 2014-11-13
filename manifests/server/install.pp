class zabbix::server::install (

  $database		= $zabbix::server::database,
  $web			= $zabbix::server::web,
  $web_packagename	= $zabbix::server::web_packagename,
  $web_japanese		= $zabbix::server::web_japanese,

) inherits zabbix::server {

  require ::zabbix::repo
  include ::zabbix::repo

  package { 'zabbix-server':
    name   => "zabbix-server-$database",
    ensure => present,
  }

  if $web == true {
    package { 'zabbix-web':
      name    => $web_packagename,
      ensure  => present,
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
    mode    => '640',
    owner   => 'root',
    group   => 'root',
    require => Package['zabbix-server'],
  }

}
