module "vpc" {
  source                     = "./vpc"
  region                     = var.region
  project_name               = var.project_name
  vpc_cidr                   = var.vpc_cidr
  vpc_name                   = var.vpc_name
  igw_name                   = var.igw_name
  public_subnet_cidr_blocks  = var.public_subnet_cidr_blocks
  private_subnet_cidr_blocks = var.private_subnet_cidr_blocks
  rt_name                    = var.rt_name
}


module "ui" {
  source                     = "./ui"
  region                     = var.region
  project_name               = var.project_name
  environment                = var.environment
  architecture               = var.architecture
  container_image            = var.container_image
  public_subnet_cidr_blocks  = module.vpc.public_subnet_ids
  private_subnet_cidr_blocks = var.private_subnet_cidr_blocks
  vpc_id                     = module.vpc.vpc_id
}
