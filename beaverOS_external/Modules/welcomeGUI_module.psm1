Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
$module = Get-ChildItem -Path 'C:\Users\' -Recurse -ErrorAction SilentlyContinue | Where-Object { $_.FullName -match '\\beaverOS_external\\Modules\\.*updater.psm1$' } | Select-Object -ExpandProperty FullName
Import-Module -Name $module -Force

function uninstall(){
    $old_profile_file = Get-ChildItem -Path 'C:\Users\' -Recurse -ErrorAction SilentlyContinue| Where-Object { $_.FullName -match '\\beaverOS_external\\Data\\.*old_profile.txt$' } | Select-Object -ExpandProperty FullName

    Copy-Item $old_profile_file -Destination $PROFILE
    Write-Host "Sucessfully removed beaverOS_external and mounted previous profile." -ForegroundColor Green
}
function install(){
 Write-Host "Importing beaverOS.. " -ForegroundColor Blue 
 Write-Host "Current profile path: " .. $PROFILE -ForegroundColor Blue
 $profile_file = Get-ChildItem -Path 'C:\Users\' -Recurse -ErrorAction SilentlyContinue | Where-Object { $_.FullName -match '\\beaverOS_external\\Scripts\\.*beaverOS_profile.ps1$' } | Select-Object -ExpandProperty FullName

 $old_profile_file = Get-ChildItem -Path 'C:\Users\' -Recurse -ErrorAction SilentlyContinue | Where-Object { $_.FullName -match '\\beaverOS_external\\Data\\.*old_profile.txt$' } | Select-Object -ExpandProperty FullName
 # Backup profile
 $old_profile_content = Get-Content -Path $PROFILE
 Clear-Content -Path $old_profile_file
 Add-Content -Path $old_profile_file -Value $old_profile_content

 # Ovverride profile
 Copy-Item $profile_file -destination $PROFILE

 Write-Host "Imported beaverOS. Open new powershell window to start." -ForegroundColor Green 
 Write-Host "To reset profile launch reset.ps1 " -ForegroundColor Yellow
 Write-Host "Current profile path: " .. $PROFILE -ForegroundColor Blue

}

function welcomeGUI {

    # Create new form
    $form = New-Object System.Windows.Forms.Form
    $form.Text = 'beaverOS_external Manager'
    $form.Size = New-Object System.Drawing.size(500,300)
    $form.StartPosition = 'CenterScreen'
    

    # Title
    $title_label = New-Object System.Windows.Forms.Label
    $title_label.Location = New-Object System.Drawing.Point(150,10)
    $title_label.Size = New-Object System.Drawing.Size(250,20)
    $title_label.Font =  New-Object System.Drawing.Font("Calibri Light",15)
    $title_label.Text = 'Please select an action:'
    $form.Controls.Add($title_label)
    
    # Install button
    $InstallButton = New-Object System.Windows.Forms.Button
    $InstallButton.Location = New-Object System.Drawing.Point(20,50)
    $InstallButton.Size = New-Object System.Drawing.Size(100,50)
    $InstallButton.Text = 'Install'
    $InstallButton.BackColor = "green"
    $InstallButton.Add_Click{
        install
    }
    $form.AcceptButton = $InstallButton
    $form.Controls.Add($InstallButton)

    # Uninstall button
    $DeleteButton = New-Object System.Windows.Forms.Button
    $DeleteButton.Location = New-Object System.Drawing.Point(20,110)
    $DeleteButton.Size = New-Object System.Drawing.Size(100,50)
    $DeleteButton.Text = 'Uninstall'
    $DeleteButton.BackColor = "red"
    $form.AcceptButton = $DeleteButton
    $form.Controls.Add($DeleteButton)
    $DeleteButton.Add_Click{
        uninstall
    }

    # Update button
    $UpdateButton = New-Object System.Windows.Forms.Button
    $UpdateButton.Location = New-Object System.Drawing.Point(20,170)
    $UpdateButton.Size = New-Object System.Drawing.Size(100,50)
    $UpdateButton.Text = 'Update'
    $UpdateButton.BackColor = "gray"
    $form.AcceptButton = $UpdateButton
    $form.Controls.Add($UpdateButton)
    $UpdateButton.Add_Click{
        update
    }

    $form.ShowDialog()
}

Export-ModuleMember -Function welcomeGUI
