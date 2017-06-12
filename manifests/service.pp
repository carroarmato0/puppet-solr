# Manages the service of Solr
class solr6::service {

  file { '/etc/systemd/system/solr.service':
    ensure  => file,
    mode    => '0644',
    content => template('solr6/solr.service.erb'),
    notify  => [
      Exec['Reload Solr Service file'],
      Service['solr'],
    ],
  }

  exec { 'Reload Solr Service file':
    path        => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    command     => 'systemctl daemon-reload',
    before      => Service['solr'],
    refreshonly => true,
  }

  service { 'solr':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
  }

}
