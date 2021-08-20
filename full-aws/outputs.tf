output "bastion" {
  value = aws_instance.bastion.public_ip
}

output "lb" {
  value = aws_lb.front_application_lb.dns_name
}

output "github" {
  value = data.github_ip_ranges.github_ranges.hooks
}