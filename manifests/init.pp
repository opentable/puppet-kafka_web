class kafka_web(
  $ensure = $kafka_web::params::ensure,
  $install_dir = $kafka_web::params::install_dir,
  $install_source = $kafka_web::params::install_source,
  $install_revision = $kafka_web::params::install_revision,
  $db_default_driver = $kafka_web::params::db_default_driver,
  $db_default_url = $kafka_web::params::db_default_url,
  $db_default_user = $kafka_web::params::db_default_user,
  $db_default_password = $kafka_web::params::db_default_password,
  $jdbc_file = $kafka_web::params::jdbc_file,
  $java_opts = $kafka_web::params::java_opts,
  $play_home = $kafka_web::params::play_home
) inherits kafka_web::params {

  class { 'kafka_web::install': } ->
  class { 'kafka_web::config': } ~>
  class { 'kafka_web::service': } ->
  Class['kafka_web']
}
