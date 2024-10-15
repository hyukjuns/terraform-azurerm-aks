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
  type = list(string)
  description = "VNET CIDR"
}
variable "subnet_name" {
  type        = string
  description = "AKS가 배포될 Subnet 이름"
}
variable "subnet_cidr" {
  type = list(string)
  description = "AKS Subnet CIDR (Azure CNI Node Subnet 전용)"
}

# AKS Value
variable "aks_cluster_name" {
  type        = string
  description = "AKS 클러스터 이름"
}

variable "aks_dns_prefix" {
  type = string
  description = "AKS DNS Prefix"
  default = ""
}

variable "system_nodepool_sku" {
  type = string
  description = "AKS System NodePool SKU"
  default = ""
}

variable "system_nodepool_auto_scaling_enabled" {
  type = bool
  description = "AKS Cluster Autoscaler 활성 여부"
  default = null
}

variable "aks_k8s_version" {
  type        = string
  description = "AKS 쿠버네티스 버전 지정"
}

# ACR
variable "acr_name" {
  type        = string
  description = "ACR 이름"
}


