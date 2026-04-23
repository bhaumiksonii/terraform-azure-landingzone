terraform {
  backend "azurerm" {
    resource_group_name  = "ofbank-dev-rg-shared-services"
    storage_account_name = "ofbankdevstate"
    container_name       = "tfstate"
    key                  = "dev.tfstate"
  }
}

# Note: Storage account must be created first.
# After initial deploy, run: terraform init -reconfigure
