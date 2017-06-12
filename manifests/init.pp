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
# * `data_dir`
#   Specify the Solr server directory.
#   Default is: server
#
# * `extra_params`
#   Passes extra paramters to the Solr instance through the -a option.
#   Example: -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=18983
#   By default nothing is passed
#
# * `zookeepers`
#   Passes an array of zookeeper addresses.
#   Example:  ['localhost:2181','localhost:2182','localhost:2183']
#
# * `example`
#   Loads an example configuration
#   Possible examples are: cloud, techproducts, dih and schemaless.
#   By default nothing is passed.
#
# * `installation_type`
#   Module supports both fetching Solr from the internet as well as from a package.
#   Supported options are: `web` and `package`
#   Default is: web
#
class solr6 (
  $version           = $::solr6::params::version,
  $memory            = $::solr6::params::memory,
  $data_dir          = $::solr6::params::data_dir,
  $extra_params      = $::solr6::params::extra_params,
  $zookeepers        = [],
  $example           = $::solr6::params::example,
  $installation_type = $::solr6::params::installation_type,
  $manage_java       = $::solr6::params::manage_java,
  $manage_entropy    = $::solr6::params::manage_entropy,
) inherits solr6::params {

  include solr6::install
  include solr6::config
  include solr6::service

  Class['Solr6::Install']->Class['Solr6::Config']->Class['Solr6::Service']

}
