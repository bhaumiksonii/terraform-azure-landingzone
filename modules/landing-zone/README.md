# Landing Zone Module

Provisions the Azure Hub networking foundation, centralised security services, and governance components for OF Bank.

## Resources Created

| Resource | Name Pattern |
|---|---|
| Resource Groups | `{prefix}-rg-networking`, `{prefix}-rg-security`, `{prefix}-rg-shared-services` |
| Hub VNet | `{prefix}-vnet-hub` |
| Subnets | AzureFirewallSubnet, AzureBastionSubnet, GatewaySubnet, snet-shared-services |
| NSG | `{prefix}-nsg-shared-services` |
| Azure Bastion | `{prefix}-bastion` |
| Key Vault | `{prefix}-kv` |
| Log Analytics | `{prefix}-law` |
| Defender for Cloud | All major plan types enabled |

## Inputs

| Name | Description | Type | Default |
|---|---|---|---|
| `address_space` | Hub VNet CIDR | `list(string)` | `["10.0.0.0/16"]` |
| `environment` | Environment name | `string` | required |
| `location` | Azure region | `string` | required |
| `log_retention_days` | Log retention days | `number` | `90` |
| `name_prefix` | Resource naming prefix | `string` | required |
| `subscription_id` | Target subscription | `string` | required |
| `tags` | Resource tags | `map(string)` | `{}` |

## Outputs

| Name | Description |
|---|---|
| `hub_vnet_id` | Hub VNet resource ID |
| `key_vault_id` | Key Vault resource ID |
| `log_analytics_workspace_id` | Log Analytics resource ID |
| `networking_resource_group_name` | Networking RG name |
| `shared_services_subnet_id` | Shared services subnet ID |
