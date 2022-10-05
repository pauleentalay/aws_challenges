# file to declare variables

variable "aws_owner_id" {
  description = "Contains the Owner ID of the ami for amazon linux"
  type        = string
}

variable "aws_ami_name" {
  description = "Name of the ami I want for my project"
  type        = string
}

variable "vpc_name" {
  description = "Name of VPC for the project"
  type        = string
}

variable "public_subnet_1_name" {
  description = "Name of public subnet for the project"
  type        = string
}

variable "private_subnet_1_name" {
  description = "Name of private subnet for the project"
  type        = string
}

variable "public_subnet_2_name" {
  description = "Name of public subnet for the project"
  type        = string
}

variable "ec2_type" {
  description = "Type of EC2 server"
  type        = string
}

variable "my_keypair" {
  description = "Existing keypair created"
  type        = string
}