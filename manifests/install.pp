# Manages the installation of solr6
class solr6::install {

  # Check if required package is preset
  if !defined(Package['lsof']) {
    package { 'lsof':
      ensure => installed,
      notify => Service['solr'],
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
