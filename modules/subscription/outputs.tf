output "subscription_id" {
  description = "The provisioned Azure Subscription ID."
  value       = azapi_resource.subscription_alias.output.properties.subscriptionId
}
