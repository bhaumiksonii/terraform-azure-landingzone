# -------------------------------------------------------
# Root variables — alphabetical order
# -------------------------------------------------------

variable "billing_account_name" {
  description = "Azure EA billing account name used for subscription alias creation."
  type        = string
  default     = null

  validation {
    condition     = !var.create_subscription || var.billing_account_name != null
    error_message = "billing_account_name must be provided when create_subscription is true."
  }
}

variable "create_subscription" {
  description = "Whether to create a new Azure subscription alias. Set false when subscription already exists."
  type        = bool
  default     = false
}

variable "cost_centre" {
  description = "Cost centre code for resource tagging and billing allocation."
  type        = string
  default     = "ofbank-platform"
}

variable "enrollment_account_name" {
  description = "Azure EA enrollment account name used for subscription alias creation."
  type        = string
  default     = null

  validation {
    condition     = !var.create_subscription || var.enrollment_account_name != null
    error_message = "enrollment_account_name must be provided when create_subscription is true."
  }
}

variable "environment" {
  description = "Deployment environment identifier (prod, nonprod, dev, uat)."
  type        = string
  validation {
    condition     = contains(["prod", "nonprod", "dev", "uat", "staging"], var.environment)
    error_message = "environment must be one of: prod, nonprod, dev, uat, staging."
  }
}

variable "hub_address_space" {
  description = "CIDR address space for the Hub Virtual Network."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "location" {
  description = "Primary Azure region for resource deployment."
  type        = string
  default     = "australiaeast"
}

variable "log_retention_days" {
  description = "Retention period in days for Log Analytics Workspace."
  type        = number
  default     = 90
}

variable "management_group_id" {
  description = "Management Group ID to associate the subscription with."
  type        = string
  default     = null

  validation {
    condition     = !var.create_subscription || var.management_group_id != null
    error_message = "management_group_id must be provided when create_subscription is true."
  }
}

variable "subscription_id" {
  description = "Azure Subscription ID for the provider. Used when managing existing subscriptions."
  type        = string
  default     = null

  validation {
    condition     = var.subscription_id != null || var.create_subscription
    error_message = "subscription_id is required when create_subscription is false."
  }
}

variable "tenant_id" {
  description = "Azure / Entra ID Tenant ID."
  type        = string
}
