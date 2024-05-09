output "vpc_id" {
  value = module.networking-staging.vpc_id
}

output "public_subnet" {
  value = module.networking-staging.public_subnet
}

output "private_subnet" {
  value = module.networking-staging.private_subnet
}

output "bastion_sg" {
  value = module.sg-staging.bastion_sg
}

output "vm_sg" {
  value = module.sg-staging.vm_sg
}

output "load_balancer_dns_name" {
  value = module.alb-staging.load_balancer_dns_name
}

output "alb_target_group_arn" {
  value = module.alb-staging.alb_target_group_arn
}

output "bastion_id" {
  value = module.launch-templates-staging.bastion_id
}

output "vm_launch_template_id" {
  value = module.launch-templates-staging.vm_launch_template_id
}

output "vm_launch_template_latest_version" {
  value = module.launch-templates-staging.vm_launch_template_latest_version
}

output "vm_asg_id" {
  value = module.asg-staging.vm_asg_id
}