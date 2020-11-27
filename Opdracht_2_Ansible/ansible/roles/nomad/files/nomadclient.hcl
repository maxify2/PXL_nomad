data_dir = "/opt/nomad"
bind_addr = "{{ GetInterfaceIP \"eth1\" }}"
client {
    enabled = true
    servers = ["10.0.0.10:4647"]
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