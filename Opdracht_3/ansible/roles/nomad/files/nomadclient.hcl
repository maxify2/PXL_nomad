data_dir = "/opt/nomad"
bind_addr = "{{ GetInterfaceIP \"eth1\" }}"
client {
    enabled = true
    servers = ["10.0.0.10:4647"]
    network_interface = "eth1"
}

telemetry {
 collection_interval = "5s",
 publish_allocation_metrics = true,
 publish_node_metrics = true,
 prometheus_metrics = true
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