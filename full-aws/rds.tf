//resource "aws_db_instance" "movie_db" {
//  instance_class         = "db.t3.micro"
//  engine                 = "mysql"
//  name                   = "movie_db"
//  username               = "root"
//  password               = var.MYSQL_ROOT_PASSWORD
//  allocated_storage      = 10
//  vpc_security_group_ids = [aws_security_group.movies_db_security_group.id]
//}