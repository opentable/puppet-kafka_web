class kafka_web::install(
  $install_dir = $kafka_web::install_dir,
  $install_source = $kafka_web::install_source,
  $install_revision = $kafka_web::install_revision,
  $jdbc_file = $kafka_web::jdbc_file
) {

  ensure_resource('package', 'git', {'ensure' => 'installed'})

  vcsrepo { $install_dir:
    ensure   => present,
    provider => git,
    source   => $install_source,
    revision => $install_revision,
    require  => Package['git'],
    notify   => Service['kafka-web']
  }

  if "x${jdbc_file}x" != "xx" {
    file { "${install_dir}/lib/${jdbc_file}":
      ensure => link,
      target => "/usr/share/java/${jdbc_file}"
    }
  }
}
