# Handles the installation of Solr6 from the web
class solr6::installer::web {

  archive { "/tmp/solr-${::solr6::version}.zip":
    ensure       => present,
    extract      => true,
    extract_path => '/opt/',
    source       => "${::solr6::params::download_url_base}/${::solr6::version}/solr-${::solr6::version}.zip",
    creates      => "/opt/solr-${::solr6::version}",
    cleanup      => true,
  }

}
