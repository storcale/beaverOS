Import-Module Microsoft.PowerShell.Management

# Password input UI
function InputBox([string]$profile_type){
    Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
$form = New-Object System.Windows.Forms.Form
$form.Text = 'beaverOS_external login'
$form.Size = New-Object System.Drawing.Size(300,200)
$form.StartPosition = 'CenterScreen'

$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(75,120)
$okButton.Size = New-Object System.Drawing.Size(75,23)
$okButton.Text = 'OK'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(150,120)
$cancelButton.Size = New-Object System.Drawing.Size(75,23)
$cancelButton.Text = 'Cancel'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20)
$label.Size = New-Object System.Drawing.Size(280,20)
if ($profile_type -ne "guest"){
 $label.Text = 'Enter the password:'
}else{
 $label.Text = 'Enter your full name.'
}
$form.Controls.Add($label)

if($profile_type -ne "guest"){
$passwordBox = New-Object Windows.Forms.MaskedTextBox
$passwordBox.PasswordChar = '*'
$passwordBox.Location = New-Object System.Drawing.Point(10,40)
$passwordBox.Size = New-Object System.Drawing.Size(260,20)
$form.Controls.Add($passwordBox)
}else{
 $inputBox = New-Object Windows.Forms.TextBox
$inputBox.Location = New-Object System.Drawing.Point(10,40)
$inputBox.Size = New-Object System.Drawing.Size(260,20)
$form.Controls.Add($inputBox)
}

$form.Topmost = $true

$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $passwordInput = $passwordBox.Text
    $passwordInput
}
}


# boot cmd ;)
function boot {
    [CmdletBinding()]
   param()
   process {
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    $admin = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    if($admin -eq $true){
    taskkill /F /IM WpcMon.exe | Out-Null
    }elseif( $admin -eq $false){
        start-process powershell -Verb RunAs -ArgumentList '-noexit -command "taskkill /F /IM WpcMon.exe | Out-Null"'
    }
}
}


# Login cmd
function login {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $true)]
        [Alias("profile")]
        [string]$permInput
    )

    process {
      switch ($permInput) {
        "user"{
         Write-Host "BOS - logging in as common user.." -ForegroundColor Blue
         InputBox($permInput)
        }
        "dev"{
            Write-Host "BOS - logging in as developer.." -ForegroundColor Blue
            InputBox($permInput)   
        }
        "guest"{
            Write-Host "BOS - logging in as guest.." -ForegroundColor Blue
            InputBox($permInput)
        }
        Default {
            Write-Host "BOS - Could not find a profile named like that. Error - beaverOS login" -ForegroundColor red 
        }
      }
    }
}
function gitLogin {
    [CmdletBinding()]
    param()
    process {
        $password_secure = Read-Host "Enter Password" -AsSecureString
        $bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password_secure);  
        

        Start-Process "https://github.com/login"
        Start-Sleep -Seconds 1

        function Send-Keys {
            param (
                 [string]$keys
             )

         Add-Type -AssemblyName System.Windows.Forms
        [System.Windows.Forms.SendKeys]::SendWait($keys)
    }
    Send-keys "Storcale{TAB}"
    $password = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)
    Send-Keys "$password{TAB}{TAB}{ENTER}"
    }
}

Export-ModuleMember -Function login,gitLogin
