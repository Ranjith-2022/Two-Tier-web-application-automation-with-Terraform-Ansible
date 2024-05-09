output "bastion_id" {
  value = aws_instance.bastion.id
}

output "vm_launch_template_id" {
  value = aws_launch_template.vm_launch_template.id
}

output "vm_launch_template_latest_version" {
  value = aws_launch_template.vm_launch_template.latest_version
}