variable "common_tags" {
  default = {
    Project =   "Roboshop"
    Terraform   =   "true"
    Environment =   "dev"
  }
}

variable "tags" {
    default = {
        component = "web"
    }
  
}

variable "project_name" {
  default = "roboshop"
}

variable "environment" {
  default = "dev"
}

variable "zone_name" {
  default = "aws76s.online"
}

# variable "zone_id" {
#   default = "Z0453211BMHVK8GNH9ST"
  
# }