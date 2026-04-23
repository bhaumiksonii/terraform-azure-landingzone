# -------------------------------------------------------
# Root outputs — alphabetical order
# -------------------------------------------------------

output "hub_vnet_id" {
  description = "Resource ID of the Hub Virtual Network."
  value       = module.landing_zone.hub_vnet_id
}

output "key_vault_id" {
  description = "Resource ID of the central Key Vault."
  value       = module.landing_zone.key_vault_id
}

output "log_analytics_workspace_id" {
  description = "Resource ID of the Log Analytics Workspace."
  value       = module.landing_zone.log_analytics_workspace_id
}

output "platform_admin_group_id" {
  description = "Object ID of the Platform Admins Entra ID security group."
  value       = module.entra_id.platform_admin_group_id
}

output "subscription_id" {
  description = "Azure Subscription ID in use (existing or provisioned)."
  value       = local.effective_subscription_id
}

output "terraform_sp_client_id" {
  description = "Client ID of the Terraform Service Principal."
  value       = module.entra_id.terraform_sp_client_id
}
