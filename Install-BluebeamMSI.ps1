# Set variables
$downloadUrl = "https://bluebeam.com/MSIdeployx64"
$extractPath = "C:\temp\Bluebeam"
$zipPath = Join-Path $extractPath "bluebeam.zip"

# Ensure the directory exists
if (!(Test-Path -Path $extractPath)) {
    New-Item -ItemType Directory -Path $extractPath -Force | Out-Null
}

# Download the ZIP file
Write-Output "Downloading Bluebeam deployment ZIP..."
Invoke-WebRequest -Uri $downloadUrl -OutFile $zipPath

# Extract the ZIP file
Write-Output "Extracting ZIP to $extractPath..."
Expand-Archive -Path $zipPath -DestinationPath $extractPath -Force

# Define full paths to the MSI files
$ocrMsi = Join-Path $extractPath "BluebeamOCR x64 21.msi"
$mainMsi = Join-Path $extractPath "Bluebeam Revu x64 21.msi"

# Install the OCR MSI
if (Test-Path $ocrMsi) {
    Write-Output "Installing Bluebeam OCR..."
    Start-Process msiexec.exe -ArgumentList "/i `"$ocrMsi`" /qn /norestart" -Wait
} else {
    Write-Warning "OCR MSI not found at $ocrMsi"
}

# Install Bluebeam Revu MSI
if (Test-Path $mainMsi) {
    Write-Output "Installing Bluebeam Revu..."
    Start-Process msiexec.exe -ArgumentList "/i `"$mainMsi`" IGNORE_RBT=1 DISABLE_WELCOME=1 /qn /norestart" -Wait
} else {
    Write-Warning "Bluebeam Revu MSI not found at $mainMsi"
}

# Optional: Remove the zip file
#Remove-Item -Path $zipPath -Force
