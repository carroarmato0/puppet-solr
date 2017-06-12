# Manages the installation of solr6
class solr6::install {

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
