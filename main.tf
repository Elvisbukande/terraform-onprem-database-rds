module "vpc" {
    source = "./vpc"
}

module "iam" {
  source = "./iam"
}

module "rds" {
  source = "./rds"
  iam_role = module.iam.s3_iam_role
  subnet_ids = module.vpc.public_subnet_ids
}