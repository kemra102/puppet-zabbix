zabbixclient = `zabbix_agentd --version 2>&1`.split(" ")[3].gsub(/v/, '')

if zabbixclient =~ /([0-9\.]{5,6})/
  Facter.add("zabbixclient") { setcode { zabbixclient } }
end
