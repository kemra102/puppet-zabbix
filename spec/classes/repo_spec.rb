require 'spec_helper'
describe 'zabbix::repo', :type => :class do
  context 'default parameters on RedHat 7' do
    let (:facts) {{
      :osfamily                  => 'RedHat',
      :operatingsystem           => 'RedHat',
      :operatingsystemmajrelease => '7',
      :architecture              => 'x86_64',
    }}
    it {
      should contain_yumrepo('zabbix').with({
        'ensure'   => 'present',
        'descr'    => 'Zabbix Official Repository - $basearch',
        'baseurl'  => 'http://repo.zabbix.com/zabbix/2.4/rhel/7/x86_64/',
        'enabled'  => 'true',
        'gpgkey'   => 'http://repo.zabbix.com/RPM-GPG-KEY-ZABBIX',
        'gpgcheck' => 'true',
      })
      should contain_yumrepo('zabbix-non-supported').with({
        'ensure'   => 'present',
        'descr'    => 'Zabbix Official Repository non-supported - $basearch',
        'baseurl'  => 'http://repo.zabbix.com/non-supported/rhel/7/x86_64/',
        'enabled'  => 'true',
        'gpgkey'   => 'http://repo.zabbix.com/RPM-GPG-KEY-ZABBIX',
        'gpgcheck' => 'true',
      })
    }
  end
end
