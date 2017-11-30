class dataexample::base {
  file { $dataexample::confdir:
    ensure => directory,
  }

  file { "${dataexample::confdir}/values.conf":
    ensure  => file,
    content => "${dataexample::randomvalue}\n",
  }
}
