#!/bin/bash
#todo retryjoin in consul.hcl
#start consul
sudo systemctl start consul

sudo mkdir /opt/nomad/client2

cat <<EOF >/etc/nomad.d/nomad.hcl
data_dir = "/opt/nomad/client2"
bind_addr = "{{ GetInterfaceIP \"eth1\" }}"
client {
    enabled = true
    servers = ["192.168.1.10:4646"]
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
