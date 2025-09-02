# Set working directory to where your .3mf files are
$folder = "Print Files"
Set-Location $folder

# Initialize Markdown table
$table = @()
$table += "| Object Name | Image Preview | Download Link |"
$table += "|-------------|---------------|----------------|"

# Loop through each .3mf file
Get-ChildItem -Filter *.3mf -Name | ForEach-Object {
    $name = $_
    $baseName = [System.IO.Path]::GetFileNameWithoutExtension($name)

    # Encode spaces in filenames and folder names
    $encodedBaseName = $baseName -replace ' ', '%20'
    $encodedFileName = $name -replace ' ', '%20'

    $imagePath = "Component%20Images/$encodedBaseName.png"
    $filePath = "Print%20Files/$encodedFileName"

    $table += "| $baseName | ![$baseName]($imagePath) | [$name]($filePath) |"
}

# Output to Markdown file
$table | Out-File "component_table.md" -Encoding UTF8