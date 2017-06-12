# Class: solr6
# ===========================
#
# Module that manages Solr 6.x.x.
#
# Parameters
# ----------
#
# * `version`
#   Specific version of Solr required.
#   Example: 6.6.0
#
# * `memory`
#   Sets the min (-Xms) and max (-Xmx) heap size for the JVM.
#   Example: 4g
#   Default is 512m
#
# * `installation_type`
#   Module supports both fetching Solr from the internet as well as from a package.
#   Supported options are: `web` and `package`
#   Default is: web
#
class solr6 (
  $version           = $::solr6::params::version,
  $memory            = $::solr6::params::memory,
  $installation_type = $::solr6::params::installation_type,
  $manage_java       = $::solr6::params::manage_java,
  $manage_entropy    = $::solr6::params::manage_entropy,
) inherits solr6::params {

  include solr6::install
  include solr6::config
  include solr6::service

  Class['Solr6::Install']->Class['Solr6::Config']->Class['Solr6::Service']

}
