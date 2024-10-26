
Add-Type -AssemblyName System.Windows.Forms

$taskNumber = 3
function finishTask{
    $taskDone += 1
    $progressBar.Value = ($taskDone / $taskNumber ) * 100
    $progressPercent = ($taskDone / $taskNumber) * 100
    $progressLabel.Text = "$progressPercent% of Update complete"
}
function update(){
 $progressForm = New-Object System.Windows.Forms.Form
 $progressForm.Width = 300
 $progressForm.Height = 150
 $progressForm.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle
 $progressForm.Text = "Updating beaverOS..."
 
 $progressBar = New-Object System.Windows.Forms.ProgressBar
 $progressBar.Location = New-Object System.Drawing.Point(10, 50)
 $progressBar.Size = New-Object System.Drawing.Size(280, 20)
 $progressForm.Controls.Add($progressBar)
 
 $progressLabel = New-Object System.Windows.Forms.Label
 $progressLabel.Location = New-Object System.Drawing.Point(10, 20)
 $progressLabel.Size = New-Object System.Drawing.Size(280, 20)
 $progressLabel.Text = "Update 0% Complete"
 $progressLabel.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
 $progressForm.Controls.Add($progressLabel)
 

 $progressForm.Show()

 Write-Host "Starting update..."

 # Total number of tasks
 
 
 
  $progressBar.Value = 5
  $progressLabel.Text = "5% of Update complete"


 # Get latest update 
 $response = Invoke-WebRequest -Uri "https://script.google.com/macros/s/AKfycbxy9HrmwZLTrTOp1-ZPVj66Bx6X7is0YIJzp_tmj1yoJAP-C921csYBZyr3OXW_AyY/exec?query=update"
 $update_code = $response.Content
 Write-Host "Latest update content fetched"
 finishTask

 # Backup file
 Write-Host "Saving backup..."

 $projectRoot = (Get-Item -Path $PSScriptRoot).Parent.FullName
 $module_path = Join-Path -Path $projectRoot -ChildPath "Modules\beaverOS_external.psm1"
 
 $backup_file = Join-Path -Path $projectRoot -ChildPath "Data\backup.txt"
 $content = Get-Content $module_path
 Clear-Content -Path $backup_file
 Add-Content -Path $backup_file -Value $content
 finishTask

 # Push update
 Write-Host "Pushing update to file..."
 Clear-Content $module_path
 Add-Content -Path $module_path -Value $update_code
 finishTask

  Write-Host "Sucessfully updated beaverOS_external!" -ForegroundColor Green
  



 # Close the loading GUI
 $progressForm.Close()
}

Export-ModuleMember -Function update