## Front instance
resource "aws_security_group" "movies_front_security_group" {
  name        = "front_security_group"
  description = "Security group for movies front instance"
  vpc_id      = data.aws_vpc.ramp_up_vpc.id

  ingress {
    description = var.front_sg_ingress_description
    from_port   = var.front_port
    to_port     = var.front_port
    protocol    = var.front_sg_ingress_protocol
    cidr_blocks = var.front_sg_ingress_cird
  }
  ingress {
    description = var.shh_sg_ingress_description
    from_port   = var.ssh_sg_ingress_port
    to_port     = var.ssh_sg_ingress_port
    protocol    = var.front_sg_ingress_protocol
    cidr_blocks = ["${chomp(data.http.my_ip.body)}/32"]
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

## Front lb
resource "aws_security_group" "movies_lb_front_security_group" {
  name        = "front_lb_security_group"
  description = "Security group for movies front load balancer"
  vpc_id      = data.aws_vpc.ramp_up_vpc.id

  ingress {
    description = var.front_sg_ingress_description
    from_port   = var.front_port
    to_port     = var.front_port
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

### Back Instance
resource "aws_security_group" "movies_back_security_group" {
  name        = "back_security_group"
  description = "Security group for movies back instance"
  vpc_id      = data.aws_vpc.ramp_up_vpc.id

  ingress {
    description = var.back_sg_ingress_description
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = var.shh_sg_ingress_description
    from_port   = var.ssh_sg_ingress_port
    to_port     = var.ssh_sg_ingress_port
    protocol    = var.ssh_sg_ingress_protocol
    cidr_blocks = [data.aws_subnet.public_subnet_1.cidr_block, data.aws_subnet.private_subnet_1.cidr_block,
      data.aws_subnet.public_subnet_2.cidr_block, data.aws_subnet.private_subnet_2.cidr_block]
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

### Back LB
resource "aws_security_group" "movies_lb_back_security_group" {
  name        = "back_lb_security_group"
  description = "Security group for movies back lb"
  vpc_id      = data.aws_vpc.ramp_up_vpc.id

  ingress {
    description = var.back_sg_ingress_description
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
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

### DB instance
resource "aws_security_group" "movies_db_security_group" {
  name        = "db_security_group"
  description = "Security group for movies db instance"
  vpc_id      = data.aws_vpc.ramp_up_vpc.id

  ingress {
    description = var.db_sg_ingress_description
    from_port   = var.db_sg_ingress_port
    to_port     = var.db_sg_ingress_port
    protocol    = var.db_sg_ingress_protocol
    cidr_blocks = [data.aws_subnet.private_subnet_1.cidr_block, data.aws_subnet.private_subnet_2.cidr_block]
  }

  ingress {
    description = var.shh_sg_ingress_description
    from_port   = var.ssh_sg_ingress_port
    to_port     = var.ssh_sg_ingress_port
    protocol    = var.ssh_sg_ingress_protocol
    cidr_blocks = [data.aws_subnet.public_subnet_1.cidr_block, data.aws_subnet.private_subnet_1.cidr_block]
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