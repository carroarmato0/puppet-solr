# Manages defaults paramters for the module
class solr6::params {
  $version           = '6.6.0'
  $user              = 'solr'
  $group             = 'solr'
  $base_dir          = '/opt/solr'
  $installation_type = 'web'
  $download_url_base = 'http://apache.cu.be/lucene/solr/'
}
