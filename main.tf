# -------------------------------------------------------
# Root module — OF Bank Azure Cloud Foundation
# Orchestrates: subscription, landing-zone, entra-id
# -------------------------------------------------------

locals {
  effective_subscription_id = var.create_subscription ? module.subscription[0].subscription_id : var.subscription_id
}

module "subscription" {
  count  = var.create_subscription ? 1 : 0
  source = "./modules/subscription"

  billing_account_name    = var.billing_account_name
  enrollment_account_name = var.enrollment_account_name
  environment             = var.environment
  management_group_id     = var.management_group_id
  subscription_alias      = "${local.name_prefix}-sub"
  tags                    = local.common_tags
}

module "entra_id" {
  source = "./modules/entra-id"

  environment = var.environment
  tenant_id   = var.tenant_id
}

module "landing_zone" {
  source = "./modules/landing-zone"

  address_space      = var.hub_address_space
  environment        = var.environment
  location           = var.location
  log_retention_days = var.log_retention_days
  name_prefix        = local.name_prefix
  subscription_id    = local.effective_subscription_id
  tags               = local.common_tags
}

resource "azurerm_role_assignment" "platform_admins_contributor" {
  scope                = "/subscriptions/${local.effective_subscription_id}"
  role_definition_name = "Contributor"
  principal_id         = module.entra_id.platform_admin_group_id
  principal_type       = "Group"

  depends_on = [module.entra_id]
}
