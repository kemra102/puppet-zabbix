require 'spec_helper'
describe 'zabbix::client::userparameter', :type => :define do
  context 'test a simple userparameter' do
    let (:title) { 'mysql' }
    let (:params) {{
      :comment => 'Check MySQL is up',
      :key     => 'mysql.ping',
      :command => 'mysqladmin -uroot ping|grep -c alive',
    }}
    it {
      should contain_file('/etc/zabbix/zabbix_agentd.d/userparameter_mysql.conf').with_ensure('present')
      should contain_file('/etc/zabbix/zabbix_agentd.d/userparameter_mysql.conf').with_content(/^#Check MySQL is up$/)
      should contain_file('/etc/zabbix/zabbix_agentd.d/userparameter_mysql.conf').with_content(/^UserParameter=mysql.ping,mysqladmin -uroot ping|grep -c alive$/)
    }
  end
end
