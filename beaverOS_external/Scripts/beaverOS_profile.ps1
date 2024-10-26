$projectRoot = (Get-Item -Path $PSScriptRoot).Parent.FullName
$module_path = Join-Path -Path $projectRoot -ChildPath "Modules\beaverOS_external.psm1"
Import-Module($module_path)
$utilities_path = Join-Path -Path $projectRoot -ChildPath "Modules\utilities.psm1"
Import-Module($utilities_path)
Write-Host("Welcome to Powershell! BeaverOS_external installed") -ForegroundColor Green


