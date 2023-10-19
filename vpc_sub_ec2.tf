terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}



resource "aws_vpc" "vpc_east1" {
  cidr_block = var.vpc_east1
  enable_dns_support = true
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc_east1.id
  tags = {
    Name = "igw_east1"
  }
}

#Subnets Publicas

resource "aws_subnet" "subnet1_public" {
  tags = {
    Name = "subnet1_public"
  }
  vpc_id            = aws_vpc.vpc_east1.id
  cidr_block        = var.subnet1_public
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "subnet2_public" {
  tags = {
    Name = "subnet2_public"
  }
  vpc_id            = aws_vpc.vpc_east1.id
  cidr_block        = var.subnet2_public
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
}

# 2 Private subnets with RDS MySQL instance
resource "aws_subnet" "subnet1_private" {
  tags = {
    Name = "subnet1_private"
  }
  vpc_id            = aws_vpc.vpc_east1.id
  cidr_block        = var.subnet1_private
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = false
}

resource "aws_subnet" "subnet2_private" {
  tags = {
    Name = "subnet2_private"
  }
  vpc_id            = aws_vpc.vpc_east1.id
  cidr_block        = var.subnet2_private
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = false
}


resource "aws_instance" "EC2-1" {
  ami                         = "ami-0df435f331839b2d6"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.subnet1_public.id
  associate_public_ip_address = true
  count                       = 1
}

#Create EC2 instance in publice subnet2
resource "aws_instance" "EC2_2" {
  ami                         = "ami-0df435f331839b2d6"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.subnet2_public.id
  associate_public_ip_address = true
  count                       = 1
}
resource "aws_db_instance" "instance_rds" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  db_name              = "teste_db"
  username             = "admin"
  password             = "15468105540"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true


  db_subnet_group_name = aws_db_subnet_group.my_db_subnet_group.name
  }

  resource "aws_db_subnet_group" "my_db_subnet_group" {
  name       = "my-db-subnet-group"
  description = "My DB subnet group"
  subnet_ids = [aws_subnet.subnet1_private.id, aws_subnet.subnet2_private.id] 
}