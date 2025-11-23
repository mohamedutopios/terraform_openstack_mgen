terraform {
  required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.53.0"
    }
  }
   backend "swift" {
    container = "terraform-state"
  }
}

provider "openstack" {
  # Les crédentials sont sourcés via le fichier openrc
}

# -------------------------------------------------------
# APPEL 1 : Environnement de DEV
# -------------------------------------------------------
module "webapp_dev" {
  source = "./modules/http_server"

  env_name     = "dev"
  
  # ICI : On utilise les variables globales définies dans variables.tf
  image_name   = var.std_image    
  network_name = var.global_network
  
  # Pour le flavor, on garde du spécifique ici pour montrer la différence
  flavor_name  = "m1.tiny"     
}

# -------------------------------------------------------
# APPEL 2 : Environnement de PROD
# -------------------------------------------------------
module "webapp_prod" {
  source = "./modules/http_server"

  env_name     = "prod"
  
  # On réutilise les mêmes variables globales = Cohérence !
  image_name   = var.std_image
  network_name = var.global_network
  
  # Flavor plus grand pour la prod
  flavor_name  = "m1.small"    
}