# variables.tf
variable "location" {
  type    = string
  default = "uksouth"
}

variable "prefix" {
  type    = string
  default = "alz-lite"
}

variable "mandatory_tags" {
  type    = list(string)
  default = ["Owner", "Environment"]
}

variable "default_tags" {
  type = map(string)
  default = {
    Owner       = "ramees"
    Environment = "dev"
    ManagedBy   = "Terraform"
    Project     = "Azure-Landing-Zone-Lite"
  }
}

variable "allowed_locations" {
  type    = list(string)
  default = ["uksouth", "ukwest"]
}
