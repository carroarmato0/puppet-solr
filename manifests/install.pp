# Manages the installation of solr6
class solr6::install {

  # Create the User and Group
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

  # Check if required package is preset
  if !defined(Package['lsof']) {
    package { 'lsof':
      ensure => installed,
      notify => Service['solr'],
    }
  }

  if $::solr6::manage_java {
    include ::java
  }

  if $::solr6::manage_entropy {
    package { 'haveged':
      ensure => installed,
    }

    service { 'haveged':
      ensure  => running,
      enable  => true,
      before  => Service['solr'],
      require => Package['haveged'],
    }
  }

  case $::solr6::installation_type {
    'web': {
      include ::solr6::installer::web
    }
    'package': {
      include ::solr6::installer::package
    }
    default: {
      fail('Unsupported installation type for Solr')
    }
  }

}
