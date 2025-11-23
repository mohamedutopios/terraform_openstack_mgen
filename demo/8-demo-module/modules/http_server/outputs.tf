output "instance_ip" {
  description = "L'adresse IP du serveur web créé"
  value       = openstack_compute_instance_v2.web_instance.access_ip_v4
}