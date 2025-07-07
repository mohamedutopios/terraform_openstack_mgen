output "vm_ips" {
  value = [for vm in google_compute_instance.web_vms : vm.network_interface[0].access_config[0].nat_ip]
}
