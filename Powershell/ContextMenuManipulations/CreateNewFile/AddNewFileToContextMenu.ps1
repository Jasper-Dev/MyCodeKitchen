# PowerShell script to add a new entry to the "New" context menu in Windows 10

# Define the file extension and template file path
$fileExtension = ".txt"
$templateFilePath = "$env:USERPROFILE\Templates\CustomNewTextFile.txt"

# Create a template file if it doesn't exist
if (-not (Test-Path $templateFilePath)) {
    New-Item -ItemType File -Path $templateFilePath -Force
    "Template content here" | Out-File $templateFilePath
}

# Add registry entries
$classesRoot = "Registry::HKEY_CLASSES_ROOT"
$extensionKeyPath = "$classesRoot\$fileExtension"
$shellNewPath = "$extensionKeyPath\ShellNew"

# Check if the file extension is already registered
if (-not (Test-Path $extensionKeyPath)) {
    New-Item -Path $extensionKeyPath -Force
}

# Set the default icon and description for the file extension (optional)
Set-ItemProperty -Path $extensionKeyPath -Name "(Default)" -Value "Text Document"
# This sets the description. For custom files, replace "Text Document"

# Create the ShellNew key and add the FileName string value
if (-not (Test-Path $shellNewPath)) {
    New-Item -Path $shellNewPath -Force
}
Set-ItemProperty -Path $shellNewPath -Name "FileName" -Value $templateFilePath

# Output message
Write-Host "New entry for $fileExtension files has been added to the New context menu."
