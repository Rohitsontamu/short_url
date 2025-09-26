# Upload your actual project code to the running EC2 instance
# This replaces the basic app with your real app

param(
    [string]$ServerIP = "13.201.27.70"
)

$Green = "Green"
$Yellow = "Yellow"
$Blue = "Cyan"

function Write-ColorOutput {
    param([string]$Message, [string]$Color = "White")
    Write-Host $Message -ForegroundColor $Color
}

Write-ColorOutput "🚀 Uploading your real project code to EC2..." $Blue

# Create a temporary directory with your project files
$tempDir = "temp-upload"
if (Test-Path $tempDir) { Remove-Item $tempDir -Recurse -Force }
New-Item -ItemType Directory -Path $tempDir | Out-Null

# Copy your project files
Write-ColorOutput "📦 Preparing project files..." $Blue
Copy-Item "main.py" "$tempDir/" -Force
Copy-Item "handlers" "$tempDir/" -Recurse -Force
Copy-Item "web" "$tempDir/" -Recurse -Force
Copy-Item "middlewares" "$tempDir/" -Recurse -Force
Copy-Item "requirements.txt" "$tempDir/" -Force

# Create a simple app.py that matches your project structure
@"
from handlers.routes import app
import os

# Export application for the service
application = app

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(host="0.0.0.0", port=port, debug=False)
"@ | Out-File -FilePath "$tempDir/app.py" -Encoding utf8

Write-ColorOutput "📤 Uploading files to server..." $Blue

# Upload files using SCP
$scpCommands = @(
    "scp -i ~/.ssh/id_rsa -r $tempDir/* ec2-user@${ServerIP}:/home/ec2-user/short-url/",
    "ssh -i ~/.ssh/id_rsa ec2-user@$ServerIP 'cd /home/ec2-user/short-url && pip3 install -r requirements.txt'",
    "ssh -i ~/.ssh/id_rsa ec2-user@$ServerIP 'sudo systemctl restart short-url'"
)

foreach ($cmd in $scpCommands) {
    Write-ColorOutput "⚡ Running: $cmd" $Yellow
    Invoke-Expression $cmd
    if ($LASTEXITCODE -ne 0) {
        Write-ColorOutput "❌ Command failed: $cmd" "Red"
        break
    }
}

# Clean up
Remove-Item $tempDir -Recurse -Force

Write-ColorOutput "✅ Upload complete! Your real UI should now be live!" $Green
Write-ColorOutput "🌐 Visit: http://$ServerIP:5000" $Green