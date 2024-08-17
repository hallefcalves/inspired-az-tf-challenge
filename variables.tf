variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region to deploy resources"
  type        = string
  default     = "eastus2"
}

variable "vnet_cidr" {
  description = "The CIDR block for the VNet"
  type        = string
  default     = "11.0.0.0/16"
}

variable "subnet_cidrs" {
  description = "A list of CIDR blocks for the subnets"
  type        = list(string)
  default     = ["11.0.1.0/24", "11.0.2.0/24"]
}

variable "vm_size" {
  description = "The size of the Virtual Machines in the Scale Set"
  type        = string
  default     = "Standard_DS2_v2"
}
