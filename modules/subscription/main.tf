# Subscription module
# Provisions an Azure Subscription via alias (EA / MCA billing)

resource "azapi_resource" "subscription_alias" {
  type      = "Microsoft.Subscription/aliases@2021-10-01"
  name      = var.subscription_alias
  parent_id = "/"

  body = {
    properties = {
      displayName        = var.subscription_alias
      billingScope       = "/providers/Microsoft.Billing/billingAccounts/${var.billing_account_name}/enrollmentAccounts/${var.enrollment_account_name}"
      workload           = var.environment == "prod" ? "Production" : "DevTest"
      additionalProperties = {
        managementGroupId = var.management_group_id
      }
    }
  }
}

# Register commonly required resource providers
resource "azurerm_resource_provider_registration" "required" {
  for_each = toset([
    "Microsoft.Compute",
    "Microsoft.ContainerService",
    "Microsoft.KeyVault",
    "Microsoft.ManagedIdentity",
    "Microsoft.Network",
    "Microsoft.OperationalInsights",
    "Microsoft.Security",
    "Microsoft.Storage",
  ])

  name = each.value
}
