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

mkdir /opt/nomad/server

cat <<EOF >/etc/nomad.d/nomad.hcl
data_dir = "/opt/nomad/server"
bind_addr = "{{ GetInterfaceIP \"eth1\" }}"
server {
    enabled = true
    bootstrap_expect = 1
}
EOF

#nomad agent -config /etc/nomad.d/server.hcl