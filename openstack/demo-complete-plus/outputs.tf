output "vm_names" {
  value = [for vm in openstack_compute_instance_v2.vm : vm.name]
}

output "vm_ips" {
  value = [for vm in openstack_compute_instance_v2.vm : vm.access_ip_v4]
}
