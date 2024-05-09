module "networking-production" {
  source          = "../../modules/Networking"
  env             = var.env
  vpc_cidr        = var.vpc_cidr
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
}

module "sg-production" {
  source   = "../../modules/SG"
  vpc_cidr = var.vpc_cidr
  env      = var.env
  vpc_id   = module.networking-production.vpc_id
}

module "launch-templates-production" {
  source        = "../../modules/Launch templates"
  env           = var.env
  instance_type = var.instance_type
  public_subnet = module.networking-production.public_subnet
  bastion_sg    = module.sg-production.bastion_sg
  vm_sg         = module.sg-production.vm_sg
}

module "alb-production" {
  source         = "../../modules/ALB"
  env            = var.env
  vm_sg          = [module.sg-production.vm_sg]
  vpc_id         = module.networking-production.vpc_id
  public_subnet = module.networking-production.public_subnet
}

module "asg-production" {
  source                            = "../../modules/ASG"
  env                               = var.env
  private_subnet                    = module.networking-production.private_subnet
  vm_launch_template_id             = module.launch-templates-production.vm_launch_template_id
  vm_launch_template_latest_version = module.launch-templates-production.vm_launch_template_latest_version
  alb_target_group_arn              = [module.alb-production.alb_target_group_arn]
}