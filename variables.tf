# Base Infra Value
variable "resource_group_name" {
  type        = string
  description = "AKS가 배포뵐 리소스 그룹 이름"
}
variable "resource_group_location" {
  type        = string
  description = "AKS가 배포될 리소스 그룹의 Azure 지역"
}
variable "virtual_network_name" {
  type        = string
  description = "AKS가 배포될 VNET 이름"
}
variable "virtual_network_cidr" {
  type        = list(string)
  description = "VNET CIDR"
}
variable "subnet_name" {
  type        = string
  description = "AKS가 배포될 Subnet 이름"
}
variable "subnet_cidr" {
  type        = list(string)
  description = "AKS Subnet CIDR (Azure CNI Node Subnet 전용)"
}

# AKS Value
variable "aks_cluster_name" {
  type        = string
  description = "AKS 클러스터 이름"
}

variable "aks_dns_prefix" {
  type        = string
  description = "AKS DNS Prefix"
  default     = ""
}

variable "system_node_pool_profile" {
  type = object({
    node_pool_name     = string
    node_pool_sku      = string
    node_pool_count    = number
    cluster_autoscaler_enabled = bool
  })
  description = "시스템 노드풀 설정"
  default = {
    node_pool_name             = "system"
    node_pool_sku              = "Standard_DS2_v2"
    node_pool_count            = 2
    cluster_autoscaler_enabled = false
  }
}

variable "aks_k8s_version" {
  type        = string
  description = "AKS 쿠버네티스 버전 지정"
}
variable "network_profile" {
  type = object({
    network_plugin = string
    network_policy = string
    service_cidr   = string
    dns_service_ip = string
  })
  description = "AKS 네트워크 설정"
  default = {
    network_plugin = "azure"
    network_policy = "calico"
    service_cidr   = "172.16.0.0/16"
    dns_service_ip = "172.16.0.100"
  }
}

# user nodepool
variable "user_node_pool_profile" {
  type = object({
    node_pool_name     = string
    node_pool_sku      = string
    node_pool_count    = number
    cluster_autoscaler_enabled = bool
  })
  description = "시스템 노드풀 설정"
  default = {
    node_pool_name             = "user"
    node_pool_sku              = "Standard_DS2_v2"
    node_pool_count            = 2
    cluster_autoscaler_enabled = false
  }
}

# ACR
variable "acr_name" {
  type        = string
  description = "ACR 이름"
}


