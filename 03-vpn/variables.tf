
variable "common_tags" {
  default = {
    Project =   "Roboshop"
    Terraform   =   "true"
    Environment =   "dev"
  }
}

variable "project_name" {
  default = "roboshop"
}

variable "environment" {
  default = "dev"
}

variable "zone_id" {
    default = "Z0453211BMHVK8GNH9ST"
}

variable "domain_name" {
    default = "aws76s.online"
}