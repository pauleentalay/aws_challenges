resource "aws_db_instance" "trial" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.0.28"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = "adminadmin"
  
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.my_db_sg.id]
  db_subnet_group_name = aws_db_subnet_group.default.name
}