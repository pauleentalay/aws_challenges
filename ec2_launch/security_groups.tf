resource "aws_security_group" "my_public_app_sg" {
  name        = "my_public_app_sg"
  description = "Allow access to public server"
  vpc_id      = data.aws_vpc.movies_vpc.id
  #cidr_blocks

  # INBOUND CONNECTIONS
  ingress {
    description = "Allow SSH into the public subnet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    #self       = true
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
    protocol    = "-1"          # TCP + UDP
    cidr_blocks = ["0.0.0.0/0"] # all traffic
  }

  egress {
    description = "Allow SSH out of the public subnet and to get into the private subnet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"         # TCP + UDP
    cidr_blocks = ["0.0.0.0/0"] # all traffic
  }

  egress {
    description = "HTTP to public subnet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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
    protocol    = "-1"          # TCP + UDP
    cidr_blocks = ["0.0.0.0/0"] # all traffic
  }

  egress {
    description = "HTTP to public subnet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "my_db_sg" {
  name        = "my_db_sg"
  description = "Security group for RDS"
  vpc_id      = data.aws_vpc.movies_vpc.id
  #cidr_blocks

  # INBOUND CONNECTIONS
  ingress {
    description = "Allow SSH into the public subnet"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    #self       = true
    security_groups = [aws_security_group.my_public_app_sg.id] #data.aws_subnet.public_subnet_1.cidr_block  # why public subnet alone does not work?
  }
}