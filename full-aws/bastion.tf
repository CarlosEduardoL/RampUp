resource "aws_instance" "bastion" {
  instance_type          = var.instance_type
  ami                    = var.ami_id
  vpc_security_group_ids = [aws_security_group.movies_bastion_security_group.id]
  subnet_id              = data.aws_subnet.public_subnet_1.id
  key_name               = aws_key_pair.carlos_elv_key.key_name
  user_data              = base64encode(templatefile("./scripts/bastion_setup.sh", {}))

  tags = {
    project     = var.project,
    responsible = var.responsible,
    Name        = "Movies_bastion_instance"
  }

  volume_tags = {
    project     = var.project,
    responsible = var.responsible
  }

  provisioner "file" {
    source      = "~/.ssh/id_rsa"
    destination = "~/.ssh/id_rsa"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      host        = self.public_ip
      private_key = file("~/.ssh/id_rsa")
    } 
  }
}