define zabbix::client::userparameter (
  $ensure  = 'present',
  $comment = undef,
  $key     = undef,
  $command = undef,
) {

  if $comment != undef {
    validate_string($comment)
  }

  validate_string($key)
  validate_string($command)

  validate_re($ensure, '^(present|absent)$',
    "${ensure} is not supported for ensure. 
    Allowed values are 'present' and 'absent'.")

  file { "/etc/zabbix/zabbix_agentd.d/userparameter_${name}.conf":
    ensure  => $ensure,
    content => template('zabbix/user_parameter.conf.erb'),
    notify  => Service['zabbix-agent'],
  }

}
