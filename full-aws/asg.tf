### Front
resource "aws_autoscaling_group" "front_asg" {
  max_size = 1
  min_size = 1
  desired_capacity = 1

  vpc_zone_identifier = [
    data.aws_subnet.public_subnet_1.id,
    data.aws_subnet.public_subnet_2.id]
  target_group_arns = [
    aws_lb_target_group.front_target_group.arn]

  launch_template {
    id = aws_launch_template.movies_front.id
  }
  tags = [
    {
      project = var.project,
      responsible = var.responsible,
      Name = "Movies_front_asg"
    }
  ]
}

### Back
resource "aws_autoscaling_group" "back_asg" {
  max_size = 1
  min_size = 1
  desired_capacity = 1

  vpc_zone_identifier = [
    data.aws_subnet.private_subnet_1.id,
    data.aws_subnet.private_subnet_2.id]
  target_group_arns = [
    aws_lb_target_group.back_target_group.arn]

  launch_template {
    id = aws_launch_template.movies_back.id
  }
  tags = [
    {
      project = var.project,
      responsible = var.responsible,
      Name = "Movies_back_asg"
    }
  ]
}