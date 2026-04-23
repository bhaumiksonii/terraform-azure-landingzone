terraform {
  cloud {
    organization = "<HCP_TERRAFORM_ORG>" # Replace with your HCP Terraform organisation name

    workspaces {
      name = "terraform-azure-landingzone" # Replace with actual repo / workspace name
    }
  }
}
