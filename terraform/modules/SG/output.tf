output "bastion_sg" {
  value = aws_security_group.bastion_sg.id
}

output "vm_sg" {
  value = aws_security_group.vm_sg.id
}