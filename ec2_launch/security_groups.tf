resource "aws_security_group" "my_public_app_sg" {
  name        = "my_public_app_sg"
  description = "Allow access to public server"
  vpc_id      = data.aws_vpc.movies_vpc.id

  # INBOUND CONNECTIONS
  ingress {
    description = "Allow SSH into the public subnet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [data.aws_subnet.public_subnet_1.cidr_block]
  }

  ingress {
    description = "Internet access to public subnet"
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = [data.aws_subnet.public_subnet_1.cidr_block]
  }

  # OUTBOUND CONNECTIONS
  egress {
    description = "Allow access to the world"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"                                         # TCP + UDP
    cidr_blocks = [data.aws_subnet.public_subnet_1.cidr_block] # all traffic
  }
}

resource "aws_security_group" "my_private_app_sg" {
  name        = "my_private_app_sg"
  description = "Allow access to this private server from the public server"
  vpc_id      = data.aws_vpc.movies_vpc.id

  # INBOUND CONNECTIONS
  ingress {
    description = "Allow SSH into the private subnet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [data.aws_subnet.private_subnet_1.cidr_block]
  }
}