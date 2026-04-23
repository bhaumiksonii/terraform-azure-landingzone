# Landing Zone module
# Hub networking, Key Vault, Log Analytics, Azure Policy, RBAC

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

# -------------------------------------------------------
# Resource Groups
# -------------------------------------------------------
resource "azurerm_resource_group" "networking" {
  location = var.location
  name     = "${var.name_prefix}-rg-networking"
  tags     = var.tags
}

resource "azurerm_resource_group" "security" {
  location = var.location
  name     = "${var.name_prefix}-rg-security"
  tags     = var.tags
}

resource "azurerm_resource_group" "shared_services" {
  location = var.location
  name     = "${var.name_prefix}-rg-shared-services"
  tags     = var.tags
}

# -------------------------------------------------------
# Log Analytics Workspace (centralised logging)
# -------------------------------------------------------
resource "azurerm_log_analytics_workspace" "main" {
  location            = var.location
  name                = "${var.name_prefix}-law"
  resource_group_name = azurerm_resource_group.shared_services.name
  retention_in_days   = var.log_retention_days
  sku                 = "PerGB2018"
  tags                = var.tags
}

# -------------------------------------------------------
# Hub Virtual Network
# -------------------------------------------------------
resource "azurerm_virtual_network" "hub" {
  address_space       = var.address_space
  location            = var.location
  name                = "${var.name_prefix}-vnet-hub"
  resource_group_name = azurerm_resource_group.networking.name
  tags                = var.tags
}

# Subnets
resource "azurerm_subnet" "firewall" {
  address_prefixes     = [cidrsubnet(var.address_space[0], 8, 0)]
  name                 = "AzureFirewallSubnet" # Fixed name required by Azure
  resource_group_name  = azurerm_resource_group.networking.name
  virtual_network_name = azurerm_virtual_network.hub.name
}

resource "azurerm_subnet" "bastion" {
  address_prefixes     = [cidrsubnet(var.address_space[0], 8, 1)]
  name                 = "AzureBastionSubnet" # Fixed name required by Azure
  resource_group_name  = azurerm_resource_group.networking.name
  virtual_network_name = azurerm_virtual_network.hub.name
}

resource "azurerm_subnet" "gateway" {
  address_prefixes     = [cidrsubnet(var.address_space[0], 8, 2)]
  name                 = "GatewaySubnet" # Fixed name required by Azure VPN/ER gateways
  resource_group_name  = azurerm_resource_group.networking.name
  virtual_network_name = azurerm_virtual_network.hub.name
}

resource "azurerm_subnet" "shared_services" {
  address_prefixes     = [cidrsubnet(var.address_space[0], 8, 10)]
  name                 = "snet-shared-services"
  resource_group_name  = azurerm_resource_group.networking.name
  virtual_network_name = azurerm_virtual_network.hub.name
}

# -------------------------------------------------------
# Network Security Group — Shared Services subnet
# -------------------------------------------------------
resource "azurerm_network_security_group" "shared_services" {
  location            = var.location
  name                = "${var.name_prefix}-nsg-shared-services"
  resource_group_name = azurerm_resource_group.networking.name
  tags                = var.tags

  security_rule {
    access                     = "Deny"
    direction                  = "Inbound"
    name                       = "DenyAllInbound"
    priority                   = 4096
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "shared_services" {
  network_security_group_id = azurerm_network_security_group.shared_services.id
  subnet_id                 = azurerm_subnet.shared_services.id
}

# -------------------------------------------------------
# Azure Bastion (secure jumpbox access)
# -------------------------------------------------------
resource "azurerm_public_ip" "bastion" {
  allocation_method   = "Static"
  location            = var.location
  name                = "${var.name_prefix}-pip-bastion"
  resource_group_name = azurerm_resource_group.networking.name
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_bastion_host" "main" {
  location            = var.location
  name                = "${var.name_prefix}-bastion"
  resource_group_name = azurerm_resource_group.networking.name
  tags                = var.tags

  ip_configuration {
    name                 = "ipconfig"
    public_ip_address_id = azurerm_public_ip.bastion.id
    subnet_id            = azurerm_subnet.bastion.id
  }
}

# -------------------------------------------------------
# Azure Key Vault (central secrets store)
# -------------------------------------------------------
data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "main" {
  location                   = var.location
  name                       = "${var.name_prefix}-kv"
  purge_protection_enabled   = true
  resource_group_name        = azurerm_resource_group.security.name
  sku_name                   = "standard"
  soft_delete_retention_days = 90
  tags                       = var.tags
  tenant_id                  = data.azurerm_client_config.current.tenant_id

  network_acls {
    bypass         = "AzureServices"
    default_action = "Deny"
  }
}

# -------------------------------------------------------
# Microsoft Defender for Cloud
# -------------------------------------------------------
resource "azurerm_security_center_subscription_pricing" "defender_plans" {
  for_each = toset([
    "AppServices",
    "ContainerRegistry",
    "Containers",
    "KeyVaults",
    "KubernetesService",
    "SqlServers",
    "StorageAccounts",
    "VirtualMachines",
  ])

  tier          = "Standard"
  resource_type = each.value
}
