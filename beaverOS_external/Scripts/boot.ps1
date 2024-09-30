# Launch to manage beaverOS on the computer 

$drive = Read-Host "What is the drive letter? "
$env:beaverOS_drive = $drive + ":\"
$scriptPath = $PSScriptRoot
$module_path = Join-Path $scriptPath "..\Modules\manager.psm1"
$module_path = [System.IO.Path]::GetFullPath($module_path)
Import-Module($module_path)

welcomeGUI