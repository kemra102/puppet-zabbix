zabbixserver = `zabbix_server --version 2>&1`.split(" ")[2].gsub(/v/, '')

if zabbixserver =~ /([0-9\.]{5,6})/
  Facter.add("zabbixserver") { setcode { zabbixserver } }
end
