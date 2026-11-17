terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}
 
variable "environment_name" {
  type    = string
  default = "staging"
}
 
resource "local_file" "server_config" {
  content  = "Environment: ${var.environment_name}\nStatus: Active\n"
  filename = "/tmp/deployed_${var.environment_name}.conf"
}
 
output "deployed_file_path" {
  value = local_file.server_config.filename
}