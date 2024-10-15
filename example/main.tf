provider "azurerm" {
  features {
    
  }
}

module "aks" {
    source = "../"
    resource_group_location = "koreacentral"
    resource_group_name = "rg-tf-aks"
    virtual_network_name = "vnet-tf-aks"
    virtual_network_cidr = ["10.0.0.0/12"]
    subnet_name = "subnet-tf-aks"
    subnet_cidr = ["10.0.0.0/16"]
    aks_cluster_name = "tf-aks-cluster-001" 
    aks_dns_prefix = "tfaks"
    system_nodepool_sku = null
    system_nodepool_auto_scaling_enabled = null
    aks_k8s_version = "1.30.4"
    acr_name = "tfaksacrtest"
}