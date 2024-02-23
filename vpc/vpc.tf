# data "aws_availability_zones" "available" {
#   state = "available"
# }


module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.2.0/16"

  azs             = ["us-east-2a", "us-east-2b", "us-east-2c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}


# resource "aws_security_group" "allow_rds" {
#   name        = "allow_rds"
#   description = "Allow rd inbound traffic"
#   vpc_id      = module.vpc.id

#   ingress {
#     description      = "rd from VPC"
#     from_port        = 3306
#     to_port          = 3306
#     protocol         = "tcp"
#     cidr_blocks      = ["43.225.20.162/32"]
    
#   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

#   tags = {
#     Name = "allow_rds"
#   }
# }


output "public_subnet_ids" {
  value = module.vpc.public_subnets
}

# output "db_sg" {
#   value = aws_security_group.allow_rds.id
# }


