variable "app_version" {

  type        = string
  default     = "2.1"
  description = "Version de l'application"
}

variable "db_trigger_var" {
  type        = string
  default     = "nouvelle valeur"
  description = "Variable utilisée pour le declenchement de la ressource DB"

}
resource "null_resource" "network" {
  triggers = {
    network = "net-001"
  }

}


resource "null_resource" "server" {
  triggers = {
    network_linked = null_resource.network.triggers["network"]
  }

}

resource "null_resource" "web_app" {
  depends_on = [null_resource.server]
  triggers = {
    version = var.app_version
  }

}


resource "null_resource" "db_trigger_resource" {
  triggers = {
    db_tigger = var.db_trigger_var
  }
}

# demo
resource "null_resource" "database" {
  triggers = {
    db_engine = "postgres"
    db_size   = "200GB"
  }

  lifecycle {
    prevent_destroy = false
    ignore_changes = [triggers["db_size"] ]
    create_before_destroy = true
    replace_triggered_by = [ null_resource.db_trigger_resource ]
  }


}
