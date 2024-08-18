variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vm_size" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "ssh_key" {
  type = string
}

variable "network_security_group_id" {
  description = "ID of NSG to be used"
  type = string
}

variable "load_balancer_backend_address_pool_ids" {
  description = "Load Balancer backend pool ID"
  type = list(string)
}

variable "load_balancer_health_probe_id" {
  description = "Load balancer health probe ID"
  type = string
}
