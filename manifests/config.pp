class dataexample::config {
  file { "${dataexample::confdir}/values.conf":
    ensure  => file,
    content => "${dataexample::randomvalue}\n",
  }
}
