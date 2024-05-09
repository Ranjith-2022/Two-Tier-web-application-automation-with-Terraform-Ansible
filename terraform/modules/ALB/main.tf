resource "aws_alb" "application_load_balancer" {
  name               = "${var.env}-alb"
  internal           = false
  load_balancer_type = "application"

  subnets         = var.public_subnet[*]
  security_groups = var.vm_sg

  tags = merge(
    {
      Name = "${var.env}-alb",
      env  = var.env,
      role = "ALB"
    },
    var.tags
  )
}

resource "aws_alb_target_group" "alb_tg" {
  name_prefix = "alb-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    path                = "/"
    port                = 80
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  load_balancing_algorithm_type = "least_outstanding_requests"

  tags = merge(
    {
      Name = "${var.env}-alb-target-group"
      env  = var.env,
      role = "ALB_Target_Group"
    },
    var.tags
  )
}

resource "aws_alb_listener" "application_listener" {
  load_balancer_arn = aws_alb.application_load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.alb_tg.arn
    type             = "forward"
  }
}