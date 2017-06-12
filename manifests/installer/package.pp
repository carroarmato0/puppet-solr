# Handles the installation of Solr6 from a package
class solr6::installer::package {

  package { $::solr6::package:
    ensure => installed,
  }

}
