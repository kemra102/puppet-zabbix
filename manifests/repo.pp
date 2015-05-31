class zabbix::repo (

  $version = $::zabbix::params::version,

) inherits zabbix::params {

  case $::osfamily {
    'RedHat': {
      yumrepo { 'zabbix':
        ensure   => present,
        descr    => 'Zabbix Official Repository - $basearch',
        baseurl  => "http://repo.zabbix.com/zabbix/${version}/rhel/${::operatingsystemmajrelease}/${::architecture}/",
        enabled  => true,
        gpgkey   => 'http://repo.zabbix.com/RPM-GPG-KEY-ZABBIX',
        gpgcheck => true,
      }
      yumrepo { 'zabbix-non-supported':
        ensure   => present,
        descr    => 'Zabbix Official Repository non-supported - $basearch',
        baseurl  => "http://repo.zabbix.com/non-supported/rhel/${::operatingsystemmajrelease}/${::architecture}/",
        enabled  => true,
        gpgkey   => 'http://repo.zabbix.com/RPM-GPG-KEY-ZABBIX',
        gpgcheck => true,
      }
    }
    'Debian': {
      case $::operatingsystem {
        'Ubuntu': {
          include '::apt'
          apt::source { 'ubuntu-zabbix':
            location => "http://repo.zabbix.com/zabbix/${version}/ubuntu/",
            release  => $::lsbdistcodename,
            repos    => 'main non-free contrib',
            key      => {
              id     => '79EA5ED4',
              server => 'keyserver.ubuntu.com',
            },
          }
        }
        'Debian': {
          include '::apt'
          apt::source { 'debian-zabbix':
            location => "http://repo.zabbix.com/zabbix/${version}/debian/",
            release  => $::lsbdistcodename,
            repos    => 'main non-free contrib',
            key      => {
              id     => '79EA5ED4',
              server => 'keyserver.ubuntu.com',
            },
          }
        }
        default: {
          fail("${::operatingsystem} ${::operatingsystemmajrelease} 
          is not supported by this module.")
        }
      }
    }
    default: {
      fail("${::operatingsystem} ${::operatingsystemmajrelease} 
      is not supported by this module.")
    }
  }

}
