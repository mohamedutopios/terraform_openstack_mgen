output "vm1_floating_ip" {
  description = "IP publique de VM1"
  value       = openstack_networking_floatingip_v2.fip_vm1.address
}

output "vm1_private_ip" {
  description = "IP privée de VM1"
  value       = openstack_compute_instance_v2.vm1.access_ip_v4
}

output "vm2_private_ip" {
  description = "IP privée de VM2"
  value       = openstack_compute_instance_v2.vm2.access_ip_v4
}

output "ssh_command" {
  description = "Commande SSH pour VM1"
  value       = "ssh -i ${var.ssh_key_name}.pem ubuntu@${openstack_networking_floatingip_v2.fip_vm1.address}"
}

output "ping_command" {
  description = "Test ping VM1 vers VM2"
  value       = "ssh -i ${var.ssh_key_name}.pem ubuntu@${openstack_networking_floatingip_v2.fip_vm1.address} 'ping -c 4 ${openstack_compute_instance_v2.vm2.access_ip_v4}'"
}

output "web_url" {
  description = "URL du serveur web"
  value       = "http://${openstack_networking_floatingip_v2.fip_vm1.address}"
}