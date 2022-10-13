resource "aws_autoscaling_group" "asg_trial" {
  name                      = "asg-trial"
  max_size                  = 5
  min_size                  = 2
  health_check_grace_period = 300   #not needed
  health_check_type         = "ELB" # not needed
  desired_capacity          = 4

  vpc_zone_identifier       = [data.aws_subnet.private_subnet_1.id]

  launch_template           = {
    id = aws_launch_template.blue_template.id
    version = "$Latest"
  }
  
}

resource "aws_launch_template" "blue_template" {
    name = "blue-template"
    image_id = data.aws_ami.ubuntu_image.id
    instance_type = var.instance_type
    key_name = var.my_keypair
    vpc_security_group_ids = [aws_security_group.my_public_app_sg.id]
    user_data = base64encode(templatefile("${path.module}/user-data.sh.tpl", {
        version = "Blue Website",
        color   = "blue"
  }))
}