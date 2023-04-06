resource "aws_launch_template" "movies_front" {
  depends_on = [null_resource.bastion_provision]
  instance_type = var.instance_type
  image_id = var.ami_id
  vpc_security_group_ids = [
    aws_security_group.movies_front_security_group.id]
  key_name = aws_key_pair.carlos_elv_key.key_name

  user_data = base64encode(templatefile("./scripts/setup-front.sh", {
    dns = aws_lb.back_application_lb.dns_name,
    bastion = aws_instance.bastion.private_ip
  }))

  tag_specifications {
    resource_type = "volume"

    tags = {
      project = var.project,
      responsible = var.responsible
    }
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      project = var.project,
      responsible = var.responsible,
      Name = "Movies_front_instance"
    }
  }
}

resource "aws_launch_template" "movies_back" {
  depends_on = [null_resource.bastion_provision]
  instance_type = var.instance_type
  image_id = var.ami_id
  vpc_security_group_ids = [
    aws_security_group.movies_back_security_group.id]
  key_name = aws_key_pair.carlos_elv_key.key_name
  user_data = base64encode(templatefile("./scripts/setup-back.sh", {
    dns = aws_db_instance.movie_db.address,
    bastion = aws_instance.bastion.private_ip,
    pass = var.MYSQL_ROOT_PASSWORD
  }))

  tag_specifications {
    resource_type = "volume"

    tags = {
      project = var.project,
      responsible = var.responsible
    }
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      project = var.project,
      responsible = var.responsible,
      Name = "Movies_back_instance"
    }
  }
}