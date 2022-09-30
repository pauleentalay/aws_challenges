# get existing vpcs, public and private subnet, and ami information
data "aws_ami" "aws_basic_linux" {
  owners      = [var.aws_owner_id]
  most_recent = true
  filter {
    name   = "name"
    values = [var.aws_ami_name]
  }
}

data "aws_vpc" "movies_vpc" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnet" "public_subnet_1" {
  filter {
    name   = "tag:Name"
    values = [var.public_subnet_1_name]
  }
}

data "aws_subnet" "private_subnet_1" {
  filter {
    name   = "tag:Name"
    values = [var.private_subnet_1_name]
  }
}
