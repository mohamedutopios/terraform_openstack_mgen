provider "openstack" {
  user_name           = "admin"
  password            = "xMvLAtOwFyGnwVoT3V96mRZsxaMyxNE8HVQ4G8CJ"
  auth_url            = "http://9.11.93.4:35357/v3"
  region              = "RegionOne"
  tenant_name         = "admin"
  domain_name         = "Default"
  user_domain_name    = "Default"
  project_domain_name = "Default"
}

provider "tls" {}
provider "local" {}