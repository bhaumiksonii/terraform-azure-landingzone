module "azure_foundation" {
  source = "../../"

  create_subscription     = false
  environment             = "nonprod"
  hub_address_space       = ["10.0.0.0/16"]
  location                = "australiaeast"
  log_retention_days      = 30
  subscription_id         = "<EXISTING_SUBSCRIPTION_ID>"
  tenant_id               = "<ENTRA_TENANT_ID>"
}
