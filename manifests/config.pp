class mysql_build::config {

  file { 'my.cnf':
    path    => $dir,
    content => templates('mysql_build/my.cnf'),
  }

}
