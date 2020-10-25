#!/bin/bash
#todo consul als server zetten in config
sed -i '/#server = true/c\server = true' /etc/consul.d/consul.hcl

lastLine=`tail -1 /etc/consul.d/consul.hcl`
if [ $lastLine!='bind_addr = "192.168.1.10"' ]
then
cat <<EOF >>/etc/consul.d/consul.hcl
bind_addr = "192.168.1.10"
EOF
fi

sudo systemctl start consul

sudo mkdir /opt/nomad/server

cat <<EOF >/etc/nomad.d/nomad.hcl
data_dir = "/opt/nomad/server"
bind_addr = "{{ GetInterfaceIP \"eth1\" }}"
server {
    enabled = true
    bootstrap_expect = 1
}
EOF


sudo systemctl start nomad
sudo systemctl enable consul
sudo systemctl enable nomad

cat <<EOF >httpd.nomad
job "webserver" {
  datacenters = ["dc1"]
  type = "service"

  group "webserver" {
    task "webserver" {
      driver = "docker"

      config {
        image = "httpd"
        force_pull = true
        port_map = {
          webserver_web = 80
        }
        logging {
          type = "journald"
          config {
            tag = "WEBSERVER"
          }
        }
      }
      service {
        name = "webserver"
        port = "webserver_web"
      }

      resources {
        network {
          port "webserver_web" {
            static = 8000
          }
        }
      }
    }
  }
}
EOF
sleep 5s
sudo nomad job run -address=http://192.168.1.10:4646 httpd.nomad

