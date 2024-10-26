Import-Module Microsoft.PowerShell.Management
Write-Host "Importing utilities..." -ForegroundColor Green

$commands = 'checkWeather','listWeather','locateIP','listPrints','utilities'

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
        [Parameter(Position = 0, Mandatory = $false)]
        [Alias("my-location")]
        [string]$location
    )
    process {
        try {
            curl 'wttr.in/longford'
        } catch {
            Write-Host "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
            Write-Host "Command failed" -ForegroundColor Red
        }
    }
}

function listWeather{
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory = $false)]
        [Alias("my-location")]
        [string]$location
    )

 process {
    function GetDescription { param([string]$text)
        switch ($text.trim()) {
        "Blizzard"			{ return "❄️ blizzard ⚠️" }
        "Blowing snow"			{ return "❄️ blowing snow ⚠️" }
        "Clear"				{ return "🌙 clear" }
        "Cloudy"			{ return "☁️ cloudy" }
        "Fog"				{ return "🌫  fog" }
        "Freezing fog"			{ return "🌫  freezing fog" }
        "Heavy snow"			{ return "❄️ heavy snow ⚠️" }
        "Light drizzle"			{ return "💧 light drizzle" }
        "Light freezing rain"		{ return "💧 light freezing rain ⚠️" }
        "Light rain"			{ return "💧 light rain" }
        "Light rain shower"		{ return "💧 light rain shower" }
        "Light sleet"			{ return "❄️ light sleet" }
        "Light sleet showers"		{ return "❄️ light sleet showers" }
        "Light snow"			{ return "❄️ light snow" }
        "Light snow showers"		{ return "❄️ light snow showers" }
        "Moderate or heavy freezing rain"{return "💧 moderate or heavy freezing rain ⚠️" }
        "Moderate or heavy sleet"	{ return "❄️ moderate or heavy sleet ⚠️" }
        "Moderate or heavy rain shower" { return "💧 moderate or heavy rain shower ⚠️" }
        "Moderate or heavy snow showers"{ return "❄️ moderate or heavy snow showers ⚠️" }
        "Moderate or heavy snow in area with thunder" { return "❄️ moderate or heavy snow with thunder ⚠️" }
        "Moderate rain"			{ return "💧 moderate rain" }
        "Moderate rain at times"	{ return "💧 moderate rain at times" }
        "Moderate snow"			{ return "❄️ moderate snow" }
        "Mist"				{ return "🌫  misty" }
        "Overcast"			{ return "☁️ overcast" }
        "Partly cloudy"			{ return "⛅️partly cloudy" }
        "Patchy heavy snow"		{ return "❄️ patchy heavy snow ⚠️" }
        "Patchy light drizzle"     	{ return "💧 patchy light drizzle" }
        "Patchy light rain"     	{ return "💧 patchy light rain" }
        "Patchy light rain with thunder" { return "💧 patchy light rain with thunder" }
        "Patchy light snow"		{ return "❄️ patchy light snow" }
        "Patchy moderate snow"		{ return "❄️ patchy moderate snow" }
        "Patchy rain possible"  	{ return "💧 patchy rain possible" }
        "Patchy rain nearby"		{ return "💧 patchy rain nearby" }
        "Patchy sleet nearby"		{ return "❄️ patchy sleet nearby" }
        "Patchy snow possible"  	{ return "❄️ patchy snow possible" }
        "Sunny"				{ return "☀️ sunny" }
        "Thundery outbreaks possible"	{ return "⚡️thundery outbreaks possible" }
        default				{ return "$Text" }
        }
    }
    
    function GetWindDir { param([string]$Text)
        switch($Text) {
        "NW"	{ return "↘" }
        "NNW"	{ return "↓" }
        "N"	{ return "↓" }
        "NNE"	{ return "↓" }
        "NE"	{ return "↙" }
        "ENE"	{ return "←" }
        "E"	{ return "←" }
        "ESE"	{ return "←" }
        "SE"	{ return "↖" }
        "SSE"	{ return "↑" }
        "S"	{ return "↑" }
        "SSW"	{ return "↑" }
        "SW"	{ return "↗" }
        "WSW"	{ return "→" }
        "W"	{ return "→" }
        "WNW"	{ return "→" }
        default { return "$Text" }
        }
    }
  try {
	Write-Progress "Loading weather data from http://wttr.in ..."
	$Weather = (Invoke-WebRequest -URI http://wttr.in/${Location}?format=j1 -userAgent "curl" -useBasicParsing).Content | ConvertFrom-Json
	Write-Progress -completed "."
	$Area = $Weather.nearest_area.areaName.value
	$Region = $Weather.nearest_area.region.value
	$Country = $Weather.nearest_area.country.value	
	[int]$Day = 0
	foreach($Hourly in $Weather.weather.hourly) {
		$Hour = $Hourly.time / 100
		$Temp = $(($Hourly.tempC.toString()).PadLeft(3))
		$Precip = $Hourly.precipMM
		$Humidity = $(($Hourly.humidity.toString()).PadLeft(3))
		$Pressure = $Hourly.pressure
		$WindSpeed = $(($Hourly.windspeedKmph.toString()).PadLeft(2))
		$WindDir = GetWindDir $Hourly.winddir16Point
		$UV = $Hourly.uvIndex
		$Clouds = $(($Hourly.cloudcover.toString()).PadLeft(3))
		$Visib = $(($Hourly.visibility.toString()).PadLeft(2))
		$Desc = GetDescription $Hourly.weatherDesc.value
		if ($Hour -eq 0) {
			if ($Day -eq 0) {
				Write-Host -foregroundColor green "TODAY   🌡°C  ☂️mm  💧  💨km/h  ☀️UV  ☁️   👁km   at $Area ($Region, $Country)"
			} elseif ($Day -eq 1) {
				$Date = (Get-Date).AddDays(1)
				[string]$Weekday = $Date.DayOfWeek
				Write-Host -foregroundColor green "$($Weekday.toUpper())"
			} else {
				$Date = (Get-Date).AddDays(2)
				[string]$Weekday = $Date.DayOfWeek
				Write-Host -foregroundColor green "$($Weekday.toUpper())"
			}
			$Day++
		}
		Write-Host  "$(($Hour.toString()).PadLeft(2))°°  $Temp°   $Precip  $Humidity%   $($WindDir)$WindSpeed    $UV   $Clouds%   $Visib   $Desc"
	}
  } catch {
	Write-Host  "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
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


Export-ModuleMember -Function checkWeather,listWeather,locateIP,listPrints,utilities