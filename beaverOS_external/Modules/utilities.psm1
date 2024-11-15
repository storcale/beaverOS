Import-Module Microsoft.PowerShell.Management
Write-Host "Importing utilities..." -ForegroundColor Green

$commands = 'checkWeather','listWeather','locateIP','listPrints','utilities',"speedtest"

function utilities{
    [CmdletBinding()]
    param()
    process{
        Write-Host "This module contains all sorts of utility scripts from https://github.com/fleschutz/PowerShell" -ForegroundColor Yellow
        Write-Host "Use Get-Module utilites to get more information" -ForegroundColor Yellow
        Write-Host "Current commands: " -ForegroundColor Green
        foreach ($command in $commands) {
            Write-Host $command -ForegroundColor Green
        }
    }
}

function checkWeather{
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory = $True)]
        [Alias("my-location")]
        [string]$location
    )
    process {
        try {
            $Weather = curl "https://wttr.in/$location"
            Write-Host $weather.content
        } catch {
            Write-Host "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
            Write-Host "Command failed" -ForegroundColor Red
        }
    }
}

function speedtest {
  [CmdletBinding()]
  param()
process {
try {
curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -
} catch {
Write-Host "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
}
}
}


function locateIP {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory = $false)]
        [Alias("the-IPaddress")]
        [string]$IPaddress
    )
 process {
  try {
	if ($IPaddress -eq "" ) { $IPaddress = read-host "Enter IP address to locate" }

	$result = Invoke-RestMethod -Method Get -Uri "http://ip-api.com/json/$IPaddress"
	write-output $result
	
  } catch {
	Write-Host "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
  }
 }
}

function listPrints {
    [CmdletBinding()]
   param()
 process {
  function ListPrintJobs {
	$printers = Get-Printer
	if ($printers.Count -eq 0) { throw "No printer found" }

	foreach ($printer in $printers) {
		$PrinterName = $printer.Name
		$printjobs = Get-PrintJob -PrinterObject $printer
		if ($printjobs.Count -eq 0) {
			$PrintJobs = "none"
		} else {
			$PrintJobs = "$printjobs"
		}
		New-Object PSObject -Property @{ Printer=$PrinterName; Jobs=$PrintJobs }
	}
  }
 
  try {
	if ($IsLinux) {
		# TODO
	} else {
		Write-Host(  ListPrintJobs | Format-Table -property Printer,Jobs)
	}
	
  } catch {
	Write-Host "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	
  }
 }
}


Export-ModuleMember -Function checkWeather,listWeather,locateIP,listPrints,utilities,speedtest
