output "instance_public_ip" {
  value       = aws_instance.goldenowl_instance.public_ip
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.goldenowl_instance.id
}

output "ecr_repository_url" {
  description = "URL to push/pull the application image"
  value       = aws_ecr_repository.goldenowl_ecr.repository_url
}

