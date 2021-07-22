resource "aws_security_group" "movies_front_security_group" {
  name        = "front_security_group"
  description = "Security group for movies front instance"
  vpc_id      = data.aws_vpc.ramp_up_vpc.id

  ingress {
    description = var.front_sg_ingress_description
    from_port   = var.front_sg_ingress_port
    to_port     = var.front_sg_ingress_port
    protocol    = var.front_sg_ingress_protocol
    cidr_blocks = var.front_sg_ingress_cird
  }
  egress {
    description = "Outbound rule"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    project     = var.project,
    responsible = var.responsible
  }
}

resource "aws_security_group" "movies_back_security_group" {
  name        = "back_security_group"
  description = "Security group for movies back instance"
  vpc_id      = data.aws_vpc.ramp_up_vpc.id

  ingress {
    description = var.back_sg_ingress_description
    from_port   = var.back_sg_ingress_port
    to_port     = var.back_sg_ingress_port
    protocol    = var.back_sg_ingress_protocol
    cidr_blocks = var.back_sg_ingress_cird
  }
  egress {
    description = "Outbound rule"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    project     = var.project,
    responsible = var.responsible
  }
}

resource "aws_security_group" "movies_db_security_group" {
  name        = "db_security_group"
  description = "Security group for movies db instance"
  vpc_id      = data.aws_vpc.ramp_up_vpc.id

  ingress {
    description = var.db_sg_ingress_description
    from_port   = var.db_sg_ingress_port
    to_port     = var.db_sg_ingress_port
    protocol    = var.db_sg_ingress_protocol
    cidr_blocks = var.db_sg_ingress_cird
  }
  egress {
    description = "Outbound rule"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    project     = var.project,
    responsible = var.responsible
  }
}