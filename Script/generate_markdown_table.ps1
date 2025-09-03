# If it won't run, try changing the execution policy:
#   Set-ExecutionPolicy RemoteSigned -Scope Process

# Function to URL-encode spaces and brackets for Markdown
function Encode-ForMarkdown($text) {
    $text -replace ' ', '%20' -replace '\(', '%28' -replace '\)', '%29'
}

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

    # Encode for Markdown
    $encodedBaseName = Encode-ForMarkdown $baseName
    $encodedFileName = Encode-ForMarkdown $name

    # Construct paths
    $imagePath = "Component%20Images/$encodedBaseName.png"
    $filePath = "Print%20Files/$encodedFileName"

    # Add row to table
    $table += "| $baseName | ![$baseName]($imagePath) | [$name]($filePath) |"
}

# Output to Markdown file
$table | Out-File "component_table.md" -Encoding UTF8