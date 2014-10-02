class zabbix::repo inherits zabbix::params {

  case $::osfamily {
    'RedHat': {
      yumrepo { 'zabbix':
        ensure		=> present,
        descr		=> 'Zabbix Official Repository - $basearch',
        baseurl		=> "http://repo.zabbix.com/zabbix/$version/rhel/$::operatingsystemmajrelease/$::architecture/",
        enabled		=> true,
        gpgkey		=> 'http://repo.zabbix.com/RPM-GPG-KEY-ZABBIX',
        gpgcheck	=> true,
      }
    }
    'Debian': {
      case $::operatingsystem {
        'Ubuntu': {
          apt::source { 'ubuntu-zabbix':
            location	=> "http://repo.zabbix.com/zabbix/$version/ubuntu/",
            release	=> "$::lsbdistcodename",
            repos	=> 'main non-free contrib',
            key		=> '79EA5ED4',
            key_server	=> 'keyserver.ubuntu.com',
          }
        }
        'Debian': {
          apt::source { 'debian-zabbix':
            location    => "http://repo.zabbix.com/zabbix/$version/debian/",
            release     => "$::lsbdistcodename",
            repos       => 'main non-free contrib',
            key         => '79EA5ED4',
            key_server  => 'keyserver.ubuntu.com',
          }
        }
      }
    }
  }

}
