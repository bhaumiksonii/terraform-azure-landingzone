variable "billing_account_name" {
  description = "Azure EA billing account name."
  type        = string
}

variable "enrollment_account_name" {
  description = "Azure EA enrollment account name."
  type        = string
}

variable "environment" {
  description = "Deployment environment (prod, nonprod, dev, etc.)."
  type        = string
}

variable "management_group_id" {
  description = "Management Group ID to place the subscription under."
  type        = string
}

variable "subscription_alias" {
  description = "Display name / alias for the new subscription."
  type        = string
}

variable "tags" {
  description = "Map of tags to apply to resources."
  type        = map(string)
  default     = {}
}
