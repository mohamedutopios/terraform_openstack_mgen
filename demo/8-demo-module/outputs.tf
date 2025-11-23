output "ip_development" {
  value = module.webapp_dev.instance_ip
}

output "ip_production" {
  value = module.webapp_prod.instance_ip
}