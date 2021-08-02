output "bastion" {
  value = aws_instance.bastion.public_ip
}