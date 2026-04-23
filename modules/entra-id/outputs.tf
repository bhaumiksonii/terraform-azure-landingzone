output "platform_admin_group_id" {
  description = "Object ID of the Platform Admins Entra ID security group."
  value       = azuread_group.platform_admins.object_id
}

output "terraform_sp_client_id" {
  description = "Client ID of the Terraform Service Principal."
  value       = azuread_application.terraform.client_id
}

output "terraform_sp_object_id" {
  description = "Object ID of the Terraform Service Principal."
  value       = azuread_service_principal.terraform.object_id
}
