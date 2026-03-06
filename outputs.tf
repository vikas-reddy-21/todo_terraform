output "elastic_ip" {
  value       = aws_eip.todo_eip.public_ip
  description = "Elastic IP of the EC2 instance"
}
