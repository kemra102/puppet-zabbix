# zabbix

####Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with zabbix](#setup)
    * [What zabbix affects](#what-zabbix-affects)
    * [Beginning with Zabbix Client](#beginning-with-zabbix-client)
    * [Beginning with Zabbix Server](#beginning-with-zabbix-server)
4. [Usage - Configuration options and additional functionality](#usage)
    * [Usage - Zabbix Client (Agent)](#zabbix-client)
    * [Usage - UserParameters](#userparameters)
    * [Usage - Zabbix Server](#zabbix-server)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

##Overview

Module for managing Zabbix Server & Client.

##Module Description

The zabbix module currently only supports installing and configuring the Zabbix client (agent), as well as creating UserParameters. Furture support is planned for the server and proxies.

##Setup

###What zabbix affects

* Zabbix Client (Agent) Installation, Configuration & Service.
* UserParameters.
* Server Installation, Configuration & Service.
* Zabbix Server WebUI.

###Beginning with Zabbix Client

`include ::zabbix::client` is enough to install the client with a default configuration file.

If you want to specify some parameters, for example setting the **Server** variable:

```puppet
class { '::zabbix::client':
  server => '192.168.32.100',
}
```

Or if you use Hiera:

```puppet
---
zabbix::client::server: '192.168.32.100'
```

###Beginning with Zabbix Server

`include ::zabbix::server` is enough to install the server and WebUI with a default configuration file.

If you want to specify some parameters, for example setting some custom database details:

```puppet
class { '::zabbix::server':
  dbhost => '192.168.32.100',
  dbname => 'zabbixserver',
  dbuser => 'zabbixserver',
}
```

Or if you use Hiera:

```puppet
---
zabbix::server::dbhost: '192.168.32.100'
zabbix::server::dbname: 'zabbixserver'
zabbix::server::dbuser: 'zabbixserver'

##Usage

Managing the zabbix client is done through the `::zabbix::client` class including interacting with it's variables.

Managing the zabbix server is done through the `::zabbix::server` class including interacting with it's variables.

###Zabbix Client

####I just want Zabbix Client, what's the minimum I need?

```puppet
include ::zabbix::client
```

####I just want to tweak the Server, nothing else.

```puppet
class { '::zabbix::client':
  server => '192.168.32.100',
}
```

####We have a custom set-up and use Hiera to set our config.

```puppet
---
zabbix::client::server: '192.168.32.100'
zabbix::client::listenport: '10051'
zabbix::client::listenip: %{::ipaddress_em2}
```

###UserParameters

To create a user parameter include the following in your config:

```puppet
zabbix::client::userparameter { 'mysql':
  key     => 'mysql.ping',
  command => 'mysqladmin -uroot ping|grep -c alive',
}
```

You can also include an optional **comment** option:

```puppet
zabbix::client::userparameter { 'mysql':
  comment => 'Check if MySQL is alive.',
  key     => 'mysql.ping',
  command => 'mysqladmin -uroot ping|grep -c alive',
}
```

###Zabbix Server

####I just want Zabbix Server, what's the minimum I need?

```puppet
include ::zabbix::server
```

####I want to use PostgreSQL instead of MySQL, what do I need as a minimum?.

```puppet
class { '::zabbix::server':
  database => 'pgsql',
}
```

####We have a custom set-up and use Hiera to set our config.

```puppet
---
zabbix::server::database: 'pgsql'
```

##Reference

###Classes

####Public Classes

* zabbix::client: Main class for the client (agent), installs, configures & manages the service.
* zabbix::client::userparameter: Main class for declaring Zabbix Userparameter's.
* zabbix::server: Main class for the server & WebUI, installs, configures & manages the service.

####Private Classes

* zabbix::repo: Sets up the Zabbix repo.
* zabbix::client::install: Sets up the Zabbix repo, installs the `zabbix-agent` package and manages the zabbix client configuration file.
* zabbix::client::service: Manages the `zabbix-agent` service.
* zabbix::server::install: Sets up the Zabbix repo, installs the packages required for the Server, Database conenctivity & WebUI, & manages the zabbix server configuration file.
* zabbix::server::service: Manages the `zabbix-server` service.

###Global Parameters

####`version`

Sets the version of Zabbix to be used.

Defaults:

* EL 6, Ubuntu 14.04 & Debian 7: 2.4
* EL 5, Ubuntu 12.04 & Debian 6: 2.2
* Ubuntu 10.04: 2.0

###Client Parameters

####`service_manage`

Boolean whether or not to manage the zabbix-agent service.

Default: `true`

####`service_ensure`

Whether or not the service should be one of 2 values; `running` or `stopped`.

Default: `running`

####`service_enable`

Boolean whether or not the service should be started on system boot.

Default: `true`

####`pidfile`

Sets the location for the pid file.

Default: `/var/run/zabbix/zabbix_agentd.pid`

####`logfile`

Sets the location for the log file.

Default: `/var/log/zabbix/zabbix_agentd.log`

####`logfilesize`

Sets the maximum log file size in MB.

Default: `1`

####`debuglevel`

Sets the debug log level:

* 0 - No debug.
* 1 - Critical info.
* 2 - Error info.
* 3 - Warnings.
* 4 - For debugging (produces LOTS of info).

Default: `3`

####`sourceip`

Source IP address for outgoing connections.

####`enableremotecommands`

Whether remote commands from Zabbix server are allowed:

* 0 - Not allowed.
* 1 - Allowed.

Default: `0`

####`logremotecommands`

Enable logging of executed shell commands as warnings:

* 0 - Disabled.
* 1 - Enabled.

Default: `0`

####`server`

List of comma delimited IP addresses (or hostnames) of Zabbix servers. Incoming connections will be accepted only from the hosts listed here. No spaces allowed. If IPv6 support is enabled then `127.0.0.1`, `::127.0.0.1`, `::ffff:127.0.0.1` are treated equally.

####`listenport`

Client (agent) will listen on this port for connections from the server.

Default: `10050`

####`listenip`

List of comma delimited IP addresses that the client (agent) should listen on. First IP address is sent to Zabbix server if connecting to it to retrieve list of active checks.

####`startagents`

Number of pre-forked instances of zabbix_agentd that process passive checks. If set to 0, disables passive checks and the agent will not listen on any TCP port.

Default: `3`

####`serveractive`

List of comma delimited IP:port (or hostname:port) pairs of Zabbix servers for active checks. If port is not specified, default port is used. IPv6 addresses must be enclosed in square brackets if port for that host is specified.  If port is not specified, square brackets for IPv6 addresses are optional. If this parameter is not specified, active checks are disabled.

####`hostname`

Unique, case sensitive hostname. Required for active checks and must match hostname as configured on the server. Value is acquired from HostnameItem if undefined.

####`hostnameitem`

Item used for generating Hostname if it is undefined. Ignored if Hostname is defined.

Default: `HostnameItem=system.hostname`

####`refreshactivechecks`

How often list of active checks is refreshed, in seconds.

Default: `120`

####`buffersend`
See 'zabbix_agentd' directory for examples.
Do not keep data longer than N seconds in buffer.

Default: `5`

####`buffersize`

Maximum number of values in a memory buffer. The agent will send all collected data to Zabbix Server or Proxy if the buffer is full.

Default=`100`

####`maxlinespersecond`

Maximum number of new lines the client (agent) will send per second to Zabbix Server or Proxy processing 'log' and 'logrt' active checks. The provided value will be overridden by the parameter 'maxlines', provided in 'log' or 'logrt' item keys.

Default: `100`

####`allowroot`

Allow the agent to run as 'root'. If disabled and the agent is started by 'root', the agent will try to switch to user 'zabbix' instead. Has no effect if started under a regular user:

* 0 - N:ot allowed.
* 1 - Allowed.

Default `0`

####`parameteralias`

Sets an alias for parameter. It can be useful to substitute long and complex parameter name with a smaller and simpler one.

####`timeout`

Spend no more than Timeout seconds on processing.

Default: `3`

####`include`

Directory that service looks in for additonal configuration files during start-up.

Default: `/etc/zabbix/zabbix_agentd.d/`

####`unsafeuserparameters`

Allow all characters to be passed in arguments to user-defined parameters:

* 0 - Not allowed.
* 1 - Allowed.

Default: `0`

####`userparameters`

User-defined parameter to monitor. There can be several user-defined parameters. Format: *UserParameter=<key>,<shell command>*.

###Server Parameters

####`database`

Sets the Database to be used for Zabbix server. Can be one of:

* mysql - MySQL
* pgsql - PostgreSQL
* sqlite3 - SQLite

Default: `mysql`

####`web`

Boolean whether or not the WebUI should be installed.

Default: `true`

####`web_packagename`

Defines the package name for the WebUI.

####`web_japanese`

Boolean whether or not the WebUI Japanese language support should be installed.

Default: `false`

####`service_manage`

Boolean whether or not to manage the zabbix-server service.

Default: `true`

####`service_ensure`

Whether or not the service should be one of 2 values; `running` or `stopped`.

Default: `running`

####`service_enable`

Boolean whether or not the service should be started on system boot.

Default: `true`

####`listenport`

Listen port for trapper.

Default: `10051`

####`sourceip`

Source IP address for outgoing connections.

####`logfile`

Name of log file. If not set, syslog is used.

Default: `/var/log/zabbix/zabbix_server.log`

####`logfilesize`

Maximum size of log file in MB. ***0*** - disable automatic log rotation.

Default: `0`

####`debuglevel`

* 0 - No debug.
* 1 - Critical info.
* 2 - Error info.
* 3 - Warnings.
* 4 - For debugging (produces LOTS of info).

Default: `3`

####`pidfile`

Name of PID file.

Default: `/var/run/zabbix/zabbix_server.pid`

####`dbhost`

Database host name. If set to localhost, socket is used for MySQL. If set to empty string, socket is used for PostgreSQL.

Default: `localhost`

####`dbname`

Database name. For SQLite3 path to database file must be provided. DBUser and DBPassword are ignored.

Default: `zabbix`

####`dbschema`

Schema name. Used for IBM DB2 and PostgreSQL.

####`dbuser`

Database user. Ignored for SQLite.

Default: `zabbix`

####`dbpassword`

Database password. Ignored for SQLite.

####`dbsocket`

Path to MySQL socket.

Default: `/var/lib/mysql/mysql.sock`

####`dbport`

Database port when not using local socket. Ignored for SQLite.

Defaults:

* MySQL: 3306
* PostgreSQL: 5432

####`startpollers`

Number of pre-forked instances of pollers.

Default: `5`

####`startipmipollers`

Number of pre-forked instances of IPMI pollers.

Default: `0`

####`startpollersunreachable`

Number of pre-forked instances of pollers for unreachable hosts (including IPMI and Java). At least one poller for unreachable hosts must be running if regular, IPMI or Java pollers are started.

Default: `1`

####`starttrappers`

Number of pre-forked instances of trappers. Trappers accept incoming connections from Zabbix sender, active agents and active proxies. At least one trapper process must be running to display server availability and view queue in the frontend.

Default: `5`

####`startpingers`

Number of pre-forked instances of ICMP pingers.

Default: `1`

####`stratdiscoverers`

Number of pre-forked instances of discoverers.

Default: `1`

####`starthttppollers`

Number of pre-forked instances of HTTP pollers.

Default: `1`

####`starttimers`

Number of pre-forked instances of timers. Timers process time-based trigger functions and maintenance periods. Only the first timer process handles the maintenance periods.

Default: `1`

####`javagateway`

IP address (or hostname) of Zabbix Java gateway. Only required if Java pollers are started.

####`javagatewayport`

Port that Zabbix Java gateway listens on.

Default: `10052`

####`startjavapollers`

Number of pre-forked instances of Java pollers.

Default: `0`

####`startvmwarecollectors`

Number of pre-forked vmware collector instances.

Default: `0`

####`vmwarefrequency`

How often Zabbix will connect to VMware service to obtain a new data.

Default: `60`

####`vmwarecachesize`

Size of VMware cache, in bytes. Shared memory size for storing VMware data. Only used if VMware collectors are started.

Default: `8M`

####`snmptrapperfile`

Temporary file used for passing data from SNMP trap daemon to the server. Must be the same as in zabbix_trap_receiver.pl or SNMPTT configuration file.

Default: `/var/log/snmptt/snmptt.log`

####`startsnmptrapper`

If 1, SNMP trapper process is started.

Default: `0`

####`listenip`

List of comma delimited IP addresses that the trapper should listen on. Trapper will listen on all network interfaces if this parameter is missing.

Default: `0.0.0.0`

####`housekeepingfrequency`

How often Zabbix will perform housekeeping procedure (in hours). Housekeeping is removing unnecessary information from history, alert, alarm, and other tables. To prevent housekeeper from being overloaded (for example, when history and trend periods are greatly reduced), no more than 4xHousekeepingFrequency hours of outdated history are deleted in one housekeeping cycle, for each item. To lower load on server startup housekeeping is postponed for 30 minutes after server start.

Default: `1`

####`maxhousekeeperdelete`

The table "housekeeper" contains "tasks" for housekeeping procedure in the format:

[housekeeperid], [tablename], [field], [value].

No more than 'MaxHousekeeperDelete' rows (corresponding to [tablename], [field], [value]) will be deleted per one task in one housekeeping cycle. SQLite3 does not use this parameter, deletes all corresponding rows without a limit. If set to 0 then no limit is used at all. In this case you must know what you are doing!

Default: `500`

####`senderfrequency`

How often Zabbix will try to send unsent alerts (in seconds).

Default: `30`

####`cachesize`

Size of configuration cache, in bytes. Shared memory size for storing host, item and trigger data.

Default: `8M`

####`cacheupdatefrequency`

How often Zabbix will perform update of configuration cache, in seconds.

Default: `60`

####`startdbsyncers`

Number of pre-forked instances of DB Syncers.

Default: `4`

####`historycachesize`

Size of history cache, in bytes. Shared memory size for storing history data.

Default: `8M`

####`trendcachesize`

Size of trend cache, in bytes. Shared memory size for storing trends data.

Default: `4M`

####`historytextcachesize`

Size of text history cache, in bytes. Shared memory size for storing character, text or log history data.

Default: `16M`

####`valuecachesize`

Size of history value cache, in bytes. Shared memory size for caching item history data requests. Setting to 0 disables value cache.

Default: `8M`

####`timeout`

Specifies how long we wait for agent, SNMP device or external check (in seconds).

Default: `3`

####`trappertimeout`

Specifies how many seconds trapper may spend processing new data.

Default: `300`

####`unreachableperiod`

After how many seconds of unreachability treat a host as unavailable.

Default: `45`

####`unavailabledelay`

How often host is checked for availability during the unavailability period, in seconds.

Default: `60`

####`unreachabledelay`

How often host is checked for availability during the unreachability period, in seconds.

Default: `15`

####`alertscriptspath`

Full path to location of custom alert scripts.

Default: `/usr/lib/zabbix/alertscripts`

####`externalscriptspath`

Full path to location of external scripts.

Default: `/usr/lib/zabbix/externalscripts`

####`fpinglocation`

Location of fping. Make sure that fping binary has root ownership and SUID flag set.

Default: `/usr/sbin/fping`

####`fping6location`

Location of fping6. Make sure that fping6 binary has root ownership and SUID flag set. Make empty if your fping utility is capable to process IPv6 addresses.

Default: `/usr/sbin/fping6`

####`sshkeylocation`

Location of public and private keys for SSH checks and actions.

####`logslowqueries`

How long a database query may take before being logged (in milliseconds). Only works if DebugLevel set to 3 or 4.

0 - don't log slow queries.

Default: `0`

####`tmpdir`

Temporary directory.

Default: `/tmp`

####`startproxypollers`

Number of pre-forked instances of pollers for passive proxies.

Default: `1`

####`proxyconfigfrequency`

How often Zabbix Server sends configuration data to a Zabbix Proxy in seconds. This parameter is used only for proxies in the passive mode.

Default: `3600`

####`proxydatafrequency`

How often Zabbix Server requests history data from a Zabbix Proxy in seconds. This parameter is used only for proxies in the passive mode.

Default: `1`

####`allowroot`

Allow the server to run as 'root'. If disabled and the server is started by 'root', the server will try to switch to the user specified by the User configuration option instead. Has no effect if started under a regular user.

* 0 - do not allow
* 1 - allow

Default: `0`

####`user`

Drop privileges to a specific, existing user on the system. Only has effect if run as 'root' and AllowRoot is disabled.

Default: `zabbix`

####`include`

You may include individual files or all files in a directory in the configuration file.

####`sslcertlocation`

Location of SSL client certificates. This parameter is used only in web monitoring.

Default: `${datadir}/zabbix/ssl/certs`

####`sslkeylocation`

Location of private keys for SSL client certificates. This parameter is used only in web monitoring.

Default: `${datadir}/zabbix/ssl/keys`

####`sslcalocation`

Override the location of certificate authority (CA) files for SSL server certificate verification. If not set, system-wide directory will be used. This parameter is used only in web monitoring.

####`loadmodulepath`

Full path to location of server modules. 

Default: `${libdir}/modules`

####`loadmodule`

Module to load at server startup. Modules are used to extend functionality of the server.

Format: LoadModule=<module.so>

The modules must be located in directory specified by LoadModulePath. It is allowed to include multiple LoadModule parameters.

##Limitations

This module has been tested against the latest version of Puppet from the Puppetlabs repo for platforms it is tested on.

The module has been tested on:

* CentOS 5.11/6.6
* Scientific Linux 5.10/6.5
* Oracle Linux 5.11/6.5
* Ubuntu 10.04/12.04/14.04
* Debian 6/7

This module should also work fine on:

* Red Hat Enterprise Linux 5/6

##Development

This module is open source under the **BSD 2-Clause** license and contributions to this module are welcome. Merge requests should be filed via GitHub.

Areas of particular interest that help would be appreciated in:

* Testing (Particularly on RHEL systems)
* Adding missing functionality
* Filing bugfixes
* Documentation improvements

###Contributors

The list of contributors can be found at: [https://github.com/kemra102/puppet-zabbix/graphs/contributors](https://github.com/kemra102/puppet-zabbix/graphs/contributors)
