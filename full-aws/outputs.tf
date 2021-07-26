output "front" {
  value = aws_lb.front_application_lb.dns_name
}
output "back" {
  value = aws_lb.back_application_lb.dns_name
}
