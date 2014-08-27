class kafka_web::config(
  $install_dir = $kafka_web::install_dir,
  $play_home = $kafka_web::play_home,
  $java_opts = $kafka_web::java_opts,
  $db_default_driver = $kafka_web::db_default_driver,
  $db_default_url = $kafka_web::db_default_url,
  $db_default_user = $kafka_web::db_default_user,
  $db_default_user = $kafka_web::db_default_password,
  $zookeepers = $kafka_web::zookeepers
) {

  file { "${install_dir}/conf/application.conf":
    ensure  => present,
    content => template('kafka_web/application.conf.erb'),
    require => Vcsrepo[$install_dir],
    notify   => Service['kafka-web']
  }

  file { '/etc/default/kafka-web':
    ensure  => present,
    content => template('kafka_web/default.erb'),
    notify  => Service['kafka-web']
  }
  
  file { "${install_dir}/conf/zookeepers.conf":
    ensure  => present,
    content => template('kafka_web/zookeepers.erb'),
    require => Service['kafka-web']
  }
  
  create_resources('kafka_web::zookeeper', $zookeepers)
}
