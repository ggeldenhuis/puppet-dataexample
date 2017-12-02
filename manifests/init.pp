class dataexample (
  String  $confdir,
  Integer $randomvalue,
) {
  class { 'dataexample::install': } ->
  class { 'dataexample::config': }
}
