output "vpc_id" {
  value = module.networking-production.vpc_id
}

output "public_subnet" {
  value = module.networking-production.public_subnet
}

output "private_subnet" {
  value = module.networking-production.private_subnet
}

output "bastion_sg" {
  value = module.sg-production.bastion_sg
}

output "vm_sg" {
  value = module.sg-production.vm_sg
}

output "load_balancer_dns_name" {
  value = module.alb-production.load_balancer_dns_name
}

output "alb_target_group_arn" {
  value = module.alb-production.alb_target_group_arn
}

output "bastion_id" {
  value = module.launch-templates-production.bastion_id
}

output "vm_launch_template_id" {
  value = module.launch-templates-production.vm_launch_template_id
}

output "vm_launch_template_latest_version" {
  value = module.launch-templates-production.vm_launch_template_latest_version
}

output "vm_asg_id" {
  value = module.asg-production.vm_asg_id
}