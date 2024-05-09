module "networking-staging" {
  source          = "../../modules/Networking"
  env             = var.env
  vpc_cidr        = var.vpc_cidr
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
}

module "sg-staging" {
  source   = "../../modules/SG"
  vpc_cidr = var.vpc_cidr
  env      = var.env
  vpc_id   = module.networking-staging.vpc_id
}

module "launch-templates-staging" {
  source        = "../../modules/Launch templates"
  env           = var.env
  instance_type = var.instance_type
  public_subnet = module.networking-staging.public_subnet
  bastion_sg    = module.sg-staging.bastion_sg
  vm_sg         = module.sg-staging.vm_sg
}

module "alb-staging" {
  source         = "../../modules/ALB"
  env            = var.env
  vm_sg          = [module.sg-staging.vm_sg]
  vpc_id         = module.networking-staging.vpc_id
  public_subnet = module.networking-staging.public_subnet
}

module "asg-staging" {
  source                            = "../../modules/ASG"
  env                               = var.env
  private_subnet                    = module.networking-staging.private_subnet
  vm_launch_template_id             = module.launch-templates-staging.vm_launch_template_id
  vm_launch_template_latest_version = module.launch-templates-staging.vm_launch_template_latest_version
  alb_target_group_arn              = [module.alb-staging.alb_target_group_arn]
}