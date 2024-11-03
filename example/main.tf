provider "azurerm" {
  features {
    
  }
}

module "aks" {
    source = "../"
    resource_group_location = "koreacentral"
    resource_group_name = "rg-tf-dev"
    virtual_network_name = "vnet-tf-dev-aks"
    virtual_network_cidr = ["10.0.0.0/12"]
    subnet_name = "subnet-tf-dev-aks"
    subnet_cidr = ["10.0.0.0/16"]

    aks_cluster_name = "tf-dev-aks-cluster-001" 

    aks_dns_prefix = "tfaks"

    system_node_pool_profile = {
      node_pool_name = "system"
      node_pool_sku = "Standard_DS2_v2"
      node_pool_count = 2
      cluster_autoscaler_enabled = true
    }
    user_node_pool_profile = {
      node_pool_name = "user"
      node_pool_sku = "Standard_DS2_v2"
      node_pool_count = 2
      cluster_autoscaler_enabled = true
    }

    aks_k8s_version = "1.30.4"
    acr_name = "tfdevacr001"
}