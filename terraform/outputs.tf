# Outputs - Important information after deployment

output "server_public_ip" {
  description = "Public IP address of your server"
  value       = aws_instance.short_url_server.public_ip
}

output "application_url" {
  description = "URL to access your Short URL app"
  value       = "http://${aws_instance.short_url_server.public_ip}:5000"
}

output "ssh_command" {
  description = "Command to SSH into your server"
  value       = "ssh -i ~/.ssh/id_rsa ec2-user@${aws_instance.short_url_server.public_ip}"
}

output "server_info" {
  description = "Basic server information"
  value = {
    instance_id = aws_instance.short_url_server.id
    public_ip   = aws_instance.short_url_server.public_ip
    private_ip  = aws_instance.short_url_server.private_ip
  }
}