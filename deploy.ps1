# Simple deployment script for students
# This makes deployment super easy!

param(
    [string]$Action = "deploy"
)

$Green = "Green"
$Yellow = "Yellow" 
$Red = "Red"
$Blue = "Cyan"

function Write-ColorOutput {
    param([string]$Message, [string]$Color = "White")
    Write-Host $Message -ForegroundColor $Color
}

function Check-Prerequisites {
    Write-ColorOutput "🔍 Checking if you have everything needed..." $Blue
    
    # Check Terraform
    if (-not (Get-Command terraform -ErrorAction SilentlyContinue)) {
        Write-ColorOutput "❌ Terraform not found!" $Red
        Write-ColorOutput "📥 Please install from: https://terraform.io/downloads" $Yellow
        return $false
    }
    Write-ColorOutput "✅ Terraform found" $Green
    
    # Check AWS credentials (CLI or environment variables)
    $awsCliExists = Get-Command aws -ErrorAction SilentlyContinue
    $envVarsExist = $env:AWS_ACCESS_KEY_ID -and $env:AWS_SECRET_ACCESS_KEY
    
    if ($awsCliExists) {
        Write-ColorOutput "✅ AWS CLI found" $Green
        try {
            $null = aws sts get-caller-identity 2>$null
            if ($LASTEXITCODE -ne 0) {
                Write-ColorOutput "❌ AWS CLI not configured!" $Red
                Write-ColorOutput "🔧 Run: aws configure" $Yellow
                Write-ColorOutput "💡 Or use: .\setup-aws-credentials.ps1" $Blue
                return $false
            }
            Write-ColorOutput "✅ AWS credentials configured via CLI" $Green
        }
        catch {
            Write-ColorOutput "❌ AWS CLI credentials problem!" $Red
            return $false
        }
    }
    elseif ($envVarsExist) {
        Write-ColorOutput "✅ AWS credentials found in environment variables" $Green
    }
    else {
        Write-ColorOutput "❌ No AWS credentials found!" $Red
        Write-ColorOutput "Choose one option:" $Yellow
        Write-ColorOutput "  1. Install AWS CLI: https://aws.amazon.com/cli/" $Blue
        Write-ColorOutput "  2. Use environment variables: .\setup-aws-credentials.ps1" $Blue
        Write-ColorOutput "  3. See TROUBLESHOOTING.md for more help" $Blue
        return $false
    }
    
    # Check SSH key
    $sshKeyPath = "$env:USERPROFILE\.ssh\id_rsa.pub"
    if (-not (Test-Path $sshKeyPath)) {
        Write-ColorOutput "⚠️  SSH key not found. Creating one for you..." $Yellow
        
        $sshDir = "$env:USERPROFILE\.ssh"
        if (-not (Test-Path $sshDir)) {
            New-Item -ItemType Directory -Path $sshDir -Force | Out-Null
        }
        
        ssh-keygen -t rsa -b 4096 -f "$env:USERPROFILE\.ssh\id_rsa" -N '""' -q
        if ($LASTEXITCODE -eq 0) {
            Write-ColorOutput "✅ SSH key created!" $Green
        } else {
            Write-ColorOutput "❌ Failed to create SSH key" $Red
            return $false
        }
    } else {
        Write-ColorOutput "✅ SSH key found" $Green
    }
    
    return $true
}

function Deploy-App {
    Write-ColorOutput "🚀 Deploying your Short URL app to AWS..." $Blue
    
    Set-Location terraform
    
    # Initialize Terraform
    Write-ColorOutput "📦 Initializing Terraform..." $Blue
    terraform init
    if ($LASTEXITCODE -ne 0) {
        Write-ColorOutput "❌ Terraform init failed!" $Red
        return
    }
    
    # Plan deployment
    Write-ColorOutput "📋 Planning deployment..." $Blue
    terraform plan
    if ($LASTEXITCODE -ne 0) {
        Write-ColorOutput "❌ Terraform plan failed!" $Red
        return
    }
    
    # Ask for confirmation
    Write-ColorOutput "🤔 Ready to deploy? This will create AWS resources. (y/N): " $Yellow -NoNewline
    $confirmation = Read-Host
    if ($confirmation -ne 'y' -and $confirmation -ne 'Y') {
        Write-ColorOutput "🛑 Deployment cancelled" $Yellow
        return
    }
    
    # Apply configuration
    Write-ColorOutput "⚡ Creating your infrastructure..." $Blue
    terraform apply -auto-approve
    
    if ($LASTEXITCODE -eq 0) {
        Write-ColorOutput "`n🎉 SUCCESS! Your app is deployed!" $Green
        Write-ColorOutput "🌐 Here's your app info:" $Blue
        
        $appUrl = terraform output -raw application_url
        $serverIp = terraform output -raw server_public_ip
        
        Write-ColorOutput "📱 Your App URL: $appUrl" $Green
        Write-ColorOutput "🖥️  Server IP: $serverIp" $Green
        Write-ColorOutput "`n⏱️  Wait 2-3 minutes for setup to complete, then visit your URL!" $Yellow
    } else {
        Write-ColorOutput "❌ Deployment failed!" $Red
    }
}

function Test-App {
    Write-ColorOutput "🧪 Testing your deployed app..." $Blue
    
    Set-Location terraform
    
    try {
        $appUrl = terraform output -raw application_url
        Write-ColorOutput "🌐 Testing: $appUrl" $Blue
        
        $response = Invoke-WebRequest -Uri "$appUrl" -TimeoutSec 10 -ErrorAction Stop
        if ($response.StatusCode -eq 200) {
            Write-ColorOutput "✅ App is running!" $Green
            Write-ColorOutput "🎯 Visit: $appUrl" $Green
        }
    }
    catch {
        Write-ColorOutput "⚠️  App might still be starting up..." $Yellow
        Write-ColorOutput "🕐 Wait a few more minutes and try visiting the URL" $Yellow
    }
}

function Remove-App {
    Write-ColorOutput "🗑️  This will DELETE all your AWS resources!" $Red
    Write-ColorOutput "⚠️  Are you sure? Type 'DELETE' to confirm: " $Yellow -NoNewline
    $confirmation = Read-Host
    
    if ($confirmation -ne 'DELETE') {
        Write-ColorOutput "🛑 Cancelled - nothing deleted" $Yellow
        return
    }
    
    Set-Location terraform
    Write-ColorOutput "💥 Destroying infrastructure..." $Blue
    terraform destroy -auto-approve
    
    if ($LASTEXITCODE -eq 0) {
        Write-ColorOutput "✅ Everything deleted successfully!" $Green
        Write-ColorOutput "💰 No more AWS charges!" $Green
    } else {
        Write-ColorOutput "❌ Failed to delete some resources" $Red
        Write-ColorOutput "🔧 Check AWS console and delete manually" $Yellow
    }
}

# Main script
Write-ColorOutput "🔗 Short URL - AWS Deployment Helper" $Blue
Write-ColorOutput "======================================" $Blue

switch ($Action.ToLower()) {
    "deploy" {
        if (Check-Prerequisites) {
            Deploy-App
        }
    }
    "test" {
        Test-App
    }
    "destroy" {
        Remove-App
    }
    default {
        Write-ColorOutput "Usage:" $Yellow
        Write-ColorOutput "  .\deploy.ps1 deploy   - Deploy your app to AWS" $Green
        Write-ColorOutput "  .\deploy.ps1 test     - Test if your app is working" $Blue
        Write-ColorOutput "  .\deploy.ps1 destroy  - Delete everything from AWS" $Red
    }
}