terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0.0"
    }
  }
}

provider "azurerm" {
  subscription_id                 = "e869d110-5a25-4a7f-8ca3-54248eb8996f"
  resource_provider_registrations = "none"
  features {}
}
