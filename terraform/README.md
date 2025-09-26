# Terraform Infrastructure for Short URL App

Simple AWS deployment using Terraform to create a single EC2 instance running the Flask URL shortener.

## What gets created

- **EC2 Instance**: t3.micro running Amazon Linux 2
- **Security Group**: HTTP access on port 5000, SSH on port 22  
- **SSH Key Pair**: For server access
- **Estimated Cost**: ~$8-12/month (FREE with AWS Free Tier)

## Prerequisites

1. **AWS CLI configured**:
   ```bash
   aws configure
   ```

2. **Terraform installed**:
   - Download from https://terraform.io
   
3. **SSH key pair** (uses `~/.ssh/id_rsa.pub`)

## Quick Deploy

```powershell
# From project root directory
.\deploy.ps1
```

## Manual Deploy

```bash
cd terraform
terraform init
terraform plan  
terraform apply
```

## Configuration

Edit `variables.tf` to change:
- `aws_region` - Default: "ap-south-1" 
- `instance_type` - Default: "t3.micro"
- `project_name` - Default: "short-url"
## Files

- `main.tf` - Infrastructure definition (EC2, security group, key pair)
- `variables.tf` - Configuration variables
- `outputs.tf` - Information displayed after deployment
- `user-data.sh` - Server bootstrap script (unused - using inline user_data)

## Outputs

After deployment, you'll see:
- `application_url` - Your app URL (http://IP:5000)
- `server_public_ip` - EC2 instance public IP
- `ssh_command` - SSH connection command
- `server_info` - Instance details

## Cleanup

Delete all resources:
```bash
terraform destroy
```

## Troubleshooting

### App not accessible
- Wait 2-3 minutes for user-data script to complete
- Check security group allows port 5000
- Verify instance is running: `terraform show`

### SSH issues
- Ensure SSH key exists: `ls ~/.ssh/id_rsa.pub`
- Use correct IP from terraform output
- Check security group allows port 22

### Check app status
```bash
# SSH to server
ssh -i ~/.ssh/id_rsa ec2-user@<ip>

# Check if app is running
ps aux | grep python
netstat -tulpn | grep 5000
```