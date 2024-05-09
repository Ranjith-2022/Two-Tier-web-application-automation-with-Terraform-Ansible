# Data source for AMI id
data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Bastion
resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.bastion_key.key_name
  subnet_id                   = var.public_subnet[0]
  security_groups             = [var.bastion_sg]
  associate_public_ip_address = true

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name    = "Amazon-bastion-VM"
    role    = "bastion_host"
    service = "shadowy_inspiration"
    env     = "${var.env}"
  }
}

# SSH key to Amazon EC2
resource "aws_key_pair" "bastion_key" {
  key_name   = var.env
  public_key = file("bastion_key.pub")
}

#launch template
resource "aws_launch_template" "vm_launch_template" {
  name = "vm-launch-template"

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 30
      volume_type = "gp2"
    }
  }

  network_interfaces {
    security_groups = [var.vm_sg]
  }

  instance_type = var.instance_type
  key_name      = aws_key_pair.vm_key.key_name

  image_id = data.aws_ami.latest_amazon_linux.id

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name    = "app-instance"
      role    = "Webserver_host"
      service = "shadowy_inspiration"
      env     = "${var.env}"

    }
  }
}

# SSH key to Amazon EC2
resource "aws_key_pair" "vm_key" {
  key_name   = "vm_key"
  public_key = file("vm_key.pub")
}
