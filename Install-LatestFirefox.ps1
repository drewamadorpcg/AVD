# Define the Firefox installer URL (64-bit English version)
$firefoxUrl = "https://download.mozilla.org/?product=firefox-latest&os=win64&lang=en-US"

# Define the local path to save the installer
$installerPath = "$env:TEMP\FirefoxSetup.exe"

# Download the installer
Invoke-WebRequest -Uri $firefoxUrl -OutFile $installerPath

# Install Firefox silently
Start-Process -FilePath $installerPath -ArgumentList "/silent /install" -Wait

# Optionally, remove the installer after installation
Remove-Item -Path $installerPath -Force

Write-Output "Firefox has been installed silently."
