class dataexample::base {
  file { $dataexample::confdir:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
  }

  file { "${dataexample::confdir}/values.conf":
    ensure  => file,
    content => "${dataexample::randomvalue}\n",
  }
}
