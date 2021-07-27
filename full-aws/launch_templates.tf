resource "aws_launch_template" "movies_front" {
  instance_type          = var.instance_type
  image_id               = var.ami_id
  vpc_security_group_ids = [aws_security_group.movies_front_security_group.id]
  key_name               = aws_key_pair.carlos_elv_key.key_name
  user_data              = base64encode(templatefile("./install-docker.sh", {
    run = "sudo docker run -p 3030:3030 --restart=always -d -e BACK_HOST=${aws_lb.back_application_lb.dns_name} zeronetdev/rampup-front:0.0.1"
  }))

  tag_specifications {
    resource_type = "volume"

    tags = {
      project     = var.project,
      responsible = var.responsible
    }
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      project     = var.project,
      responsible = var.responsible,
      Name        = "Movies_front_instance"
    }
  }
}

resource "aws_launch_template" "movies_back" {
  instance_type          = var.instance_type
  image_id               = var.ami_id
  vpc_security_group_ids = [aws_security_group.movies_back_security_group.id]
  key_name               = aws_key_pair.carlos_elv_key.key_name
  user_data              = base64encode(templatefile("./install-docker.sh", {
    run = "sudo docker run --restart=always -d -p 3000:3000 -e DB_HOST=${aws_instance.movies_db.private_ip} -e DB_USER=root -e DB_PASS=${var.MYSQL_ROOT_PASSWORD} zeronetdev/rampup-back:0.0.1"
  }))

  tag_specifications {
    resource_type = "volume"

    tags = {
      project     = var.project,
      responsible = var.responsible
    }
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      project     = var.project,
      responsible = var.responsible,
      Name        = "Movies_back_instance"
    }
  }
}

resource "aws_instance" "movies_db" {
  instance_type          = var.instance_type
  ami                    = var.ami_id
  vpc_security_group_ids = [aws_security_group.movies_db_security_group.id]
  subnet_id              = data.aws_subnet.private_subnet_1.id
  key_name               = aws_key_pair.carlos_elv_key.key_name
  user_data              = base64encode(templatefile("./install-docker.sh", {
    run = "sudo docker run --restart=always -d -p 3306:3306 -e MYSQL_DATABASE=movie_db -e MYSQL_ROOT_PASSWORD=${var.MYSQL_ROOT_PASSWORD} zeronetdev/rampup-db:0.0.1"
  }))

  tags = {
    project     = var.project,
    responsible = var.responsible,
    Name        = "Movies_db_instance"
  }

  volume_tags = {
    project     = var.project,
    responsible = var.responsible
  }
}