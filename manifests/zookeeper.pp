define kafka_web::zookeeper(
  $hostname,
  $port = '2181',
  $group = 'ALL',
  $chroot = ''
) {
  
  $json_data = "{\"name\":\"${name}\", \"host\":\"${hostname}\", \"port\":\"${port}\", \"group\":\"${group}\", \"chroot\":\"${chroot}\"}"
  
  exec { "create zookeeper - ${hostname}":
    command => "/usr/bin/curl -X POST -H \"Content-Type: application/json\" -d '${json_data}' http://${::fqdn}:9000/api/zookeepers.json",
    unless  => "/bin/cat /opt/kafka_web_console/conf/zookeepers.conf | grep ${hostname} | awk '{print \$5}'",
    require => File['/opt/kafka_web_console/conf/zookeepers.conf']
  }
  
  exec { "ensure connected - ${hostname}":
    command => "/usr/bin/curl -X DELETE http://${::fqdn}:9000/api/zookeepers.json/${name} && /usr/bin/curl -X POST -H \"Content-Type: application/json\" -d '${json_data}' http://${::fqdn}:9000/api/zookeepers.json",
    unless  => "/bin/cat /opt/kafka_web_console/conf/zookeepers.conf | grep ${hostname} | awk '{print \$5}' | grep CONNECTED",
    require => File['/opt/kafka_web_console/conf/zookeepers.conf']
  }
  
}
