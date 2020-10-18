#!/bin/bash
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install consul
sudo yum -y install nomad
sudo systemctl start consul
sudo systemctl start nomad
sudo systemctl enable consul
sudo systemctl enable nomad

sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum -y install docker-ce docker-ce-cli containerd.io
sudo systemctl start docker
sudo systemctl enable docker

mkdir /opt/nomad/client1

cat <<EOF >/etc/nomad.d/nomad.hcl
data_dir = "/opt/nomad/client1"
bind_addr = "127.0.0.11"
client {
    enabled = true
    servers = ["192.168.1.10:4647"]
}
ports {
    http = "5656"
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
#nomad agent -config /etc/nomad.d/client1.hcl