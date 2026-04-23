output "hub_vnet_id" {
  description = "Resource ID of the Hub Virtual Network."
  value       = azurerm_virtual_network.hub.id
}

output "key_vault_id" {
  description = "Resource ID of the central Key Vault."
  value       = azurerm_key_vault.main.id
}

output "key_vault_uri" {
  description = "URI of the central Key Vault."
  value       = azurerm_key_vault.main.vault_uri
}

output "log_analytics_workspace_id" {
  description = "Resource ID of the Log Analytics Workspace."
  value       = azurerm_log_analytics_workspace.main.id
}

output "log_analytics_workspace_key" {
  description = "Primary shared key for the Log Analytics Workspace."
  sensitive   = true
  value       = azurerm_log_analytics_workspace.main.primary_shared_key
}

output "networking_resource_group_name" {
  description = "Name of the networking resource group."
  value       = azurerm_resource_group.networking.name
}

output "security_resource_group_name" {
  description = "Name of the security resource group."
  value       = azurerm_resource_group.security.name
}

output "shared_services_subnet_id" {
  description = "Resource ID of the Shared Services subnet."
  value       = azurerm_subnet.shared_services.id
}
