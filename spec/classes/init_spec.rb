require 'spec_helper'
describe 'zabbix', :type => :class do
  context 'default parameters on RedHat 7' do
    let (:facts) {{
      :osfamily                  => 'RedHat',
      :operatingsystem           => 'RedHat',
      :operatingsystemmajrelease => '7',
    }}
    it {
      should create_class('zabbix::client')
      should create_class('zabbix::server')
      should contain_class('zabbix::repo')
    }
  end
end
