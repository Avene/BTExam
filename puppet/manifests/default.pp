# initialize path environment variables
Exec {
  path => ['/usr/sbin', '/usr/bin', '/sbin', '/bin']
}

# pre-install stage
stage { 'preinstall':
  before => Stage['main']
}

include rbenv
rbenv::plugin { [ 'sstephenson/rbenv-vars', 'sstephenson/ruby-build' ]: }
rbenv::build { '2.2.0': global => true }

resources {"firewall":
  purge => true
}

Firewall {
  require => Class['fw::pre'],
  before => Class['fw::post'],
}

class { ['fw::pre', 'fw::post']: }

class { 'firewall': }

class fw::pre {
  Firewall {
    require => undef,
  }

  # Default firewall rules
  firewall { '000 accept all icmp':
    proto   => 'icmp',
    action  => 'accept',
  }->
  firewall { '001 accept all to lo interface':
    proto   => 'all',
    iniface => 'lo',
    action  => 'accept',
  }->
  firewall { '002 accept related established rules':
    proto   => 'all',
    state => ['RELATED', 'ESTABLISHED'],
    action  => 'accept',
  }
  firewall { '003 accept ssh':
    port => [22],
    proto => tcp,
    action => accept,
  }
  firewall { '004 accept rails':
    port => [3000],
    proto => tcp,
    action => accept,
  }
}

class fw::post {
  firewall { '999 drop all':
    proto   => 'all',
    action  => 'drop',
    before  => undef,
  }
}
