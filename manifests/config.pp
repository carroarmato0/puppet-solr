# Manages basic configuration
class solr6::config {

  file { '/opt/solr':
    ensure => link,
    target => "/opt/solr-${::solr6::version}",
  }

  # Manage ownership and permission of default folders
  $default_folders = [
    "/opt/solr-${::solr6::version}",
    '/opt/solr/bin',
    $::solr6::data_dir,
    "${::solr6::data_dir}/solr",
    $::solr6::log_dir,
  ]

  file { $default_folders:
    ensure => directory,
    mode   => '0644',
    owner  => 'solr',
    group  => 'solr',
  }

  file { '/opt/solr/example':
    ensure       => directory,
    owner        => 'solr',
    group        => 'solr',
    recurse      => true,
    recurselimit => 4,
  }

  file { '/opt/solr/bin/solr.in.sh':
    ensure  => file,
    mode    => '0744',
    owner   => 'solr',
    group   => 'solr',
  }

  file_line { 'SOLR_DIR':
    ensure => present,
    path   => '/opt/solr/bin/solr.in.sh',
    line   => "SOLR_DIR=${solr6::params::base_dir}",
    match  => '^SOLR_DIR\=',
    notify => Service['solr'],
  }

  file_line { 'SOLR_PORT':
    ensure => present,
    path   => '/opt/solr/bin/solr.in.sh',
    line   => "SOLR_PORT=${solr6::port}",
    match  => '^SOLR_PORT\=',
    notify => Service['solr'],
  }

  file_line { 'SOLR_HEAP':
    ensure            => absent,
    path              => '/opt/solr/bin/solr.in.sh',
    line              => "SOLR_HEAP=*",
    match             => '^SOLR_HEAP\=',
    notify            => Service['solr'],
    match_for_absence => true,
  }

  file_line { 'SOLR_JAVA_MEM':
    ensure => present,
    path   => '/opt/solr/bin/solr.in.sh',
    line   => "SOLR_JAVA_MEM=\"-Xms${::solr6::memory} -Xmx${::solr6::memory}\"",
    match  => '^SOLR_JAVA_MEM\=',
    notify => Service['solr'],
  }

  file_line { 'SOLR_LOGS_DIR':
    ensure => present,
    path   => '/opt/solr/bin/solr.in.sh',
    line   => "SOLR_LOGS_DIR=${::solr6::log_dir}",
    match  => '^SOLR_LOGS_DIR\=',
    notify => Service['solr'],
  }

  file_line { 'SOLR_LOG_LEVEL':
    ensure => present,
    path   => '/opt/solr/bin/solr.in.sh',
    line   => "SOLR_LOG_LEVEL=${::solr6::log_level}",
    match  => '^SOLR_LOG_LEVEL\=',
    notify => Service['solr'],
  }

  if ! empty($::solr6::zookeepers) {
    $zoo_string = join($::solr6::zookeepers, ',')
    file_line { 'ZK_HOST':
      ensure => present,
      path   => '/opt/solr/bin/solr.in.sh',
      line   => "ZK_HOST=\"$zoo_string\"",
      match  => '^ZK_HOST\=',
      notify => Service['solr'],
    }
  } else {
    file_line { 'ZK_HOST':
      ensure            => absent,
      path              => '/opt/solr/bin/solr.in.sh',
      line              => "ZK_HOST=*",
      match             => '^ZK_HOST\=',
      notify            => Service['solr'],
      match_for_absence => true,
    }
  }

  file_line { 'SOLR_TIMEZONE':
    ensure => present,
    path   => '/opt/solr/bin/solr.in.sh',
    line   => "SOLR_TIMEZONE=${::solr6::timezone}",
    match  => '^SOLR_TIMEZONE\=',
    notify => Service['solr'],
  }

  file_line { 'SOLR_OPTS':
    ensure => present,
    path   => '/opt/solr/bin/solr.in.sh',
    line   => "SOLR_OPS=\"\$SOLR_OPS ${::solr6::extra_params}\"",
    match  => '^SOLR_OPS\=',
    notify => Service['solr'],
  }

}
