class kafka_web::params {
  $ensure = 'latest'
  $install_dir = '/opt/kafka_web_console'
  $install_source = 'https://github.com/claudemamo/kafka-web-console'
  $install_revision = 'v2.0.0'

  $db_default_driver = 'org.h2.Driver'
  $db_default_url = 'jdbc:h2:file:play'
  $db_default_user = ''
  $db_default_password = ''
  $jdbc_file = ''

  $java_opts = '-DapplyEvolutions.default=true'

  $play_home = '/usr/share/activator'
}
