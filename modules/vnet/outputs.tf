output "subnet_ids" {
  description = "The IDs of the created subnets"
  value       = [for subnet in azurerm_subnet.subnets : subnet.id]
}