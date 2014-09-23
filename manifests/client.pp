class zabbix::client {

  include ::zabbix::client::install
  Include ::zabbix::client::service

}
