module "roboshop" {
  source = "../../terraform_aws_vpc"
  #source = "git::https://github.com/pjuned/terraform_aws_vpc.git?ref=main"
  project_name = var.project_name
  environment = var.environment
  common_tags = var.common_tags
  vpc_tags = var.vpc_tags

    #public subnets
    public_subnets_cidr = var.public_subnets_cidr

    #private subnets
    private_subnets_cidr = var.private_subnets_cidr

    #database subnets
    database_subnets_cidr = var.database_subnets_cidr

    #peering
    is_peering_required = var.is_peering_required


}