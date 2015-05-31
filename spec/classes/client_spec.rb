require 'spec_helper'
describe 'zabbix::client', :type => :class do
  context 'default parameters on RedHat 7' do
    let (:facts) {{
      :osfamily                  => 'RedHat',
      :operatingsystem           => 'RedHat',
      :operatingsystemmajrelease => '7',
      :architecture              => 'x86_64',
    }}
    it {
      should create_class('zabbix::client')
      should contain_class('zabbix::client::install')
      should contain_class('zabbix::client::service')
      should contain_class('zabbix::repo')
      should contain_package('zabbix-agent').with_ensure('present')
      should contain_file('/etc/zabbix/zabbix_agentd.conf').with({
        'ensure' => 'file',
        'mode'   => '0644',
        'owner'  => 'root',
        'group'  => 'root',
      })
      should contain_service('zabbix-agent').with({
        'ensure'     => 'running',
        'enable'     => 'true',
        'hasstatus'  => 'true',
        'hasrestart' => 'true',
      })
    }
  end
end
