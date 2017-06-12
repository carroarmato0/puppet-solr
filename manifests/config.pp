# Manages basic configuration
class solr6::config {

  user {'solr':
    ensure  => present,
    comment => 'Solr user',
    groups  => 'solr',
    system  => true,
    require => Group['solr'],
  }

  group { 'solr':
    ensure => present,
    system => true,
  }

  file { '/opt/solr':
    ensure => link,
    target => "/opt/solr-${::solr6::version}",
  }

  # Manage ownership and permission of default folders
  $default_folders = [
    "/opt/solr-${::solr6::version}",
    '/opt/solr/bin',
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

}
