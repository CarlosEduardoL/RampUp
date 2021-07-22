resource "aws_instance" "movies_front" {
  instance_type          = var.instance_type
  ami                    = var.ami_id
  vpc_security_group_ids = [aws_security_group.movies_front_security_group.id]
  subnet_id              = data.aws_subnet.public_subnet_1.id
  key_name               = aws_key_pair.carlos_elv_key.key_name
  user_data              = base64encode(templatefile("./install-docker.sh", {}))

  tags = {
    project     = var.project,
    responsible = var.responsible,
    Name        = "Movies_front_instance"
  }

  volume_tags = {
    project     = var.project,
    responsible = var.responsible
  }
}

resource "aws_instance" "movies_back" {
  instance_type          = var.instance_type
  ami                    = var.ami_id
  vpc_security_group_ids = [aws_security_group.movies_back_security_group.id]
  subnet_id              = data.aws_subnet.private_subnet_1.id
  key_name               = aws_key_pair.carlos_elv_key.key_name
  user_data              = base64encode(templatefile("./install-docker.sh", {}))

  tags = {
    project     = var.project,
    responsible = var.responsible,
    Name        = "Movies_back_instance"
  }

  volume_tags = {
    project     = var.project,
    responsible = var.responsible
  }
}

resource "aws_instance" "movies_db" {
  instance_type          = var.instance_type
  ami                    = var.ami_id
  vpc_security_group_ids = [aws_security_group.movies_db_security_group.id]
  subnet_id              = data.aws_subnet.private_subnet_1.id
  key_name               = aws_key_pair.carlos_elv_key.key_name
  user_data              = base64encode(templatefile("./install-docker.sh", {}))

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