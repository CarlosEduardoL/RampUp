resource "aws_db_subnet_group" "movie_db_group" {
  name       = "movie_db_subnet_group"
  subnet_ids = [data.aws_subnet.private_subnet_1.id, data.aws_subnet.private_subnet_2.id]

  tags = {
    project     = var.project,
    responsible = var.responsible,
  }
}

resource "aws_db_instance" "movie_db" {
  instance_class         = "db.t3.micro"
  engine                 = "mysql"
  engine_version         = "5.7"
  name                   = "movie_db"
  username               = "root"
  password               = var.MYSQL_ROOT_PASSWORD
  allocated_storage      = 5
  vpc_security_group_ids = [aws_security_group.movies_db_security_group.id]
  db_subnet_group_name   = aws_db_subnet_group.movie_db_group.name
  skip_final_snapshot    = true

  tags = {
    project     = var.project,
    responsible = var.responsible
  }
}