locals {
  # Common tags applied to all resources
  common_tags = {
    environment = var.environment
    project     = "ofbank-azure-foundation"
    managed_by  = "terraform"
    repository  = "terraform-azure-landingzone"
    cost_centre = var.cost_centre
  }

  # Naming prefix for all resources
  name_prefix = "ofbank-${var.environment}"
}
