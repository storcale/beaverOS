$projectRoot = (Get-Item -Path $PSScriptRoot).Parent.FullName
$module_path = Join-Path -Path $projectRoot -ChildPath "Modules\beaverOS_external.psm1"
Import-Module -Force $module_path
$utilities_path = Join-Path -Path $projectRoot -ChildPath "Modules\utilities.psm1"
Import-Module -Force $utilities_path

Write-Host @"
 ________  _______   ________  ___      ___ _______   ________          ________  ________      
|\   __  \|\  ___ \ |\   __  \|\  \    /  /|\  ___ \ |\   __  \        |\   __  \|\   ____\     
\ \  \|\ /\ \   __/|\ \  \|\  \ \  \  /  / | \   __/|\ \  \|\  \       \ \  \|\  \ \  \___|_    
 \ \   __  \ \  \_|/_\ \   __  \ \  \/  / / \ \  \_|/_\ \   _  _\       \ \  \\\  \ \_____  \   
  \ \  \|\  \ \  \_|\ \ \  \ \  \ \    / /   \ \  \_|\ \ \  \\  \|       \ \  \\\  \|____|\  \  
   \ \_______\ \_______\ \__\ \__\ \__/ /     \ \_______\ \__\\ _\        \ \_______\____\_\  \ 
    \|_______|\|_______|\|__|\|__|\|__|/       \|_______|\|__|\|__|        \|_______|\_________\
                                                                                    \|_________|
                                                                                                
"@ -ForegroundColor Yellow

Write-Host("Welcome to Powershell! BeaverOS_external installed") -ForegroundColor Green


