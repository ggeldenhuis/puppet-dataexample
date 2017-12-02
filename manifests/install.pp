class dataexample::install {
  file { $dataexample::confdir:
    ensure => directory,
  }
}
