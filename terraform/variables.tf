# Variables for your Short URL project
# You can change these values in terraform.tfvars

variable "aws_region" {
  description = "AWS region where your server will be created"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name for your project (will be used in resource names)"
  type        = string
  default     = "short-url"
}

variable "instance_type" {
  description = "EC2 instance size (t2.micro is free tier eligible)"
  type        = string
  default     = "t2.micro"  # Free tier eligible
}

variable "public_key_path" {
  description = "Path to your SSH public key file"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}