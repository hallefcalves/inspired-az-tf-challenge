output "load_balancer_public_ip" {
  description = "The public IP of the Azure Load Balancer"
  value       = module.alb.load_balancer_public_ip
}

output "vmss_name" {
  description = "The name of the VM Scale Set"
  value       = module.vmss.vmss_name
}
