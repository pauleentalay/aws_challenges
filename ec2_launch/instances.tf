resource "aws_instance" "public_server" {
  ami                    = data.aws_ami.aws_basic_linux.id
  instance_type          = var.ec2_type
  subnet_id              = data.aws_subnet.public_subnet_1.id
  vpc_security_group_ids = [aws_security_group.my_public_app_sg.id]
  key_name               = var.my_keypair

  tags = {
    Name = "public_server"
  }
}

resource "aws_instance" "private_server_1" {
  ami                    = data.aws_ami.aws_basic_linux.id
  instance_type          = var.ec2_type
  subnet_id              = data.aws_subnet.private_subnet_1.id
  vpc_security_group_ids = [aws_security_group.my_private_app_sg.id]
  key_name               = var.my_keypair

  tags = {
    Name = "private_server_1"
  }
}

resource "aws_instance" "private_server_2" {
  ami                    = data.aws_ami.aws_basic_linux.id
  instance_type          = var.ec2_type
  subnet_id              = data.aws_subnet.private_subnet_1.id
  vpc_security_group_ids = [aws_security_group.my_private_app_sg.id]
  key_name               = var.my_keypair

  tags = {
    Name = "private_server_2"
  }
}

resource "aws_instance" "private_server_3" {
  ami                    = data.aws_ami.aws_basic_linux.id
  instance_type          = var.ec2_type
  subnet_id              = data.aws_subnet.private_subnet_1.id
  vpc_security_group_ids = [aws_security_group.my_private_app_sg.id]
  key_name               = var.my_keypair

  tags = {
    Name = "private_server_3"
  }
}

