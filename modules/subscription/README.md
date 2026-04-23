# Subscription Module

Provisions an Azure Subscription via alias using the EA (Enterprise Agreement) billing scope.

## Resources Created

- `azapi_resource.subscription_alias` — Subscription via Microsoft.Subscription/aliases API
- `azurerm_resource_provider_registration` — Required Azure resource provider registrations

## Usage

```hcl
module "subscription" {
  source = "./modules/subscription"

  billing_account_name    = "12345678"
  enrollment_account_name = "98765432"
  environment             = "prod"
  management_group_id     = "/providers/Microsoft.Management/managementGroups/mg-ofbank-prod"
  subscription_alias      = "ofbank-prod-sub"
  tags                    = { environment = "prod" }
}
```

## Inputs

| Name | Description | Type | Required |
|---|---|---|---|
| `billing_account_name` | EA billing account name | `string` | yes |
| `enrollment_account_name` | EA enrollment account name | `string` | yes |
| `environment` | Environment identifier | `string` | yes |
| `management_group_id` | Management Group to place subscription under | `string` | yes |
| `subscription_alias` | Subscription display name / alias | `string` | yes |
| `tags` | Resource tags | `map(string)` | no |

## Outputs

| Name | Description |
|---|---|
| `subscription_id` | The provisioned Azure Subscription ID |
