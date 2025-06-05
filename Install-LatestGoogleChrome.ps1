# Define the URL for the latest Chrome MSI (64-bit)
$chromeInstallerUrl = "https://dl.google.com/chrome/install/latest/chrome_installer.exe"

# Define the local path to save the installer
$installerPath = "$env:TEMP\chrome_installer.exe"

# Download the installer
Invoke-WebRequest -Uri $chromeInstallerUrl -OutFile $installerPath

# Silently install Chrome
Start-Process -FilePath $installerPath -ArgumentList "/silent /install" -Wait

# Remove installer after installation
Remove-Item -Path $installerPath -Force

Write-Host "Google Chrome installed successfully."
