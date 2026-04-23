# Entra ID module
# Security groups, Terraform Service Principal, role assignments

terraform {
  required_providers {
    azuread = {
      source = "hashicorp/azuread"
    }
  }
}

# -------------------------------------------------------
# Security Groups
# -------------------------------------------------------
resource "azuread_group" "platform_admins" {
  description      = "Platform administrators — full access to Azure platform resources."
  display_name     = "grp-ofbank-${var.environment}-platform-admins"
  mail_enabled     = false
  security_enabled = true
}

resource "azuread_group" "developers" {
  description      = "Application developers — contributor access to workload subscriptions."
  display_name     = "grp-ofbank-${var.environment}-developers"
  mail_enabled     = false
  security_enabled = true
}

resource "azuread_group" "read_only" {
  description      = "Read-only access to Azure resources for auditors and reviewers."
  display_name     = "grp-ofbank-${var.environment}-read-only"
  mail_enabled     = false
  security_enabled = true
}

resource "azuread_group" "network_admins" {
  description      = "Network administrators — manage networking resources."
  display_name     = "grp-ofbank-${var.environment}-network-admins"
  mail_enabled     = false
  security_enabled = true
}

# -------------------------------------------------------
# Terraform Service Principal (used by CI/CD pipelines)
# -------------------------------------------------------
resource "azuread_application" "terraform" {
  display_name = "sp-ofbank-${var.environment}-terraform"
}

resource "azuread_service_principal" "terraform" {
  client_id = azuread_application.terraform.client_id
}

# Federated identity credential — Bitbucket Pipelines OIDC
resource "azuread_application_federated_identity_credential" "bitbucket" {
  application_id = azuread_application.terraform.id
  audiences      = ["api://AzureADTokenExchange"]
  description    = "Bitbucket Pipelines OIDC federated credential"
  display_name   = "bitbucket-oidc-${var.environment}"
  issuer         = "https://api.bitbucket.org/2.0/workspaces/${var.bitbucket_workspace}/pipelines-config/identity/oidc"
  subject        = "ofbank:${var.environment}:*"
}
