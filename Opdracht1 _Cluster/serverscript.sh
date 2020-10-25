#!/bin/bash

#consul configuration
sed -i '/#server = true/c\server = true' /etc/consul.d/consul.hcl

lastLine=`tail -1 /etc/consul.d/consul.hcl`
if [ lastLine!="bind_addr = \"192.168.1.10\"" ]
then
cat <<EOF >>/etc/consul.d/consul.hcl
bind_addr = "192.168.1.10"
EOF
fi

sudo systemctl start consul

sudo mkdir /opt/nomad/server

#nomad configuration
cat <<EOF >/etc/nomad.d/nomad.hcl
data_dir = "/opt/nomad/server"
bind_addr = "{{ GetInterfaceIP \"eth1\" }}"
server {
    enabled = true
    bootstrap_expect = 1
}
EOF

#start nomad and enable consul and nomad
sudo systemctl start nomad
sudo systemctl enable consul
sudo systemctl enable nomad



