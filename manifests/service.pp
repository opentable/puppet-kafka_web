class kafka_web::service(
  $install_dir = $kafka_web::install_dir,
  $java_opts = $kafka_web::java_opts  
) {

  play::application { "kafka-web-console" :
    ensure  => running,
    path    => $install_dir,
    javaOptions => $java_opts,
    require => Vcsrepo[$install_dir]
  }

  file { '/etc/init.d/kafka-web':
    ensure  => present,
    content => template('kafka_web/init.d.erb'),
    mode    => '0755',
    require => File['/etc/default/kafka-web'],
    notify   => Service['kafka-web']
  }

  service { 'kafka-web':
    ensure => 'running',
    require => [
      File['/etc/init.d/kafka-web'],
      Play::Application['kafka-web-console']
    ]
  }

}
