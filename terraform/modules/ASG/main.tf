# # Auto Scaling Group
resource "aws_autoscaling_group" "vm_asg" {
  name                = "AutoScaling"
  desired_capacity    = 3
  max_size            = 4
  min_size            = 3
  vpc_zone_identifier = var.private_subnet[*]
  target_group_arns   = var.alb_target_group_arn

  launch_template {
    id      = var.vm_launch_template_id
    version = var.vm_launch_template_latest_version
  }

  tag {
    key                 = "Name"
    value               = "app-instance"
    propagate_at_launch = true
  }

  health_check_type         = "EC2"
  #health_check_grace_period = 300 # 5 minutes grace period

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_policy" "vm_scale_out_policy" {
  name                   = "removeToScaleDown"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300 # 5 minutes cooldown period
  autoscaling_group_name = aws_autoscaling_group.vm_asg.name
}