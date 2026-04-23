terraform {
  required_version = ">= 1.9.0"

  required_providers {
    # hashicorp/azurerm — latest stable as of 2026-04
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }

    # hashicorp/azuread — Microsoft Entra ID (Azure Active Directory)
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.0"
    }

    # hashicorp/azapi — ARM REST API resources not yet in azurerm
    azapi = {
      source  = "azure/azapi"
      version = "~> 2.0"
    }
  }
}
