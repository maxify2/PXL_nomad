data_dir = "/opt/nomad"
bind_addr = "{{ GetInterfaceIP \"eth1\" }}"
server {
    enabled = true
    bootstrap_expect = 1
}

telemetry {
 collection_interval = "5s",
 publish_allocation_metrics = true,
 publish_node_metrics = true,
 prometheus_metrics = true
}