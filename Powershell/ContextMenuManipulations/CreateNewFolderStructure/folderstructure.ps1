# Define the root path for the new folder structure
# By default, this script creates the new structure in the directory it's run from
$rootPath = Get-Location

# Define the folder structure
$folders = @('Documents', 'Images', 'Notes')

# Create the folders
foreach ($folder in $folders) {
    $path = Join-Path -Path $rootPath -ChildPath $folder
    New-Item -ItemType Directory -Path $path -Force
}

Write-Host "Folder structure created successfully at $rootPath"
