# 🚀 Universal Terraform Deployment Guide (Simple)

This guide is standard and reusable for any environment (`dev`, `uat`, `prod`).

## 1) Create your environment file

1. Copy [environments/dev.tfvars.example](environments/dev.tfvars.example) to `environments/dev.tfvars`
2. Update values:
    - `subscription_id`
    - `tenant_id`
    - `environment`
    - `location`
    - `hub_address_space` (if needed)

> Keep `create_subscription = false` if subscription already exists.

## 2) Configure backend once

Update [backend.tf](backend.tf):
- `organization = "<your-hcp-org>"`
- `workspaces.name = "terraform-azure-landingzone"`

## 3) First run (bootstrap) from local machine

Use your Azure user login once to create initial identity objects.

1. `az login`
2. `az account set --subscription <your-subscription-id>`
3. Run:
    - `terraform init`
    - `terraform plan -var-file="environments/dev.tfvars"`
    - `terraform apply -var-file="environments/dev.tfvars"`

After apply, capture Terraform service principal client ID:

- `terraform output terraform_sp_client_id`

## 4) Bitbucket variables

In Bitbucket repository variables, add:

| Variable | Value |
|---|---|
| `AZURE_CLIENT_ID` | Output from `terraform output terraform_sp_client_id` |
| `AZURE_TENANT_ID` | Your tenant ID |
| `AZURE_SUBSCRIPTION_ID` | Your subscription ID |
| `TF_API_TOKEN` | HCP Terraform API token |
| `TF_VARS_FILE` | `environments/dev.tfvars` |

Mark all as **Secured**.

## 5) Deploy from Bitbucket

Push code to Bitbucket and run pipeline.

Pipeline uses:
- `terraform plan -var-file="$TF_VARS_FILE"`
- `terraform apply` on `main`

## 6) How to update later

Edit only your tfvars file, then push:

- Region: `location`
- CIDR: `hub_address_space`
- Log retention: `log_retention_days`
- Env label: `environment`

Then commit and push. Pipeline applies the change.

## Quick troubleshooting

| Issue | Check |
|---|---|
| Auth error | Bitbucket variables are correct |
| Wrong subscription | `subscription_id` in tfvars and `AZURE_SUBSCRIPTION_ID` match |
| Backend error | HCP org/workspace in [backend.tf](backend.tf) |
| Missing vars file | `TF_VARS_FILE` points to existing `.tfvars` file |
