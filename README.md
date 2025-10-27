# Short URL - Simple URL Shortener

A minimal Flask web app that turns long URLs into short ones.  
Built for simplicity and easy AWS deployment using Terraform.

---

## What it does

This app takes a long URL and creates a short version.  
When someone clicks the short link, it redirects them to the original URL.

**Live Demo**: Currently deployed on AWS EC2 at `http://13.127.196.78:5000`

---

## Features

- ✅ Simple URL shortening with just one input box
- ✅ In-memory storage (no database setup needed)
- ✅ Automatic redirect to original URLs
- ✅ One-command AWS deployment with Terraform
- ✅ Minimal resource usage (perfect for t3.micro free tier)

---

## What I learned building this

- **Flask web development**: Simple Python web apps
- **AWS EC2 deployment**: Running apps in the cloud
- **Infrastructure as Code**: Using Terraform for AWS resources
- **User-data scripting**: Automated server setup
- **Security groups**: AWS firewall configuration

---

## Quick Start

### 🚀 AWS Deployment (Recommended)

Deploy to AWS EC2 in one command:

```powershell
# Load AWS credentials and deploy
.\deploy.ps1
```

**What you get:**

- Single EC2 instance (**t3.micro** - free tier eligible)
- Security group with HTTP access on port **5000**
- SSH access for troubleshooting
- Estimated cost: ~$8–12/month (**free with AWS free tier**)

**Prerequisites:**

- AWS CLI configured (`aws configure`)
- Terraform installed
- Your AWS credentials in `.env` file

---

### 💻 Local Development

1. **Get the code:**
    ```bash
    git clone <your-repo-url>
    cd short_url
    ```

2. **Install Flask:**
    ```bash
    pip install Flask
    ```

3. **Run the minimal app:**
    ```bash
    # Copy the simple app from terraform/main.tf user_data section
    python app.py
    ```

4. **Open your browser:** Go to [http://localhost:5000](http://localhost:5000)

---

## How to use it

1. **Visit the app** in your browser (locally or deployed)
2. **Enter a URL** in the input box
3. **Click "Shorten"** to get your short URL
4. **Use the short URL** — it redirects to your original

---

## How it works

When you submit a URL:

1. Generates a random 4-character code  
2. Stores the mapping in memory (dictionary)  
3. Returns a short URL using that code  
4. Redirects to the original when accessed

---

## Project structure

```
short_url/
├── terraform/            # AWS infrastructure
│   ├── main.tf           # Terraform configuration
│   ├── variables.tf      # Input variables
│   └── outputs.tf        # Output values
├── .env                  # AWS credentials (not in git)
├── deploy.ps1            # One-command deployment script
├── main.py               # Original Flask app (not used in deployment)
├── handlers/             # Original code structure (not used in deployment)
├── web/                  # Original templates (not used in deployment)
└── README.md             # This file
```

**Note:**  
The deployed version uses a **minimal inline Flask app** in Terraform `user_data` for simplicity.

---

## Troubleshooting

### App not accessible

- Check security group allows port **5000**
- Verify EC2 instance is running: `terraform show`
- SSH into instance and check logs

### Deployment fails

```powershell
# Check AWS credentials
aws sts get-caller-identity

# Check Terraform state
cd terraform
terraform plan

# Destroy and recreate
terraform destroy -auto-approve
terraform apply -auto-approve
```

### SSH into the server

```bash
# Use SSH command from terraform output
ssh -i ~/.ssh/id_rsa ec2-user@<your-server-ip>

# Check if app is running
ps aux | grep python
netstat -tulpn | grep 5000
```

---

## Technical Details

- **Runtime:** Python 3 with Flask
- **Storage:** In-memory dictionary (resets on restart)
- **Server:** Single EC2 t3.micro instance
- **Security:** AWS Security Group (HTTP:5000, SSH:22)
- **Region:** ap-south-1 (Mumbai)

---

## What I'd add next

- Database persistence (SQLite or RDS)
- Custom short codes
- Click analytics
- URL expiration
- Rate limiting
- Better UI styling

---

## Contributing

Found a bug or want to add a feature?

1. Fork this repo  
2. Make your changes  
3. Test that it still works  
4. Send a pull request

---

## License

MIT License — you can use and modify freely.
