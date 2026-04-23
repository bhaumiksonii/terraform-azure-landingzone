# Entra ID Module

Provisions Microsoft Entra ID (Azure Active Directory) security groups and the Terraform Service Principal with Bitbucket Pipelines OIDC federated identity.

## Resources Created

| Resource | Name Pattern |
|---|---|
| Security Group — Platform Admins | `grp-ofbank-{env}-platform-admins` |
| Security Group — Developers | `grp-ofbank-{env}-developers` |
| Security Group — Read Only | `grp-ofbank-{env}-read-only` |
| Security Group — Network Admins | `grp-ofbank-{env}-network-admins` |
| App Registration (Terraform SP) | `sp-ofbank-{env}-terraform` |
| Service Principal | Same as app registration |
| Federated Identity Credential | Bitbucket Pipelines OIDC |

## Inputs

| Name | Description | Type | Default |
|---|---|---|---|
| `bitbucket_workspace` | Bitbucket workspace slug | `string` | `"ofbank"` |
| `environment` | Environment name | `string` | required |
| `tenant_id` | Entra ID Tenant ID | `string` | required |

## Outputs

| Name | Description |
|---|---|
| `developers_group_id` | Developers group object ID |
| `network_admins_group_id` | Network admins group object ID |
| `platform_admin_group_id` | Platform admins group object ID |
| `read_only_group_id` | Read-only group object ID |
| `terraform_sp_client_id` | Terraform SP client ID |
| `terraform_sp_object_id` | Terraform SP object ID |
