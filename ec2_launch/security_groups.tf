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
    cidr_blocks = ["0.0.0.0/0"] #data.aws_subnet.public_subnet_1.cidr_block  # why public subnet alone does not work?
  }

  ingress {
    description = "Internet access to public subnet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP to public subnet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # OUTBOUND CONNECTIONS
  egress {
    description = "Allow access to the world"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"                                         # TCP + UDP
    cidr_blocks =  ["0.0.0.0/0"] # all traffic
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
    cidr_blocks = [data.aws_subnet.public_subnet_1.cidr_block]
  }

  ingress {
    description = "HTTP to public subnet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [data.aws_subnet.public_subnet_1.cidr_block]
  }

  egress {
    description = "Allow access to the world"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"                                         # TCP + UDP
    cidr_blocks =  ["0.0.0.0/0"] # all traffic
  }
}