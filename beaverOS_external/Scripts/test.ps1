Add-Type -AssemblyName System.Windows.Forms
 
$progressForm = New-Object System.Windows.Forms.Form
$progressForm.Width = 300
$progressForm.Height = 150
$progressForm.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle
$progressForm.Text = "Processing data..."
 
$progressBar = New-Object System.Windows.Forms.ProgressBar
$progressBar.Location = New-Object System.Drawing.Point(10, 50)
$progressBar.Size = New-Object System.Drawing.Size(280, 20)
$progressForm.Controls.Add($progressBar)
 
$progressLabel = New-Object System.Windows.Forms.Label
$progressLabel.Location = New-Object System.Drawing.Point(10, 20)
$progressLabel.Size = New-Object System.Drawing.Size(280, 20)
$progressLabel.Text = "0% Complete"
$progressLabel.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
$progressForm.Controls.Add($progressLabel)
 
$progressForm.Show()
 
$data = 1..100
$index = 1
# Loop through the data and update the progress bar
foreach ($item in $data) {
    # Perform some operation on $item
 
    # Update the progress bar
    $progressPercent = ($index / $data.Count) * 100
    $progressBar.Value = $progressPercent
    $progressLabel.Text = "$progressPercent% Complete"
    Start-Sleep -Milliseconds 100
    $index++
}
 
$progressForm.Close()