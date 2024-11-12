# Launch to manage beaverOS on the computer 
$projectRoot = (Get-Item -Path $PSScriptRoot).Parent.FullName
$module_path = Join-Path -Path $projectRoot -ChildPath "Modules\manager.psm1"
Import-Module($module_path)
install
