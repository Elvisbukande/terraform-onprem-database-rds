variable "iam_role" {
    description = "iam role get backup from s3"    
}

variable "subnet_ids" {
    type  = list
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "main"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "My DB subnet group"
  }
}


resource "aws_db_parameter_group" "db_parameter_group" {
  name   = "rds-pg"
  family = "mysql8.0"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
}

resource "aws_db_instance" "default" {
  allocated_storage    = 50
  engine               = "mysql"
  engine_version       = "8.0.28"
  instance_class       = "db.t3.micro"
  db_name                 = "mydb"
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = aws_db_parameter_group.db_parameter_group.name
#   parameter_group_name = "mysql8.0"
  skip_final_snapshot  = true
  publicly_accessible = true
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name

   s3_import {
    source_engine         = "mysql"
    source_engine_version = "8.0.20"
    bucket_name           = "lane-devops-pairing-exercise-bucket-v2"
    #bucket_prefix         = "backups"
    ingestion_role        = var.iam_role
  }
}