require 'spec_helper'
describe 'zabbix::server', :type => :class do
  context 'default parameters on RedHat 7' do
    let (:facts) {{
      :osfamily                  => 'Redhat',
      :operatingsystem           => 'RedHat',
      :operatingsystemmajrelease => '7',
    }}
    it {
      should create_class('zabbix::server')
      should contain_class('zabbix::server::install')
      should contain_class('zabbix::server::service')
      should contain_class('zabbix::repo')
      should contain_package('zabbix-server').with({
        'ensure' => 'present',
        'name'   => 'zabbix-server-mysql',
      })
      should contain_package('zabbix-web').with({
        'ensure' => 'present',
        'name'   => 'zabbix-web-mysql',
      })
      should contain_file('/etc/zabbix/zabbix_server.conf').with({
        'ensure' => 'file',
        'mode'   => '0640',
        'owner'  => 'root',
        'group'  => 'root',
      })
      should contain_service('zabbix-server').with({
        'ensure'     => 'running',
        'enable'     => 'true',
        'hasstatus'  => 'true',
        'hasrestart' => 'true',
      })
      should contain_service('httpd').with({
        'ensure'     => 'running',
        'enable'     => 'true',
        'hasstatus'  => 'true',
        'hasrestart' => 'true',
      })
    }
  end
  context 'with japanese support on RedHat 7' do
    let (:facts) {{
      :osfamily                  => 'RedHat',
      :operatingsystem           => 'RedHat',
      :operatingsystemmajrelease => '7',
    }}
    let (:params) {{ :web_japanese => true }}
    it{
      should contain_package('zabbix-web-japanese').with_ensure('present')
    }
  end
end
