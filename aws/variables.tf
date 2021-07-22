### Tags ###
variable "project" {
  type        = string
  description = "Required project tag"
}
variable "responsible" {
  type        = string
  description = "responsible name"
}

### Resources ###
variable "vpc_id" {
  description = "RampUp designed VPC"
}
variable "public_subnet_1_id" {
  description = "first public subnet"
}
variable "public_subnet_2_id" {
  description = "second public subnet"
}
variable "private_subnet_1_id" {
  description = "first private subnet"
}
variable "private_subnet_2_id" {
  description = "second private subnet"
}
variable "nat_gateway_id" {}
variable "internet_gateway_id" {}
variable "private_route_table_id" {}
variable "public_route_table_id" {}

### Instance type ###
variable "instance_type" {
  default = "t2.micro"
}

variable "ami_id" {
  type        = string
  default     = "ami-0d382e80be7ffdae5"
  description = "Ubuntu 20.04"
}

### front security group vars ###

variable "front_sg_ingress_protocol" {
  type        = string
  default     = "tcp"
  description = "This is the protocol for the inbound rule that allowed front to the ec2 instance"
}

variable "front_sg_ingress_description" {
  type    = string
  default = "Allowed front from anywhere"
}

variable "front_sg_ingress_port" {
  type        = number
  default     = 3030
  description = "This is the port for the inbound rule that allowed front to the ec2 instance"
}
variable "front_sg_ingress_cird" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "This is the list of CIDR"
}

### back security group vars ###

variable "back_sg_ingress_protocol" {
  type        = string
  default     = "tcp"
  description = "This is the protocol for the inbound rule that allowed back to the ec2 instance"
}

variable "back_sg_ingress_description" {
  type    = string
  default = "Allowed back from anywhere"
}

variable "back_sg_ingress_port" {
  type        = number
  default     = 3000
  description = "This is the port for the inbound rule that allowed back to the ec2 instance"
}
variable "back_sg_ingress_cird" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "This is the list of CIDR"
}

### db security group vars ###

variable "db_sg_ingress_protocol" {
  type        = string
  default     = "tcp"
  description = "This is the protocol for the inbound rule that allowed db to the ec2 instance"
}

variable "db_sg_ingress_description" {
  type    = string
  default = "Allowed db from anywhere"
}

variable "db_sg_ingress_port" {
  type        = number
  default     = 3036
  description = "This is the port for the inbound rule that allowed db to the ec2 instance"
}
variable "db_sg_ingress_cird" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "This is the list of CIDR"
}