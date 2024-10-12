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
variable "subnet_name" {
  type        = string
  description = "AKS가 배포될 Subnet 이름"
}

# AKS Value
variable "aks_cluster_name" {
  type        = string
  description = "AKS 클러스터 이름"
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


