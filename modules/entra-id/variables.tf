variable "bitbucket_workspace" {
  description = "Bitbucket workspace slug used for OIDC federated identity issuer URL."
  type        = string
  default     = "ofbank"
}

variable "environment" {
  description = "Deployment environment (prod, nonprod, dev, etc.)."
  type        = string
}

variable "tenant_id" {
  description = "Azure / Entra ID Tenant ID."
  type        = string
}
