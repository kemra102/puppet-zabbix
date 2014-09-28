# zabbix

####Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with zabbix](#setup)
    * [What zabbix affects](#what-zabbix-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with zabbix](#beginning-with-zabbix)
4. [Usage - Configuration options and additional functionality](#usage)
    * [Usage - Zabbix Client (Agent)](#usage-zabbix-client)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

##Overview

Module for managing Zabbix Server & Client.

##Module Description

The zabbix module currently only supports installing and configuring the Zabbix client (agent). Furture support is planned for the se
rver, UserParameters and more.

##Setup

###What zabbix affects

* zabbix-agent package.
* zabbix client (agent) configuration file
* zabbix-agent service.

###Beginning with zabbix

`include ::zabbix::client` is enough to install the client with a default configuration file.

If you want to specify some parameters, for example setting the **Server** variable:

```puppet
class { '::zabbix::client':
  server	=> '192.168.32.100',
}
```

Or if you use Hiera:

```puppet
---
zabbix::client::server: '192.168.32.100'
```

##Usage

Managing the zabbix client is done through the `::zabbix::client` class including affecting it's variables.

###Usage - Zabbix Client

####I just want Zabbix Client, what's the minimum I need?

```puppet
include ::zabbix::client
```

####I just want to tweak the Server, nothing else.

```puppet
class { '::zabbix::client':
  server	=> '192.168.32.100',
}
```

###We have a custom set-up and use Hiera to set our config.

```puppet
---
zabbix::client::server: '192.168.32.100'
zabbix::client::listenport: '10051'
zabbix::client::listenip: %{::ipaddress_em2}
```
##Reference

###Classes

####Public Classes

* zabbix::client: Main class for the client (agent), installs, configures and manages the service.

####Private Classes

* zabbix::repo: Sets up the Zabbix repo.
* zabbix::client::install: Sets up the Zabbix repo, installs the `zabbix-agent` package and manages the zabbix client configuration file.
* zabbix::client::service: Manages the `zabbix-agent` service.

###Client Parameters

####`service_ensure`

Whether or not the service should be one of 2 values; `running` or `stopped`.

Default: `running`

####`service enable`

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

####`logremote commands`

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

##Limitations

This module has been tested against the latest version of Puppet from the Puppetlabs repo for platforms it is tested on.

The module has been tested on:

* CentOS 6.5

This module should work fine on:

* CentOS 5
* Red Hat 5/6
* Scientific Linux 5/6

Future support is planned for:

* Ubuntu 10.04, 12.04 & 14.04
* Debian 7

##Development

This module is open source under the **BSD 2-Clause** license and contributions to this module are welcome. Merge requests should be filed via GitHub.

Areas of particular interest that help would be appreciated in:

* Testing
* Adding support for other platforms
* Adding missing functionality
* Filing bugfixes
* Documentation improvements

###Contributors

The list of contributors can be found at: [https://github.com/kemra102/puppet-zabbix/graphs/contributors](https://github.com/kemra102/puppet-zabbix/graphs/contributors)
