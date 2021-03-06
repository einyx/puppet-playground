## GENERAL SETUPS
# To test puppi integration:
$monitor      = true
$monitor_tool = [ 'puppi' ]

# Basic package management
case $::osfamily {
  redhat: {
    include yum::repo::epel
    package { 'redhat-lsb': ensure => present }
  }
  debian: {
    include apt
    package { 'lsb-release': ensure => present }
  }
  suse: {
    package { 'lsb': ensure => present }
  }
}

  # Web Server Component
  class { 'apache':
  }
  apache::module { 'headers': }
  apache::module { 'rewrite': }

  class { "wordpress":
    install    => 'source',
  }

  class { 'php':
  }

  class { 'vsftpd':
  }


## DEBUG
# Uncomment below to have /tmp/puppet.debug with all the scope variables
/*  
  file { '/tmp/puppet.debug':
    ensure   => present,
    mode     => '0640',
    owner    => 'root',
    group    => 'root',
    loglevel => debug,  # this is needed to avoid it being logged and reported on every run
    content  => inline_template('<%= scope.to_yaml %>'),
  }
*/
