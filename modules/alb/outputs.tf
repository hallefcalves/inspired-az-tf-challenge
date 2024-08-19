output "load_balancer_public_ip" {
  description = "The public IP address of the Load Balancer"
  value       = azurerm_public_ip.alb.ip_address
}

output "lb_backend_pool_id" {
  value = [azurerm_lb_backend_address_pool.lb_backend.id]
}

output "load_balancer_health_probe_id" {
  value = azurerm_lb_probe.http_probe.id
}