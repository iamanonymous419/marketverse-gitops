
output "instance_dns" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.machine.public_dns
}

output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.machine.id
}

output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.machine.public_ip
}

