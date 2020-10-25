#!/bin/bash
#todo retryjoin in consul.hcl
lastLine=`tail -1 /etc/consul.d/consul.hcl`
if [ $lastLine!='bind_addr = "192.168.1.12"' ]
then
cat <<EOF >>/etc/consul.d/consul.hcl
retry_join = ["192.168.1.10"]
bind_addr = "192.168.1.12"
EOF
fi

#start consul
sudo systemctl start consul

sudo mkdir /opt/nomad/client2

cat <<EOF >/etc/nomad.d/nomad.hcl
data_dir = "/opt/nomad/client2"
bind_addr = "{{ GetInterfaceIP \"eth1\" }}"
client {
    enabled = true
    servers = ["192.168.1.10:4647"]
}
ports {
    http = "5657"
}

plugin "docker" {
  config {
    gc {
      dangling_containers {
        enabled = false
      }
    }
  }
}
EOF

#start nomad and enable consul and nomad
sudo systemctl start nomad
sudo systemctl enable consul
sudo systemctl enable nomad
