variable "address_space" {
  description = "CIDR address space for the Hub Virtual Network."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "environment" {
  description = "Deployment environment (prod, nonprod, dev, etc.)."
  type        = string
}

variable "location" {
  description = "Azure region for resource deployment."
  type        = string
}

variable "log_retention_days" {
  description = "Log Analytics Workspace retention period in days."
  type        = number
  default     = 90
}

variable "name_prefix" {
  description = "Naming prefix for all resources."
  type        = string
}

variable "subscription_id" {
  description = "Azure Subscription ID where resources are deployed."
  type        = string
}

variable "tags" {
  description = "Map of tags to apply to all resources."
  type        = map(string)
  default     = {}
}
