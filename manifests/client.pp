class zabbix::client {

  include ::zabbix::client::install
  include ::zabbix::client::service

}
