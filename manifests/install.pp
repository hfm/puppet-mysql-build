class mysql_build::install(
  $dir = '/usr/local/mysql-build'$
) {

  if !defined(Package['git']) {
    package { 'git':
      ensure => installed,
    }
  }

  exec { 'clone-mysql-build':
    path    => '/usr/bin',
    command => 'git clone https://github.com/kamipo/mysql-build.git ${dir}',
    creates => '${dir}/.git',
    require => Package['git'],
  }

  user { 'mysql':
    ensure     => present,
    uid        => 27
    gid        => 'mysql',
    comment    => 'mysql',
    managehome => true,
    home       => '/var/lib/mysql',
    shell      => '/bin/bash',
  }

  group { 'mysql':
    ensure => present,
    gid    => 27,
  }

  file { [
    '/var/lib/mysql',
    '/var/run/mysqld',
  ]:
    ensure => directory,
    owner  => 'mysql',
    group  => 'mysql',
  }

}
