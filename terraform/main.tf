# Simple Terraform configuration for Short URL application on AWS
# Perfect for students - just one EC2 instance!

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure AWS Provider
provider "aws" {
  region = var.aws_region
}

# Get the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Create a security group (firewall rules)
resource "aws_security_group" "short_url_sg" {
  name        = "${var.project_name}-sg"
  description = "Security group for Short URL app"

  # Allow SSH (port 22) - for connecting to your server
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow from anywhere (you can restrict this)
  }

  # Allow Flask app (port 5000) - for accessing your website
  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-security-group"
  }
}

# Create a key pair for SSH access
resource "aws_key_pair" "short_url_key" {
  key_name   = "${var.project_name}-key"
  public_key = file(var.public_key_path)

  tags = {
    Name = "${var.project_name}-key"
  }
}

# Create the EC2 instance (your server)
resource "aws_instance" "short_url_server" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.short_url_key.key_name

  # Attach the security group
  vpc_security_group_ids = [aws_security_group.short_url_sg.id]

  # Script to run when the instance starts
  user_data = base64encode(<<-EOF
    #!/bin/bash
    yum update -y
    yum install -y python3 python3-pip
    pip3 install Flask
    mkdir -p /home/ec2-user/app
    cd /home/ec2-user/app
    cat > main.py << 'PYEOF'
from flask import Flask, request, redirect
import random, string
app = Flask(__name__)
urls = {}
@app.route('/')
def home():
    return '<form action="/s" method="post"><input name="url" placeholder="Enter URL" required><button>Shorten</button></form>'
@app.route('/s', methods=['POST'])
def shorten():
    u = request.form['url']
    if not u.startswith(('http://', 'https://')): u = 'http://' + u
    c = ''.join(random.choices(string.ascii_letters + string.digits, k=4))
    urls[c] = u
    return f'<a href="/{c}">{request.url_root}{c}</a><br><a href="/">Back</a>'
@app.route('/<c>')
def r(c):
    return redirect(urls.get(c, '/'))
app.run(host='0.0.0.0', port=5000)
PYEOF
    chown -R ec2-user:ec2-user /home/ec2-user/app
    su - ec2-user -c "cd /home/ec2-user/app && python3 main.py" &
  EOF
  )

  tags = {
    Name = "${var.project_name}-server"
  }
}