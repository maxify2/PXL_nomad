data_dir = "/opt/nomad"
bind_addr = "{{ GetInterfaceIP \"eth1\" }}"
server {
    enabled = true
    bootstrap_expect = 1
}