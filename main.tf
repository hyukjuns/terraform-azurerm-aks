# Base Infra Resources
resource "azurerm_resource_group" "aks" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_virtual_network" "aks" {
  name                = var.virtual_network_name
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  address_space       = var.virtual_network_cidr
}

resource "azurerm_subnet" "aks" {
  name                 = var.subnet_name
  virtual_network_name = azurerm_virtual_network.aks.name
  resource_group_name  = azurerm_resource_group.aks.name
  address_prefixes     = var.subnet_cidr
}

# AKS
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_cluster_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  # k8s version
  kubernetes_version = var.aks_k8s_version

  # Basic
  dns_prefix = var.aks_dns_prefix == null ? "terraform" : var.aks_dns_prefix


  default_node_pool {
    name                 = "system"
    type                 = "VirtualMachineScaleSets"
    zones                = [1, 2, 3]
    vm_size              = var.system_nodepool_sku == null ? "Standard_DS2_v2" : var.system_nodepool_sku
    vnet_subnet_id       = azurerm_subnet.aks.id
    auto_scaling_enabled = var.system_nodepool_auto_scaling_enabled == null ? true : false
    node_count           = var.system_nodepool_auto_scaling_enabled != false ? 2 : null
    max_count            = var.system_nodepool_auto_scaling_enabled != false ? 3 : null
    min_count            = var.system_nodepool_auto_scaling_enabled != false ? 1 : null
    max_pods             = 110
  }

  # AutoScale 된 Node Count는 LifeCycle로 관리
  lifecycle {
    ignore_changes = [default_node_pool[0].node_count]
  }

  # Network
  network_profile {
    network_plugin    = "azure"
    network_mode      = "transparent"
    network_policy    = "calico"
    service_cidr      = "172.16.0.0/16"
    dns_service_ip    = "172.16.0.100"
    outbound_type     = "loadBalancer"
    load_balancer_sku = "standard"
  }

  # Identity
  identity {
    type = "SystemAssigned"
  }

  # # AKS Azure Policy
  # azure_policy_enabled = true
}

# ACR
resource "azurerm_container_registry" "aks" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  sku                 = "Standard"
  admin_enabled       = true
}
# Assign Role AKS Identity to ACR
resource "azurerm_role_assignment" "aks_acr" {
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.aks.id
  skip_service_principal_aad_check = true
}
# Assign Role AKS Identity to VNET
resource "azurerm_role_assignment" "aks_resource_group" {
  principal_id                     = azurerm_kubernetes_cluster.aks.identity[0].principal_id
  role_definition_name             = "Network Contributor"
  scope                            = azurerm_virtual_network.aks.id
  skip_service_principal_aad_check = true
}