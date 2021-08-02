output "bastion" {
  value = aws_instance.bastion.public_ip
}

output "lb" {
  value = aws_lb.front_application_lb.dns_name
}