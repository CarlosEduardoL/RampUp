resource "aws_instance" "bastion" {
  instance_type = var.instance_type
  ami = var.ami_id
  vpc_security_group_ids = [
    aws_security_group.movies_bastion_security_group.id]
  subnet_id = data.aws_subnet.public_subnet_1.id
  key_name = aws_key_pair.carlos_elv_key.key_name

  tags = {
    project = var.project,
    responsible = var.responsible,
    Name = "Movies_bastion_instance"
  }

  volume_tags = {
    project = var.project,
    responsible = var.responsible
  }
}

resource "null_resource" "bastion_provision" {
  provisioner "local-exec" {
    command = "go build -ldflags \"-X main.pass=${var.MYSQL_ROOT_PASSWORD} -w -s\" -o files/provision_server scripts/server.go"
  }
  provisioner "local-exec" {
    command = "sleep 30 && ansible-playbook -i ${aws_instance.bastion.public_ip}, ./scripts/bastion.yml --private-key ~/.ssh/id_rsa -u ubuntu -e password=${var.MYSQL_ROOT_PASSWORD} -e address=${aws_db_instance.movie_db.address}"
  }
}