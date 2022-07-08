#3.0 - added multithreaded forms to support responsive progress bars
#3.0 - finished Local and Remote Put
#3.1 - All features fully implemented
#3.2 - Bug fixes, added logo

#######START MAIN FORM#######
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'Put/Get'
$form.Size = New-Object System.Drawing.Size(300,200)
$form.StartPosition = 'CenterScreen'

$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Point(75,120)
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = 'Run'
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $OKButton
$form.Controls.Add($OKButton)

$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Point(150,120)
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = 'Abort'
$CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $CancelButton
$form.Controls.Add($CancelButton)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Select put/get type:'
$form.Controls.Add($label)

$listBox = New-Object System.Windows.Forms.Listbox
$listBox.Location = New-Object System.Drawing.Point(10,40)
$listBox.Size = New-Object System.Drawing.Size(260,20)

$listBox.SelectionMode = 'MultiExtended'

[void] $listBox.Items.Add('Local Put')
[void] $listBox.Items.Add('Local Get')
[void] $listBox.Items.Add('Remote Put')
[void] $listBox.Items.Add('Remote Get')
[void] $listBox.Items.Add('Remote Get w/ Delete')


$listBox.Height = 70
$form.Controls.Add($listBox)
$form.Topmost = $true

#icon
$iconBase64 = '/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAYEBAUEBAYFBQUGBgYHCQ4JCQgICRINDQoOFRIWFhUSFBQXGiEcFxgfGRQUHScdHyIjJSUlFhwpLCgkKyEkJST/2wBDAQYGBgkICREJCREkGBQYJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCT/wAARCAAgACADAREAAhEBAxEB/8QAGQABAAIDAAAAAAAAAAAAAAAACAEGAAUH/8QAMBAAAQMDAwEGAwkAAAAAAAAAAQIDBAAFBgcRMRIUFxghQZRU0dITIjJRVVZhcZH/xAAaAQACAwEBAAAAAAAAAAAAAAAFBwAEBgED/8QAKREAAQQBAgQGAwEAAAAAAAAAAQACAwQFETEVIZGhEhYyQVFSU9Hwgf/aAAwDAQACEQMRAD8A6Tk0t6345dZcZfQ+xEedbVtv0qCCQf8ARSKpxtksRsdsSB3WymcWxuI+ETO/nUT9fV7dr6aa/lnG/i7n9rNcRsfZR386h/uBXt2vpqeWcb+Luf2pxGx9kndLrzOyHArPdLk/9vMkNFTrnSE9R6iOB5elLPNV4692SKIaNB5dFoacjnwtc7dWlSUrSULSFJUNiCNwRQwHTmFYVI1KyPH9PcbduT9tgOSl7txWCynd1zb+uByaN4epZyFgRNcdPc6nkFTtyxwM8RA19katPsLuOrGZOF8lMYudonyEp2CEk/hHoCeAPlTHyuRixVQeHfZo/u6A1oHWZOf+piW23RbRAj2+CyliNHQG220jySkUoZpXyvMkh1J3WpYwMaGt2Ci6XOJZrdJuM55LMWM2XXVq4SkVIYXzSCKMak8guPeGNLnbBDjPMyn6q5klzrSzHU4GIbTrgShlBPKifIE8k/KnBjMfHi6mm53JG5P9sstYndZk16JI6eM4Xp/jjFqi5BZ1vH78l/tTe7zh5PPHoB+VLnLOvX7BmfE7T2Gh5BHqohgZ4Q4dVe4suPOjokxX2pDDg3Q40oKSofwR5Ggb2OY4teNCFda4OGoWh1EskzI8JvFpt6ULly45baStXSCdxyfSr2Jssr3I5pPSDzXhajMkTmN3KNXhx1A+Cg+7TTH82477HoUA4ZY+O6zw46gfBQfdpqebcd9j0KnDLHx3SS00sM3GMGtNouKEIlxWihxKFBQB6ieRzzS6zFmOzckmi9JPLoj1SN0cTWO3C//Z'
$iconBytes = [Convert]::FromBase64String($iconBase64)
$stream = [System.IO.MemoryStream]::new($iconBytes, 0, $iconBytes.Length)
$form.Icon = [System.Drawing.Icon]::FromHandle(([System.Drawing.Bitmap]::new($stream).GetHIcon()))

$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $x = $listBox.SelectedItems
    $form.Close()
}
else
{
    return
}




$stream.Dispose()
$form.Dispose()
#######END MAIN FORM#######

###START PUTGET###

##Local Put##
if ($x -eq "Local Put")
{
    ###START USERNAME FORM###
    $form = New-Object System.Windows.Forms.Form
    $form.Text = 'Local Put'
    $form.Size = New-Object System.Drawing.Size(300,200)
    $form.StartPosition = 'CenterScreen'

    $okButton = New-Object System.Windows.Forms.Button
    $okButton.Location = New-Object System.Drawing.Point(75,120)
    $okButton.Size = New-Object System.Drawing.Size(75,23)
    $okButton.Text = 'Enter'
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
    $label.Text = 'Enter Z or E ID:'
    $form.Controls.Add($label)

    $textBox = New-Object System.Windows.Forms.TextBox
    $textBox.Location = New-Object System.Drawing.Point(10,40)
    $textBox.Size = New-Object System.Drawing.Size(260,20)
    $form.Controls.Add($textBox)

    $form.Topmost = $true

    #icon
    $iconBase64 = '/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAYEBAUEBAYFBQUGBgYHCQ4JCQgICRINDQoOFRIWFhUSFBQXGiEcFxgfGRQUHScdHyIjJSUlFhwpLCgkKyEkJST/2wBDAQYGBgkICREJCREkGBQYJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCT/wAARCAAgACADAREAAhEBAxEB/8QAGQABAAIDAAAAAAAAAAAAAAAACAEGAAUH/8QAMBAAAQMDAwEGAwkAAAAAAAAAAQIDBAAFBgcRMRIUFxghQZRU0dITIjJRVVZhcZH/xAAaAQACAwEBAAAAAAAAAAAAAAAFBwAEBgED/8QAKREAAQQBAgQGAwEAAAAAAAAAAQACAwQFETEVIZGhEhYyQVFSU9Hwgf/aAAwDAQACEQMRAD8A6Tk0t6345dZcZfQ+xEedbVtv0qCCQf8ARSKpxtksRsdsSB3WymcWxuI+ETO/nUT9fV7dr6aa/lnG/i7n9rNcRsfZR386h/uBXt2vpqeWcb+Luf2pxGx9kndLrzOyHArPdLk/9vMkNFTrnSE9R6iOB5elLPNV4692SKIaNB5dFoacjnwtc7dWlSUrSULSFJUNiCNwRQwHTmFYVI1KyPH9PcbduT9tgOSl7txWCynd1zb+uByaN4epZyFgRNcdPc6nkFTtyxwM8RA19katPsLuOrGZOF8lMYudonyEp2CEk/hHoCeAPlTHyuRixVQeHfZo/u6A1oHWZOf+piW23RbRAj2+CyliNHQG220jySkUoZpXyvMkh1J3WpYwMaGt2Ci6XOJZrdJuM55LMWM2XXVq4SkVIYXzSCKMak8guPeGNLnbBDjPMyn6q5klzrSzHU4GIbTrgShlBPKifIE8k/KnBjMfHi6mm53JG5P9sstYndZk16JI6eM4Xp/jjFqi5BZ1vH78l/tTe7zh5PPHoB+VLnLOvX7BmfE7T2Gh5BHqohgZ4Q4dVe4suPOjokxX2pDDg3Q40oKSofwR5Ggb2OY4teNCFda4OGoWh1EskzI8JvFpt6ULly45baStXSCdxyfSr2Jssr3I5pPSDzXhajMkTmN3KNXhx1A+Cg+7TTH82477HoUA4ZY+O6zw46gfBQfdpqebcd9j0KnDLHx3SS00sM3GMGtNouKEIlxWihxKFBQB6ieRzzS6zFmOzckmi9JPLoj1SN0cTWO3C//Z'
    $iconBytes = [Convert]::FromBase64String($iconBase64)
    $stream = [System.IO.MemoryStream]::new($iconBytes, 0, $iconBytes.Length)
    $form.Icon = [System.Drawing.Icon]::FromHandle(([System.Drawing.Bitmap]::new($stream).GetHIcon()))

    $form.Add_Shown({$textBox.Select()})
    $result = $form.ShowDialog()

    if ($result -eq [System.Windows.Forms.DialogResult]::OK)
    {
        $x = $textBox.Text
        $form.Close()
    }
    else
    {
        return
    }
    ###END USERNAME FORM###

    ###START COPY FORM###
    $sync = [Hashtable]::Synchronized(@{})

    $copyScript = {
        #Sync setup
        $count = [PowerShell]::Create().AddScript({
            $sync.button.Enabled = $false
            $sync.button.text = "Transfer In Progress"

            #Variable prep
            $destinationprepend = "C:\Users\" + $sync.x
            $source = "\\img\Script-UserData\" + $sync.x
            $destinations = @()
            $sourceappend = @()
            $options = @()
            $logging = ">> c:\Utilities\pglog.txt"

            $destinations += {c:\notes}
            $destinations += {c:\notes\data}
            $destinations += {c:\notes\data}
            $destinations += {c:\notes\data}
            $destinations += {c:\notes\data}
            $destinations += {c:\notes\data\archive}
            $destinations += "$destinationprepend\desktop"
            $destinations += "$destinationprepend\favorites"
            $destinations += "$destinationprepend\Documents"
            $destinations += "$destinationprepend\Downloads"
            $destinations += "$destinationprepend\Pictures"
            $destinations += "$destinationprepend\Music"
            $destinations += "$destinationprepend\Videos"
            $destinations += "$destinationprepend\AppData\Roaming\Microsoft\Templates"
            $destinations += "$destinationprepend\AppData\Roaming\Microsoft\Sticky Notes"
            $destinations += "$env:APPDATA\IBM\Personal Communications"
            $destinations += "C:\Program Files\Ziegler"
            $destinations += "$destinationprepend\AppData\Roaming\Microsoft\Signatures"
            $destinations += "$destinationprepend\AppData\Roaming\Microsoft\Outlook"
            $destinations += "$destinationprepend\AppData\Local\Google\Chrome\User Data\Default"
            $destinations += "$destinationprepend\AppData\Roaming\Mozilla\Firefox"
            $destinations += "C:\ProgramData\Caterpillar\SIMS DBS Upload Utility"
            $destinations += "$destinationprepend\AppData\Roaming\microsoft\windows\recent\automaticdestinations"
            $destinations += "$destinationprepend\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar"

            $sourceappend += {\}
            $sourceappend += {\}
            $sourceappend += {\}
            $sourceappend += {\}
            $sourceappend += {\}
            $sourceappend += {\archive}
            $sourceappend += {\desktop}
            $sourceappend += {\favorites}
            $sourceappend += {\mydocs}
            $sourceappend += {\mydownloads}
            $sourceappend += {\Pictures}
            $sourceappend += {\Music}
            $sourceappend += {\Videos}
            $sourceappend += {\templates}
            $sourceappend += {\stickynotes}
            $sourceappend += {\personalcomm}
            $sourceappend += {\stw network upload\}
            $sourceappend += {\Signatures}
            $sourceappend += {\type-ahead}
            $sourceappend += {\Chrome\Default}
            $sourceappend += {\Firefox}
            $sourceappend += {\DBSUploadUtil}
            $sourceappend += {\QuickAccess}
            $sourceappend += {\TaskbarPinnedItems}

            $options += {notes.ini /R:1 /W:2 /NJS /NJH /NP}
            $options += {*.nsf /xf aglib*.nsf /R:1 /W:2 /NJS /NJH /NP}
            $options += {desktop5.dsk /R:1 /W:2 /NJS /NJH /NP}
            $options += {desktop6.ndk /R:1 /W:2 /NJS /NJH /NP}
            $options += {*.id /R:1 /W:2 /MT /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /NJS /NJH /NP}
            $options += {/xf OnDemand* /R:1 /W:2 /E /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /MT /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /MT /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /MT /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /MT /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /MT /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /NJS /NJH /NP /mt}
            $options += {*.NK2 /R:1 /W:2 /E /NJS /NJH /NP /mt}
            $options += {/XD "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Code Cache" /r:1 /w:2 /E /MT /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /MT /NJS /NJH /NP}
            $options += {/r:1 /w:2 /E /MT /NJS /NJH /NP}
            $options += {/r:1 /w:2 /E /MT /NJS /NJH /NP}
            $options += {/r:1 /w:2 /E /MT /NJS /NJH /NP}

            powershell "Get-WmiObject Win32_printer | Select-Object name > $env:USERPROFILE\Desktop\UsersPrinters.txt" >> c:\Utilities\pglog.txt

            $sync.label.text = "Initiating transfer"

            for ($i = 0; $i -lt $destinations.length; $i++) {
                [int]$pct = ($i/($destinations.count+5))*100
                $sync.progressBar.Value = $pct

                $sync.label.text="Copying "
                $sync.label.text += $destinations[$i]

                $test = "robocopy "
                $test += $destinations[$i]
                $test += " "
                $test += $source
                $test += $sourceappend[$i]
                $test += " "
                $test += $options[$i]
                $test += " "
                $test += $logging
            
                Write-Output $sync.label.text >> C:\Utilities\pglog.txt
                Write-Output I is equal to $i >> C:\Utilities\pglog.txt
                Write-Output $test >> C:\Utilities\pglog.txt
                powershell $test
            }

            ###Non-loopable functions###
            #IBM
            $i++
            [int]$pct = ($i/($destinations.count+5))*100
            $sync.progressbar.Value = $pct
            $sync.label.text="Copying IBM Files"
            if ((Get-CimInstance Win32_operatingsystem).OSArchitecture -eq "64-bit") 
            {
                robocopy "$env:ProgramFiles(x86)\ibm\client access\emulator\private" $source\private-programfiles /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt
                robocopy "$env:APPDATA\IBM\Client Access\Emulator\private" $source\private /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt
            } else 
            {
                robocopy "$env:ProgramFiles\ibm\client access\emulator\private" $source\private-programfiles /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt
                robocopy "$env:APPDATA\IBM\Client Access\Emulator\private" $source\private /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt
            }

            #ET
            $i++
            [int]$pct = ($i/($destinations.count+5))*100
            $sync.progressBar.Value = $pct
            $sync.label.text="Copying ET Files"
            if ((Get-CimInstance Win32_operatingsystem).OSArchitecture -eq "64-bit") {
                robocopy "$env:ProgramFiles(x86)\Caterpillar Electronic Technician\Files" $source\etreports-files /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt
                robocopy "$env:ProgramFiles(x86)\Caterpillar Electronic Technician\Downloads" $source\etreports-downloads /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt
                robocopy "%public%\Caterpillar\Electronic Technician" $source\etreports-public /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt
            } else {
                robocopy "C:\Program Files\Caterpillar Electronic Technician\Files" $source\etreports-files /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt
                robocopy "C:\Program Files\Caterpillar Electronic Technician\Downloads" $source\etreports-downloads /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt
                robocopy "%public%\Caterpillar\Electronic Technician" $source\etreports-public /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt
            }


            #Taskbar
            $i++
            [int]$pct = ($i/($destinations.count+5))*100
            $sync.progressBar.Value = $pct
            $sync.label.Text="Exporting Taskbar Registry Key"
            reg export "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" "$source\TaskbarPinnedItemsBackup.reg" /y >> c:\Utilities\pglog.txt


            #Printers
            $i++
            [int]$pct = ($i/($destinations.count+5))*100
            $sync.progressBar.Value = $pct
            $sync.label.text="Deleting temporary printer file"
            Remove-Item $env:USERPROFILE\Desktop\UsersPrinters.txt


            ###END COPY###
            [int]$pct = 100
            $sync.progressBar.Value = $pct
            $sync.label.text = "Transfer complete"
            $sync.button.text = "Restart Transfer"
            $sync.button.Enabled = $true
        })

    $runspace = [RunspaceFactory]::CreateRunspace()
    $runspace.ApartmentState = "STA"
    $runspace.ThreadOptions = "ReuseThread"
    $runspace.Open()
    $runspace.SessionStateProxy.SetVariable("sync", $sync)

    $count.Runspace = $runspace
    $count.BeginInvoke()
    }

    ###FORM SETUP###
    $form = New-Object Windows.Forms.Form
    $form.ClientSize = New-Object Drawing.Size(400, 90)
    $form.Text = "Local Put"
    $form.StartPosition = "CenterScreen"
    $form.FormBorderStyle = "FixedSingle"
    $form.MaximizeBox = $false

    #icon
    $iconBase64 = '/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAYEBAUEBAYFBQUGBgYHCQ4JCQgICRINDQoOFRIWFhUSFBQXGiEcFxgfGRQUHScdHyIjJSUlFhwpLCgkKyEkJST/2wBDAQYGBgkICREJCREkGBQYJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCT/wAARCAAgACADAREAAhEBAxEB/8QAGQABAAIDAAAAAAAAAAAAAAAACAEGAAUH/8QAMBAAAQMDAwEGAwkAAAAAAAAAAQIDBAAFBgcRMRIUFxghQZRU0dITIjJRVVZhcZH/xAAaAQACAwEBAAAAAAAAAAAAAAAFBwAEBgED/8QAKREAAQQBAgQGAwEAAAAAAAAAAQACAwQFETEVIZGhEhYyQVFSU9Hwgf/aAAwDAQACEQMRAD8A6Tk0t6345dZcZfQ+xEedbVtv0qCCQf8ARSKpxtksRsdsSB3WymcWxuI+ETO/nUT9fV7dr6aa/lnG/i7n9rNcRsfZR386h/uBXt2vpqeWcb+Luf2pxGx9kndLrzOyHArPdLk/9vMkNFTrnSE9R6iOB5elLPNV4692SKIaNB5dFoacjnwtc7dWlSUrSULSFJUNiCNwRQwHTmFYVI1KyPH9PcbduT9tgOSl7txWCynd1zb+uByaN4epZyFgRNcdPc6nkFTtyxwM8RA19katPsLuOrGZOF8lMYudonyEp2CEk/hHoCeAPlTHyuRixVQeHfZo/u6A1oHWZOf+piW23RbRAj2+CyliNHQG220jySkUoZpXyvMkh1J3WpYwMaGt2Ci6XOJZrdJuM55LMWM2XXVq4SkVIYXzSCKMak8guPeGNLnbBDjPMyn6q5klzrSzHU4GIbTrgShlBPKifIE8k/KnBjMfHi6mm53JG5P9sstYndZk16JI6eM4Xp/jjFqi5BZ1vH78l/tTe7zh5PPHoB+VLnLOvX7BmfE7T2Gh5BHqohgZ4Q4dVe4suPOjokxX2pDDg3Q40oKSofwR5Ggb2OY4teNCFda4OGoWh1EskzI8JvFpt6ULly45baStXSCdxyfSr2Jssr3I5pPSDzXhajMkTmN3KNXhx1A+Cg+7TTH82477HoUA4ZY+O6zw46gfBQfdpqebcd9j0KnDLHx3SS00sM3GMGtNouKEIlxWihxKFBQB6ieRzzS6zFmOzckmi9JPLoj1SN0cTWO3C//Z'
    $iconBytes = [Convert]::FromBase64String($iconBase64)
    $stream = [System.IO.MemoryStream]::new($iconBytes, 0, $iconBytes.Length)
    $form.Icon = [System.Drawing.Icon]::FromHandle(([System.Drawing.Bitmap]::new($stream).GetHIcon()))

    $button = New-Object Windows.Forms.Button
    $button.Location = New-Object Drawing.Point(5, 60)
    $button.Width = 385
    $button.Text = "Start Transfer"
    $button.Add_Click($copyScript)

    $label = New-Object Windows.Forms.Label
    $label.Location = New-Object Drawing.Point(5, 10)
    $label.Width = 385
    $label.Text = "Transfer not started"

    $progressBar1 = New-Object System.Windows.Forms.ProgressBar
    $progressBar1.Name = 'progressBar1'
    $progressBar1.Value = 0
    $progressBar1.Style="Continuous"
    $System_Drawing_Size = New-Object System.Drawing.Size
    $System_Drawing_Size.Width = 400 - 15
    $System_Drawing_Size.Height = 20
    $progressBar1.Size = $System_Drawing_Size
    $form.Controls.Add($progressBar1)
    $progressBar1.Left = 5
    $progressBar1.Top = 35

    ###Sync setup###
    $sync.button = $button
    $sync.button2 = $button2
    $sync.label = $label
    $sync.progressBar = $progressBar1
    $sync.x = $x
    $form.Controls.AddRange(@($sync.button, $sync.label, $sync.progressBar, $sync.x))

    #START THE FORM#
    [Windows.Forms.Application]::Run($form)

    
    #------------------------END-----------------------------
}
##Local Get##
elseif ($x -eq "Local Get")
{
    ###START USERNAME FORM###
    $form = New-Object System.Windows.Forms.Form
    $form.Text = 'Local Get'
    $form.Size = New-Object System.Drawing.Size(300,200)
    $form.StartPosition = 'CenterScreen'

    $okButton = New-Object System.Windows.Forms.Button
    $okButton.Location = New-Object System.Drawing.Point(75,120)
    $okButton.Size = New-Object System.Drawing.Size(75,23)
    $okButton.Text = 'Enter'
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
    $label.Text = 'Enter Z or E ID:'
    $form.Controls.Add($label)

    $textBox = New-Object System.Windows.Forms.TextBox
    $textBox.Location = New-Object System.Drawing.Point(10,40)
    $textBox.Size = New-Object System.Drawing.Size(260,20)
    $form.Controls.Add($textBox)

    #icon
    $iconBase64 = '/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAYEBAUEBAYFBQUGBgYHCQ4JCQgICRINDQoOFRIWFhUSFBQXGiEcFxgfGRQUHScdHyIjJSUlFhwpLCgkKyEkJST/2wBDAQYGBgkICREJCREkGBQYJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCT/wAARCAAgACADAREAAhEBAxEB/8QAGQABAAIDAAAAAAAAAAAAAAAACAEGAAUH/8QAMBAAAQMDAwEGAwkAAAAAAAAAAQIDBAAFBgcRMRIUFxghQZRU0dITIjJRVVZhcZH/xAAaAQACAwEBAAAAAAAAAAAAAAAFBwAEBgED/8QAKREAAQQBAgQGAwEAAAAAAAAAAQACAwQFETEVIZGhEhYyQVFSU9Hwgf/aAAwDAQACEQMRAD8A6Tk0t6345dZcZfQ+xEedbVtv0qCCQf8ARSKpxtksRsdsSB3WymcWxuI+ETO/nUT9fV7dr6aa/lnG/i7n9rNcRsfZR386h/uBXt2vpqeWcb+Luf2pxGx9kndLrzOyHArPdLk/9vMkNFTrnSE9R6iOB5elLPNV4692SKIaNB5dFoacjnwtc7dWlSUrSULSFJUNiCNwRQwHTmFYVI1KyPH9PcbduT9tgOSl7txWCynd1zb+uByaN4epZyFgRNcdPc6nkFTtyxwM8RA19katPsLuOrGZOF8lMYudonyEp2CEk/hHoCeAPlTHyuRixVQeHfZo/u6A1oHWZOf+piW23RbRAj2+CyliNHQG220jySkUoZpXyvMkh1J3WpYwMaGt2Ci6XOJZrdJuM55LMWM2XXVq4SkVIYXzSCKMak8guPeGNLnbBDjPMyn6q5klzrSzHU4GIbTrgShlBPKifIE8k/KnBjMfHi6mm53JG5P9sstYndZk16JI6eM4Xp/jjFqi5BZ1vH78l/tTe7zh5PPHoB+VLnLOvX7BmfE7T2Gh5BHqohgZ4Q4dVe4suPOjokxX2pDDg3Q40oKSofwR5Ggb2OY4teNCFda4OGoWh1EskzI8JvFpt6ULly45baStXSCdxyfSr2Jssr3I5pPSDzXhajMkTmN3KNXhx1A+Cg+7TTH82477HoUA4ZY+O6zw46gfBQfdpqebcd9j0KnDLHx3SS00sM3GMGtNouKEIlxWihxKFBQB6ieRzzS6zFmOzckmi9JPLoj1SN0cTWO3C//Z'
    $iconBytes = [Convert]::FromBase64String($iconBase64)
    $stream = [System.IO.MemoryStream]::new($iconBytes, 0, $iconBytes.Length)
    $form.Icon = [System.Drawing.Icon]::FromHandle(([System.Drawing.Bitmap]::new($stream).GetHIcon()))

    $form.Topmost = $true

    $form.Add_Shown({$textBox.Select()})
    $result = $form.ShowDialog()

    if ($result -eq [System.Windows.Forms.DialogResult]::OK)
    {
        $x = $textBox.Text
        $form.Close()
    }
    else
    {
        return
    }
    ###END USERNAME FORM###

    ###START COPY FORM###
    $sync = [Hashtable]::Synchronized(@{})

    $copyScript = {
        #Sync setup
        $count = [PowerShell]::Create().AddScript({
            $sync.button.Enabled = $false
            $sync.button.text = "Transfer In Progress"

            #Variable prep
            $destinationprepend = "C:\Users\" + $sync.x
            $source = "\\img\Script-UserData\" + $sync.x
            $destinations = @()
            $sourceappend = @()
            $options = @()
            $logging = ">> c:\Utilities\pglog.txt"

            $destinations += {c:\notes}
            $destinations += {c:\notes\data}
            $destinations += {c:\notes\data}
            $destinations += {c:\notes\data}
            $destinations += {c:\notes\data}
            $destinations += {c:\notes\data\archive}
            $destinations += "$destinationprepend\desktop"
            $destinations += "$destinationprepend\favorites"
            $destinations += "$destinationprepend\Documents"
            $destinations += "$destinationprepend\Downloads"
            $destinations += "$destinationprepend\Pictures"
            $destinations += "$destinationprepend\Music"
            $destinations += "$destinationprepend\Videos"
            $destinations += "$destinationprepend\AppData\Roaming\Microsoft\Templates"
            $destinations += "$destinationprepend\AppData\Roaming\Microsoft\Sticky Notes"
            $destinations += "$env:APPDATA\IBM\Personal Communications"
            $destinations += "C:\Program Files\Ziegler"
            $destinations += "$destinationprepend\AppData\Roaming\Microsoft\Signatures"
            $destinations += "$destinationprepend\AppData\Roaming\Microsoft\Outlook"
            $destinations += "$destinationprepend\AppData\Local\Google\Chrome\User Data\Default"
            $destinations += "$destinationprepend\AppData\Roaming\Mozilla\Firefox"
            $destinations += "C:\ProgramData\Caterpillar\SIMS DBS Upload Utility"
            $destinations += "$destinationprepend\AppData\Roaming\microsoft\windows\recent\automaticdestinations"
            $destinations += "$destinationprepend\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar"

            $sourceappend += {\}
            $sourceappend += {\}
            $sourceappend += {\}
            $sourceappend += {\}
            $sourceappend += {\}
            $sourceappend += {\archive}
            $sourceappend += {\desktop}
            $sourceappend += {\favorites}
            $sourceappend += {\mydocs}
            $sourceappend += {\mydownloads}
            $sourceappend += {\Pictures}
            $sourceappend += {\Music}
            $sourceappend += {\Videos}
            $sourceappend += {\templates}
            $sourceappend += {\stickynotes}
            $sourceappend += {\personalcomm}
            $sourceappend += {\stw network upload\}
            $sourceappend += {\Signatures}
            $sourceappend += {\type-ahead}
            $sourceappend += {\Chrome\Default}
            $sourceappend += {\Firefox}
            $sourceappend += {\DBSUploadUtil}
            $sourceappend += {\QuickAccess}
            $sourceappend += {\TaskbarPinnedItems}

            $options += {notes.ini /R:1 /W:2 /NJS /NJH /NP}
            $options += {*.nsf /xf aglib*.nsf /R:1 /W:2 /NJS /NJH /NP}
            $options += {desktop5.dsk /R:1 /W:2 /NJS /NJH /NP}
            $options += {desktop6.ndk /R:1 /W:2 /NJS /NJH /NP}
            $options += {*.id /R:1 /W:2 /MT /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /NJS /NJH /NP}
            $options += {/xf OnDemand* /R:1 /W:2 /E /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /MT /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /MT /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /MT /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /MT /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /MT /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /NJS /NJH /NP /mt}
            $options += {*.NK2 /R:1 /W:2 /E /NJS /NJH /NP /mt}
            $options += {/XD "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Code Cache" /r:1 /w:2 /E /MT /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /MT /NJS /NJH /NP}
            $options += {/r:1 /w:2 /E /MT /NJS /NJH /NP}
            $options += {/r:1 /w:2 /E /MT /NJS /NJH /NP}
            $options += {/r:1 /w:2 /E /MT /NJS /NJH /NP}

            powershell "Get-WmiObject Win32_printer | Select-Object name > $env:USERPROFILE\Desktop\UsersPrinters.txt" >> c:\Utilities\pglog.txt

            $sync.label.text = "Initiating transfer"

            for ($i = 0; $i -lt $destinations.length; $i++) {
                [int]$pct = ($i/($destinations.count+5))*100
                $sync.progressBar.Value = $pct

                $sync.label.text="Copying "
                $sync.label.text += $destinations[$i]

                $test = "robocopy "
                $test += $source
                $test += $sourceappend[$i]
                $test += " "
                $test += $destinations[$i]
                $test += " "
                $test += $options[$i]
                $test += " "
                $test += $logging
            
                Write-Output $sync.label.text >> C:\Utilities\pglog.txt
                Write-Output I is equal to $i >> C:\Utilities\pglog.txt
                Write-Output $test >> C:\Utilities\pglog.txt
                powershell $test
            }

            ###Non-loopable functions###
            #IBM
            $i++
            [int]$pct = ($i/($destinations.count+5))*100
            $sync.progressbar.Value = $pct
            $sync.label.text="Copying IBM Files"
            if ((Get-CimInstance Win32_operatingsystem).OSArchitecture -eq "64-bit") 
            {
                robocopy $source\private-programfiles "$env:ProgramFiles(x86)\IBM\Client Access\Emulator\Private" /R:1 /W:2 /E /MT /NJS /NJH /NP >> c:\Utilities\pglog.txt
                robocopy $source\private "$env:APPDATA\IBM\Client Access\Emulator\Private" /R:1 /W:2 /E /MT /NJS /NJH /NP >> c:\Utilities\pglog.txt
            } else 
            {
                robocopy $source\private-programfiles "$env:ProgramFiles\IBM\Client Access\Emulator\Private" /R:1 /W:2 /E /MT /NJS /NJH /NP >> c:\Utilities\pglog.txt
                robocopy $source\private "$env:APPDATA\IBM\Client Access\Emulator\Private" /R:1 /W:2 /E /MT /NJS /NJH /NP >> c:\Utilities\pglog.txt
            }

            #ET
            $i++
            [int]$pct = ($i/($destinations.count+5))*100
            $sync.progressBar.Value = $pct
            $sync.label.text="Copying ET Files"
            if ((Get-CimInstance Win32_operatingsystem).OSArchitecture -eq "64-bit") {
                robocopy $source\etreports-files "$env:ProgramFiles(x86)\Caterpillar Electronic Technician\Files" /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt
                robocopy $source\etreports-downloads "$env:ProgramFiles(x86)\Caterpillar Electronic Technician\Downloads" /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt
                robocopy $source\etreports-public "%public%\Caterpillar\Electronic Technician" /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt
            } else {
                robocopy $source\etreports-files "C:\Program Files\Caterpillar Electronic Technician\Files" /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt
                robocopy $source\etreports-downloads "C:\Program Files\Caterpillar Electronic Technician\Downloads" /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt  
                robocopy $source\etreports-public "%public%\Caterpillar\Electronic Technician" /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt
            }


            #Taskbar
            $i++
            [int]$pct = ($i/($destinations.count+5))*100
            $sync.progressBar.Value = $pct
            $sync.label.Text="Importing Taskbar Registry Key"
            Copy-Item $source\TaskbarPinnedItemsBackup.reg C:\%temp%\TaskbarPinnedItemsBackup.reg
            reg import C:\%temp%\TaskbarPinnedItemsBackup.reg


            #Printers
            $i++
            [int]$pct = ($i/($destinations.count+5))*100
            $sync.progressBar.Value = $pct
            $sync.label.text="Importing printers"
            powershell -file "\\zieglercat.com\software\BranchPreCache\Technical_Documentation\putget\Add-Printers.ps1"

            ###END COPY###
            [int]$pct = 100
            $sync.progressBar.Value = $pct
            $sync.label.text = "Transfer complete"
            $sync.button.text = "Restart Transfer"
            $sync.button.Enabled = $true
        })

    $runspace = [RunspaceFactory]::CreateRunspace()
    $runspace.ApartmentState = "STA"
    $runspace.ThreadOptions = "ReuseThread"
    $runspace.Open()
    $runspace.SessionStateProxy.SetVariable("sync", $sync)

    $count.Runspace = $runspace
    $count.BeginInvoke()
    }

    ###FORM SETUP###
    $form = New-Object Windows.Forms.Form
    $form.ClientSize = New-Object Drawing.Size(400, 90)
    $form.Text = "Local Get"
    $form.StartPosition = "CenterScreen"
    $form.FormBorderStyle = "FixedSingle"
    $form.MaximizeBox = $false

    #icon
    $iconBase64 = '/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAYEBAUEBAYFBQUGBgYHCQ4JCQgICRINDQoOFRIWFhUSFBQXGiEcFxgfGRQUHScdHyIjJSUlFhwpLCgkKyEkJST/2wBDAQYGBgkICREJCREkGBQYJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCT/wAARCAAgACADAREAAhEBAxEB/8QAGQABAAIDAAAAAAAAAAAAAAAACAEGAAUH/8QAMBAAAQMDAwEGAwkAAAAAAAAAAQIDBAAFBgcRMRIUFxghQZRU0dITIjJRVVZhcZH/xAAaAQACAwEBAAAAAAAAAAAAAAAFBwAEBgED/8QAKREAAQQBAgQGAwEAAAAAAAAAAQACAwQFETEVIZGhEhYyQVFSU9Hwgf/aAAwDAQACEQMRAD8A6Tk0t6345dZcZfQ+xEedbVtv0qCCQf8ARSKpxtksRsdsSB3WymcWxuI+ETO/nUT9fV7dr6aa/lnG/i7n9rNcRsfZR386h/uBXt2vpqeWcb+Luf2pxGx9kndLrzOyHArPdLk/9vMkNFTrnSE9R6iOB5elLPNV4692SKIaNB5dFoacjnwtc7dWlSUrSULSFJUNiCNwRQwHTmFYVI1KyPH9PcbduT9tgOSl7txWCynd1zb+uByaN4epZyFgRNcdPc6nkFTtyxwM8RA19katPsLuOrGZOF8lMYudonyEp2CEk/hHoCeAPlTHyuRixVQeHfZo/u6A1oHWZOf+piW23RbRAj2+CyliNHQG220jySkUoZpXyvMkh1J3WpYwMaGt2Ci6XOJZrdJuM55LMWM2XXVq4SkVIYXzSCKMak8guPeGNLnbBDjPMyn6q5klzrSzHU4GIbTrgShlBPKifIE8k/KnBjMfHi6mm53JG5P9sstYndZk16JI6eM4Xp/jjFqi5BZ1vH78l/tTe7zh5PPHoB+VLnLOvX7BmfE7T2Gh5BHqohgZ4Q4dVe4suPOjokxX2pDDg3Q40oKSofwR5Ggb2OY4teNCFda4OGoWh1EskzI8JvFpt6ULly45baStXSCdxyfSr2Jssr3I5pPSDzXhajMkTmN3KNXhx1A+Cg+7TTH82477HoUA4ZY+O6zw46gfBQfdpqebcd9j0KnDLHx3SS00sM3GMGtNouKEIlxWihxKFBQB6ieRzzS6zFmOzckmi9JPLoj1SN0cTWO3C//Z'
    $iconBytes = [Convert]::FromBase64String($iconBase64)
    $stream = [System.IO.MemoryStream]::new($iconBytes, 0, $iconBytes.Length)
    $form.Icon = [System.Drawing.Icon]::FromHandle(([System.Drawing.Bitmap]::new($stream).GetHIcon()))

    $button = New-Object Windows.Forms.Button
    $button.Location = New-Object Drawing.Point(5, 60)
    $button.Width = 385
    $button.Text = "Start Transfer"
    $button.Add_Click($copyScript)

    $label = New-Object Windows.Forms.Label
    $label.Location = New-Object Drawing.Point(5, 10)
    $label.Width = 385
    $label.Text = "Transfer not started"

    $progressBar1 = New-Object System.Windows.Forms.ProgressBar
    $progressBar1.Name = 'progressBar1'
    $progressBar1.Value = 0
    $progressBar1.Style="Continuous"
    $System_Drawing_Size = New-Object System.Drawing.Size
    $System_Drawing_Size.Width = 400 - 15
    $System_Drawing_Size.Height = 20
    $progressBar1.Size = $System_Drawing_Size
    $form.Controls.Add($progressBar1)
    $progressBar1.Left = 5
    $progressBar1.Top = 35

    ###Sync setup###
    $sync.button = $button
    $sync.button2 = $button2
    $sync.label = $label
    $sync.progressBar = $progressBar1
    $sync.x = $x
    $form.Controls.AddRange(@($sync.button, $sync.label, $sync.progressBar, $sync.x))

    #START THE FORM#
    [Windows.Forms.Application]::Run($form)
#------------------------END-----------------------------
}
##Remote Put##
elseif ($x -eq "Remote Put")
{
    ###START IP FORM###
    $form = New-Object System.Windows.Forms.Form
    $form.Text = 'Remote Put'
    $form.Size = New-Object System.Drawing.Size(300,200)
    $form.StartPosition = 'CenterScreen'

    $okButton = New-Object System.Windows.Forms.Button
    $okButton.Location = New-Object System.Drawing.Point(75,120)
    $okButton.Size = New-Object System.Drawing.Size(75,23)
    $okButton.Text = 'Enter'
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
    $label.Text = 'Enter IP Address:'
    $form.Controls.Add($label)

    $textBox = New-Object System.Windows.Forms.TextBox
    $textBox.Location = New-Object System.Drawing.Point(10,40)
    $textBox.Size = New-Object System.Drawing.Size(260,20)
    $form.Controls.Add($textBox)

    #icon
    $iconBase64 = '/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAYEBAUEBAYFBQUGBgYHCQ4JCQgICRINDQoOFRIWFhUSFBQXGiEcFxgfGRQUHScdHyIjJSUlFhwpLCgkKyEkJST/2wBDAQYGBgkICREJCREkGBQYJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCT/wAARCAAgACADAREAAhEBAxEB/8QAGQABAAIDAAAAAAAAAAAAAAAACAEGAAUH/8QAMBAAAQMDAwEGAwkAAAAAAAAAAQIDBAAFBgcRMRIUFxghQZRU0dITIjJRVVZhcZH/xAAaAQACAwEBAAAAAAAAAAAAAAAFBwAEBgED/8QAKREAAQQBAgQGAwEAAAAAAAAAAQACAwQFETEVIZGhEhYyQVFSU9Hwgf/aAAwDAQACEQMRAD8A6Tk0t6345dZcZfQ+xEedbVtv0qCCQf8ARSKpxtksRsdsSB3WymcWxuI+ETO/nUT9fV7dr6aa/lnG/i7n9rNcRsfZR386h/uBXt2vpqeWcb+Luf2pxGx9kndLrzOyHArPdLk/9vMkNFTrnSE9R6iOB5elLPNV4692SKIaNB5dFoacjnwtc7dWlSUrSULSFJUNiCNwRQwHTmFYVI1KyPH9PcbduT9tgOSl7txWCynd1zb+uByaN4epZyFgRNcdPc6nkFTtyxwM8RA19katPsLuOrGZOF8lMYudonyEp2CEk/hHoCeAPlTHyuRixVQeHfZo/u6A1oHWZOf+piW23RbRAj2+CyliNHQG220jySkUoZpXyvMkh1J3WpYwMaGt2Ci6XOJZrdJuM55LMWM2XXVq4SkVIYXzSCKMak8guPeGNLnbBDjPMyn6q5klzrSzHU4GIbTrgShlBPKifIE8k/KnBjMfHi6mm53JG5P9sstYndZk16JI6eM4Xp/jjFqi5BZ1vH78l/tTe7zh5PPHoB+VLnLOvX7BmfE7T2Gh5BHqohgZ4Q4dVe4suPOjokxX2pDDg3Q40oKSofwR5Ggb2OY4teNCFda4OGoWh1EskzI8JvFpt6ULly45baStXSCdxyfSr2Jssr3I5pPSDzXhajMkTmN3KNXhx1A+Cg+7TTH82477HoUA4ZY+O6zw46gfBQfdpqebcd9j0KnDLHx3SS00sM3GMGtNouKEIlxWihxKFBQB6ieRzzS6zFmOzckmi9JPLoj1SN0cTWO3C//Z'
    $iconBytes = [Convert]::FromBase64String($iconBase64)
    $stream = [System.IO.MemoryStream]::new($iconBytes, 0, $iconBytes.Length)
    $form.Icon = [System.Drawing.Icon]::FromHandle(([System.Drawing.Bitmap]::new($stream).GetHIcon()))

    $form.Topmost = $true

    $form.Add_Shown({$textBox.Select()})
    $result = $form.ShowDialog()

    if ($result -eq [System.Windows.Forms.DialogResult]::OK)
    {
        $x = $textBox.Text
    }
    else
    {
        return
    }
    ###END IP FORM###

    ###START COPY FORM###
    $sync = [Hashtable]::Synchronized(@{})

    $copyScript = {
        #Sync setup
        $count = [PowerShell]::Create().AddScript({
            $sync.button.Enabled = $false
            $sync.button.text = "Transfer In Progress"

            #Variable prep
            $x = $sync.x
            $source = "\\$x\C$\scriptfolder\$env:USERNAME"
            $destinations = @()
            $sourceappend = @()
            $options = @()
            $logging = ">> c:\Utilities\pglog.txt"

            $destinations += {c:\notes}
            $destinations += {c:\notes\data}
            $destinations += {c:\notes\data}
            $destinations += {c:\notes\data}
            $destinations += {c:\notes\data}
            $destinations += {c:\notes\data\archive}
            $destinations += {"$env:USERPROFILE\desktop"}
            $destinations += {"$env:USERPROFILE\favorites"}
            $destinations += {"$env:USERPROFILE\Documents"}
            $destinations += {"$env:USERPROFILE\Downloads"}
            $destinations += {"$env:USERPROFILE\Pictures"}
            $destinations += {"$env:USERPROFILE\Music"}
            $destinations += {"$env:USERPROFILE\Videos"}
            $destinations += {"$env:APPDATA\Microsoft\Templates"}
            $destinations += {"$env:APPDATA\Microsoft\Sticky Notes"}
            $destinations += {"$env:APPDATA\IBM\Personal Communications"}
            $destinations += {"C:\Program Files\Ziegler"}
            $destinations += {"$env:APPDATA\Microsoft\Signatures"}
            $destinations += {"$env:APPDATA\Microsoft\Outlook"}
            $destinations += {"$env:LOCALAPPDATA\Google\Chrome\User Data\Default"}
            $destinations += {"$env:APPDATA\Mozilla\Firefox"}
            $destinations += {"C:\ProgramData\Caterpillar\SIMS DBS Upload Utility"}
            $destinations += {"$env:APPDATA\microsoft\windows\recent\automaticdestinations"}
            $destinations += {"$env:APPDATA\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar"}

            $sourceappend += {\}
            $sourceappend += {\}
            $sourceappend += {\}
            $sourceappend += {\}
            $sourceappend += {\}
            $sourceappend += {\archive}
            $sourceappend += {\desktop}
            $sourceappend += {\favorites}
            $sourceappend += {\mydocs}
            $sourceappend += {\mydownloads}
            $sourceappend += {\Pictures}
            $sourceappend += {\Music}
            $sourceappend += {\Videos}
            $sourceappend += {\templates}
            $sourceappend += {\stickynotes}
            $sourceappend += {\personalcomm}
            $sourceappend += {\stw network upload\}
            $sourceappend += {\Signatures}
            $sourceappend += {\type-ahead}
            $sourceappend += {\Chrome\Default}
            $sourceappend += {\Firefox}
            $sourceappend += {\DBSUploadUtil}
            $sourceappend += {\QuickAccess}
            $sourceappend += {\TaskbarPinnedItems}

            $options += {notes.ini /R:1 /W:2 /NJS /NJH /NP}
            $options += {*.nsf /xf aglib*.nsf /R:1 /W:2 /NJS /NJH /NP}
            $options += {desktop5.dsk /R:1 /W:2 /NJS /NJH /NP}
            $options += {desktop6.ndk /R:1 /W:2 /NJS /NJH /NP}
            $options += {*.id /R:1 /W:2 /MT /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /NJS /NJH /NP}
            $options += {/xf OnDemand* /R:1 /W:2 /E /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /MT /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /MT /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /MT /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /MT /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /MT /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /NJS /NJH /NP /mt}
            $options += {*.NK2 /R:1 /W:2 /E /NJS /NJH /NP /mt}
            $options += {/XD "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Code Cache" /r:1 /w:2 /E /MT /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /MT /NJS /NJH /NP}
            $options += {/r:1 /w:2 /E /MT /NJS /NJH /NP}
            $options += {/r:1 /w:2 /E /MT /NJS /NJH /NP}
            $options += {/r:1 /w:2 /E /MT /NJS /NJH /NP}

            powershell "Get-WmiObject Win32_printer | Select-Object name > $env:USERPROFILE\Desktop\UsersPrinters.txt" >> c:\Utilities\pglog.txt

            $sync.label.text = "Initiating transfer"

            for ($i = 0; $i -lt $destinations.length; $i++) {
                [int]$pct = ($i/($destinations.count+5))*100
                $sync.progressBar.Value = $pct

                $sync.label.text="Copying "
                $sync.label.text += $destinations[$i]

                $test = "robocopy "
                $test += $destinations[$i]
                $test += " "
                $test += $source
                $test += $sourceappend[$i]
                $test += " "
                $test += $options[$i]
                $test += " "
                $test += $logging
            
                Write-Output $sync.label.text >> C:\Utilities\pglog.txt
                Write-Output I is equal to $i >> C:\Utilities\pglog.txt
                Write-Output $test >> C:\Utilities\pglog.txt
                powershell $test
            }

            ###Non-loopable functions###
            #IBM
            $i++
            [int]$pct = ($i/($destinations.count+5))*100
            $sync.progressbar.Value = $pct
            $sync.label.text="Copying IBM Files"
            if ((Get-CimInstance Win32_operatingsystem).OSArchitecture -eq "64-bit") 
            {
                robocopy "$env:ProgramFiles(x86)\ibm\client access\emulator\private" $source\private-programfiles /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt
                robocopy "$env:APPDATA\IBM\Client Access\Emulator\private" $source\private /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt
            } else 
            {
                robocopy "$env:ProgramFiles\ibm\client access\emulator\private" $source\private-programfiles /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt
                robocopy "$env:APPDATA\IBM\Client Access\Emulator\private" $source\private /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt
            }


            #ET
            $i++
            [int]$pct = ($i/($destinations.count+5))*100
            $sync.progressBar.Value = $pct
            $sync.label.text="Copying ET Files"
            if ((Get-CimInstance Win32_operatingsystem).OSArchitecture -eq "64-bit") {
                robocopy "$env:ProgramFiles(x86)\Caterpillar Electronic Technician\Files" $source\etreports-files /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt
                robocopy "$env:ProgramFiles(x86)\Caterpillar Electronic Technician\Downloads" $source\etreports-downloads /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt
                robocopy "%public%\Caterpillar\Electronic Technician" $source\etreports-public /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt
            } else {
                robocopy "C:\Program Files\Caterpillar Electronic Technician\Files" $source\etreports-files /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt
                robocopy "C:\Program Files\Caterpillar Electronic Technician\Downloads" $source\etreports-downloads /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt
                robocopy "%public%\Caterpillar\Electronic Technician" $source\etreports-public /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt
            }


            #Taskbar
            $i++
            [int]$pct = ($i/($destinations.count+5))*100
            $sync.progressBar.Value = $pct
            $sync.label.Text="Exporting Taskbar Registry Key"
            reg export "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" "$source\TaskbarPinnedItemsBackup.reg" /y >> c:\Utilities\pglog.txt


            #Printers
            $i++
            [int]$pct = ($i/($destinations.count+5))*100
            $sync.progressBar.Value = $pct
            $sync.label.text="Deleting temporary printer file"
            Remove-Item $env:USERPROFILE\Desktop\UsersPrinters.txt

            ###END COPY###
            [int]$pct = 100
            $sync.progressBar.Value = $pct
            $sync.label.text = "Transfer complete"
            $sync.button.text = "Restart Transfer"
            $sync.button.Enabled = $true
        })

    $runspace = [RunspaceFactory]::CreateRunspace()
    $runspace.ApartmentState = "STA"
    $runspace.ThreadOptions = "ReuseThread"
    $runspace.Open()
    $runspace.SessionStateProxy.SetVariable("sync", $sync)

    $count.Runspace = $runspace
    $count.BeginInvoke()
    }
    
    ###FORM SETUP###
    $form = New-Object Windows.Forms.Form
    $form.ClientSize = New-Object Drawing.Size(400, 90)
    $form.Text = "Remote Put"
    $form.StartPosition = "CenterScreen"
    $form.FormBorderStyle = "FixedSingle"
    $form.MaximizeBox = $false

    #icon
    $iconBase64 = '/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAYEBAUEBAYFBQUGBgYHCQ4JCQgICRINDQoOFRIWFhUSFBQXGiEcFxgfGRQUHScdHyIjJSUlFhwpLCgkKyEkJST/2wBDAQYGBgkICREJCREkGBQYJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCT/wAARCAAgACADAREAAhEBAxEB/8QAGQABAAIDAAAAAAAAAAAAAAAACAEGAAUH/8QAMBAAAQMDAwEGAwkAAAAAAAAAAQIDBAAFBgcRMRIUFxghQZRU0dITIjJRVVZhcZH/xAAaAQACAwEBAAAAAAAAAAAAAAAFBwAEBgED/8QAKREAAQQBAgQGAwEAAAAAAAAAAQACAwQFETEVIZGhEhYyQVFSU9Hwgf/aAAwDAQACEQMRAD8A6Tk0t6345dZcZfQ+xEedbVtv0qCCQf8ARSKpxtksRsdsSB3WymcWxuI+ETO/nUT9fV7dr6aa/lnG/i7n9rNcRsfZR386h/uBXt2vpqeWcb+Luf2pxGx9kndLrzOyHArPdLk/9vMkNFTrnSE9R6iOB5elLPNV4692SKIaNB5dFoacjnwtc7dWlSUrSULSFJUNiCNwRQwHTmFYVI1KyPH9PcbduT9tgOSl7txWCynd1zb+uByaN4epZyFgRNcdPc6nkFTtyxwM8RA19katPsLuOrGZOF8lMYudonyEp2CEk/hHoCeAPlTHyuRixVQeHfZo/u6A1oHWZOf+piW23RbRAj2+CyliNHQG220jySkUoZpXyvMkh1J3WpYwMaGt2Ci6XOJZrdJuM55LMWM2XXVq4SkVIYXzSCKMak8guPeGNLnbBDjPMyn6q5klzrSzHU4GIbTrgShlBPKifIE8k/KnBjMfHi6mm53JG5P9sstYndZk16JI6eM4Xp/jjFqi5BZ1vH78l/tTe7zh5PPHoB+VLnLOvX7BmfE7T2Gh5BHqohgZ4Q4dVe4suPOjokxX2pDDg3Q40oKSofwR5Ggb2OY4teNCFda4OGoWh1EskzI8JvFpt6ULly45baStXSCdxyfSr2Jssr3I5pPSDzXhajMkTmN3KNXhx1A+Cg+7TTH82477HoUA4ZY+O6zw46gfBQfdpqebcd9j0KnDLHx3SS00sM3GMGtNouKEIlxWihxKFBQB6ieRzzS6zFmOzckmi9JPLoj1SN0cTWO3C//Z'
    $iconBytes = [Convert]::FromBase64String($iconBase64)
    $stream = [System.IO.MemoryStream]::new($iconBytes, 0, $iconBytes.Length)
    $form.Icon = [System.Drawing.Icon]::FromHandle(([System.Drawing.Bitmap]::new($stream).GetHIcon()))

    $button = New-Object Windows.Forms.Button
    $button.Location = New-Object Drawing.Point(5, 60)
    $button.Width = 385
    $button.Text = "Start Transfer"
    $button.Add_Click($copyScript)

    $label = New-Object Windows.Forms.Label
    $label.Location = New-Object Drawing.Point(5, 10)
    $label.Width = 385
    $label.Text = "Transfer not started"

    $progressBar1 = New-Object System.Windows.Forms.ProgressBar
    $progressBar1.Name = 'progressBar1'
    $progressBar1.Value = 0
    $progressBar1.Style="Continuous"
    $System_Drawing_Size = New-Object System.Drawing.Size
    $System_Drawing_Size.Width = 400 - 15
    $System_Drawing_Size.Height = 20
    $progressBar1.Size = $System_Drawing_Size
    $form.Controls.Add($progressBar1)
    $progressBar1.Left = 5
    $progressBar1.Top = 35

    ###Sync setup###
    $sync.button = $button
    $sync.button2 = $button2
    $sync.label = $label
    $sync.progressBar = $progressBar1
    $sync.x = $x
    $form.Controls.AddRange(@($sync.button, $sync.label, $sync.progressBar, $sync.x))

    #START THE FORM#
    [Windows.Forms.Application]::Run($form)

#------------------------END-----------------------------

}
##Remote Get##
elseif ($x -eq "Remote Get")
{
    ###START IP FORM###
    $form = New-Object System.Windows.Forms.Form
    $form.Text = 'Remote Get'
    $form.Size = New-Object System.Drawing.Size(300,200)
    $form.StartPosition = 'CenterScreen'

    $okButton = New-Object System.Windows.Forms.Button
    $okButton.Location = New-Object System.Drawing.Point(75,120)
    $okButton.Size = New-Object System.Drawing.Size(75,23)
    $okButton.Text = 'Enter'
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
    $label.Text = 'Enter IP Address:'
    $form.Controls.Add($label)

    $textBox = New-Object System.Windows.Forms.TextBox
    $textBox.Location = New-Object System.Drawing.Point(10,40)
    $textBox.Size = New-Object System.Drawing.Size(260,20)
    $form.Controls.Add($textBox)

    #icon
    $iconBase64 = '/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAYEBAUEBAYFBQUGBgYHCQ4JCQgICRINDQoOFRIWFhUSFBQXGiEcFxgfGRQUHScdHyIjJSUlFhwpLCgkKyEkJST/2wBDAQYGBgkICREJCREkGBQYJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCT/wAARCAAgACADAREAAhEBAxEB/8QAGQABAAIDAAAAAAAAAAAAAAAACAEGAAUH/8QAMBAAAQMDAwEGAwkAAAAAAAAAAQIDBAAFBgcRMRIUFxghQZRU0dITIjJRVVZhcZH/xAAaAQACAwEBAAAAAAAAAAAAAAAFBwAEBgED/8QAKREAAQQBAgQGAwEAAAAAAAAAAQACAwQFETEVIZGhEhYyQVFSU9Hwgf/aAAwDAQACEQMRAD8A6Tk0t6345dZcZfQ+xEedbVtv0qCCQf8ARSKpxtksRsdsSB3WymcWxuI+ETO/nUT9fV7dr6aa/lnG/i7n9rNcRsfZR386h/uBXt2vpqeWcb+Luf2pxGx9kndLrzOyHArPdLk/9vMkNFTrnSE9R6iOB5elLPNV4692SKIaNB5dFoacjnwtc7dWlSUrSULSFJUNiCNwRQwHTmFYVI1KyPH9PcbduT9tgOSl7txWCynd1zb+uByaN4epZyFgRNcdPc6nkFTtyxwM8RA19katPsLuOrGZOF8lMYudonyEp2CEk/hHoCeAPlTHyuRixVQeHfZo/u6A1oHWZOf+piW23RbRAj2+CyliNHQG220jySkUoZpXyvMkh1J3WpYwMaGt2Ci6XOJZrdJuM55LMWM2XXVq4SkVIYXzSCKMak8guPeGNLnbBDjPMyn6q5klzrSzHU4GIbTrgShlBPKifIE8k/KnBjMfHi6mm53JG5P9sstYndZk16JI6eM4Xp/jjFqi5BZ1vH78l/tTe7zh5PPHoB+VLnLOvX7BmfE7T2Gh5BHqohgZ4Q4dVe4suPOjokxX2pDDg3Q40oKSofwR5Ggb2OY4teNCFda4OGoWh1EskzI8JvFpt6ULly45baStXSCdxyfSr2Jssr3I5pPSDzXhajMkTmN3KNXhx1A+Cg+7TTH82477HoUA4ZY+O6zw46gfBQfdpqebcd9j0KnDLHx3SS00sM3GMGtNouKEIlxWihxKFBQB6ieRzzS6zFmOzckmi9JPLoj1SN0cTWO3C//Z'
    $iconBytes = [Convert]::FromBase64String($iconBase64)
    $stream = [System.IO.MemoryStream]::new($iconBytes, 0, $iconBytes.Length)
    $form.Icon = [System.Drawing.Icon]::FromHandle(([System.Drawing.Bitmap]::new($stream).GetHIcon()))

    $form.Topmost = $true

    $form.Add_Shown({$textBox.Select()})
    $result = $form.ShowDialog()

    if ($result -eq [System.Windows.Forms.DialogResult]::OK)
    {
        $x = $textBox.Text
    }
    else
    {
        return
    }
    ###END IP FORM###

    ###START COPY FORM###
    $sync = [Hashtable]::Synchronized(@{})

    $copyScript = {
        #Sync setup
        $count = [PowerShell]::Create().AddScript({
            $sync.button.Enabled = $false
            $sync.button.text = "Transfer In Progress"

            #Variable prep
            $x = $sync.x
            $source = "\\$x\C$\scriptfolder\$env:USERNAME"
            $destinations = @()
            $sourceappend = @()
            $options = @()
            $logging = ">> c:\Utilities\pglog.txt"

            $destinations += {c:\notes}
            $destinations += {c:\notes\data}
            $destinations += {c:\notes\data}
            $destinations += {c:\notes\data}
            $destinations += {c:\notes\data}
            $destinations += {c:\notes\data\archive}
            $destinations += {"$env:USERPROFILE\desktop"}
            $destinations += {"$env:USERPROFILE\favorites"}
            $destinations += {"$env:USERPROFILE\Documents"}
            $destinations += {"$env:USERPROFILE\Downloads"}
            $destinations += {"$env:USERPROFILE\Pictures"}
            $destinations += {"$env:USERPROFILE\Music"}
            $destinations += {"$env:USERPROFILE\Videos"}
            $destinations += {"$env:APPDATA\Microsoft\Templates"}
            $destinations += {"$env:APPDATA\Microsoft\Sticky Notes"}
            $destinations += {"$env:APPDATA\IBM\Personal Communications"}
            $destinations += {"C:\Program Files\Ziegler"}
            $destinations += {"$env:APPDATA\Microsoft\Signatures"}
            $destinations += {"$env:APPDATA\Microsoft\Outlook"}
            $destinations += {"$env:LOCALAPPDATA\Google\Chrome\User Data\Default"}
            $destinations += {"$env:APPDATA\Mozilla\Firefox"}
            $destinations += {"C:\ProgramData\Caterpillar\SIMS DBS Upload Utility"}
            $destinations += {"$env:APPDATA\microsoft\windows\recent\automaticdestinations"}
            $destinations += {"$env:APPDATA\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar"}

            $sourceappend += {\}
            $sourceappend += {\}
            $sourceappend += {\}
            $sourceappend += {\}
            $sourceappend += {\}
            $sourceappend += {\archive}
            $sourceappend += {\desktop}
            $sourceappend += {\favorites}
            $sourceappend += {\mydocs}
            $sourceappend += {\mydownloads}
            $sourceappend += {\Pictures}
            $sourceappend += {\Music}
            $sourceappend += {\Videos}
            $sourceappend += {\templates}
            $sourceappend += {\stickynotes}
            $sourceappend += {\personalcomm}
            $sourceappend += {\stw network upload\}
            $sourceappend += {\Signatures}
            $sourceappend += {\type-ahead}
            $sourceappend += {\Chrome\Default}
            $sourceappend += {\Firefox}
            $sourceappend += {\DBSUploadUtil}
            $sourceappend += {\QuickAccess}
            $sourceappend += {\TaskbarPinnedItems}

            $options += {notes.ini /R:1 /W:2 /NJS /NJH /NP}
            $options += {*.nsf /xf aglib*.nsf /R:1 /W:2 /NJS /NJH /NP}
            $options += {desktop5.dsk /R:1 /W:2 /NJS /NJH /NP}
            $options += {desktop6.ndk /R:1 /W:2 /NJS /NJH /NP}
            $options += {*.id /R:1 /W:2 /MT /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /NJS /NJH /NP}
            $options += {/xf OnDemand* /R:1 /W:2 /E /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /MT /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /MT /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /MT /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /MT /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /MT /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /NJS /NJH /NP /mt}
            $options += {*.NK2 /R:1 /W:2 /E /NJS /NJH /NP /mt}
            $options += {/XD "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Code Cache" /r:1 /w:2 /E /MT /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /MT /NJS /NJH /NP}
            $options += {/r:1 /w:2 /E /MT /NJS /NJH /NP}
            $options += {/r:1 /w:2 /E /MT /NJS /NJH /NP}
            $options += {/r:1 /w:2 /E /MT /NJS /NJH /NP}

            powershell "Get-WmiObject Win32_printer | Select-Object name > $env:USERPROFILE\Desktop\UsersPrinters.txt" >> c:\Utilities\pglog.txt

            $sync.label.text = "Initiating transfer"

            for ($i = 0; $i -lt $destinations.length; $i++) {
                [int]$pct = ($i/($destinations.count+5))*100
                $sync.progressBar.Value = $pct

                $sync.label.text="Copying "
                $sync.label.text += $destinations[$i]

                $test = "robocopy "
                $test += $source
                $test += $sourceappend[$i]
                $test += " "
                $test += $destinations[$i]
                $test += " "
                $test += $options[$i]
                $test += " "
                $test += $logging
            
                Write-Output $sync.label.text >> C:\Utilities\pglog.txt
                Write-Output I is equal to $i >> C:\Utilities\pglog.txt
                Write-Output $test >> C:\Utilities\pglog.txt
                powershell $test
            }

            ###Non-loopable functions###
            #IBM
            $i++
            [int]$pct = ($i/($destinations.count+5))*100
            $sync.progressbar.Value = $pct
            $sync.label.text="Copying IBM Files"
            if ((Get-CimInstance Win32_operatingsystem).OSArchitecture -eq "64-bit") 
            {
                robocopy $source\private-programfiles "$env:ProgramFiles(x86)\IBM\Client Access\Emulator\Private" /R:1 /W:2 /E /MT /NJS /NJH /NP >> c:\Utilities\pglog.txt
                robocopy $source\private "$env:APPDATA\IBM\Client Access\Emulator\Private" /R:1 /W:2 /E /MT /NJS /NJH /NP >> c:\Utilities\pglog.txt
            } else 
            {
                robocopy $source\private-programfiles "$env:ProgramFiles\IBM\Client Access\Emulator\Private" /R:1 /W:2 /E /MT /NJS /NJH /NP >> c:\Utilities\pglog.txt
                robocopy $source\private "$env:APPDATA\IBM\Client Access\Emulator\Private" /R:1 /W:2 /E /MT /NJS /NJH /NP >> c:\Utilities\pglog.txt
            }

            #ET
            $i++
            [int]$pct = ($i/($destinations.count+5))*100
            $sync.progressBar.Value = $pct
            $sync.label.text="Copying ET Files"
            if ((Get-CimInstance Win32_operatingsystem).OSArchitecture -eq "64-bit") {
                robocopy $source\etreports-files "$env:ProgramFiles(x86)\Caterpillar Electronic Technician\Files" /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt
                robocopy $source\etreports-downloads "$env:ProgramFiles(x86)\Caterpillar Electronic Technician\Downloads" /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt
                robocopy $source\etreports-public "%public%\Caterpillar\Electronic Technician" /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt
            } else {
                robocopy $source\etreports-files "C:\Program Files\Caterpillar Electronic Technician\Files" /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt
                robocopy $source\etreports-downloads "C:\Program Files\Caterpillar Electronic Technician\Downloads" /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt  
                robocopy $source\etreports-public "%public%\Caterpillar\Electronic Technician" /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt
            }


            #Taskbar
            $i++
            [int]$pct = ($i/($destinations.count+5))*100
            $sync.progressBar.Value = $pct
            $sync.label.Text="Importing Taskbar Registry Key"
            Copy-Item $source\TaskbarPinnedItemsBackup.reg C:\%temp%\TaskbarPinnedItemsBackup.reg
            reg import C:\%temp%\TaskbarPinnedItemsBackup.reg


            #Printers
            $i++
            [int]$pct = ($i/($destinations.count+5))*100
            $sync.progressBar.Value = $pct
            $sync.label.text="Importing printers"
            powershell -file "\\zieglercat.com\software\BranchPreCache\Technical_Documentation\putget\Add-Printers.ps1"


            ###END COPY###
            [int]$pct = 100
            $sync.progressBar.Value = $pct
            $sync.label.text = "Transfer complete"
            $sync.button.text = "Restart Transfer"
            $sync.button.Enabled = $true
        })

    $runspace = [RunspaceFactory]::CreateRunspace()
    $runspace.ApartmentState = "STA"
    $runspace.ThreadOptions = "ReuseThread"
    $runspace.Open()
    $runspace.SessionStateProxy.SetVariable("sync", $sync)

    $count.Runspace = $runspace
    $count.BeginInvoke()
    }

    ###FORM SETUP###
    $form = New-Object Windows.Forms.Form
    $form.ClientSize = New-Object Drawing.Size(400, 90)
    $form.Text = "Remote Get"
    $form.StartPosition = "CenterScreen"
    $form.FormBorderStyle = "FixedSingle"
    $form.MaximizeBox = $false

    #icon
    $iconBase64 = '/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAYEBAUEBAYFBQUGBgYHCQ4JCQgICRINDQoOFRIWFhUSFBQXGiEcFxgfGRQUHScdHyIjJSUlFhwpLCgkKyEkJST/2wBDAQYGBgkICREJCREkGBQYJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCT/wAARCAAgACADAREAAhEBAxEB/8QAGQABAAIDAAAAAAAAAAAAAAAACAEGAAUH/8QAMBAAAQMDAwEGAwkAAAAAAAAAAQIDBAAFBgcRMRIUFxghQZRU0dITIjJRVVZhcZH/xAAaAQACAwEBAAAAAAAAAAAAAAAFBwAEBgED/8QAKREAAQQBAgQGAwEAAAAAAAAAAQACAwQFETEVIZGhEhYyQVFSU9Hwgf/aAAwDAQACEQMRAD8A6Tk0t6345dZcZfQ+xEedbVtv0qCCQf8ARSKpxtksRsdsSB3WymcWxuI+ETO/nUT9fV7dr6aa/lnG/i7n9rNcRsfZR386h/uBXt2vpqeWcb+Luf2pxGx9kndLrzOyHArPdLk/9vMkNFTrnSE9R6iOB5elLPNV4692SKIaNB5dFoacjnwtc7dWlSUrSULSFJUNiCNwRQwHTmFYVI1KyPH9PcbduT9tgOSl7txWCynd1zb+uByaN4epZyFgRNcdPc6nkFTtyxwM8RA19katPsLuOrGZOF8lMYudonyEp2CEk/hHoCeAPlTHyuRixVQeHfZo/u6A1oHWZOf+piW23RbRAj2+CyliNHQG220jySkUoZpXyvMkh1J3WpYwMaGt2Ci6XOJZrdJuM55LMWM2XXVq4SkVIYXzSCKMak8guPeGNLnbBDjPMyn6q5klzrSzHU4GIbTrgShlBPKifIE8k/KnBjMfHi6mm53JG5P9sstYndZk16JI6eM4Xp/jjFqi5BZ1vH78l/tTe7zh5PPHoB+VLnLOvX7BmfE7T2Gh5BHqohgZ4Q4dVe4suPOjokxX2pDDg3Q40oKSofwR5Ggb2OY4teNCFda4OGoWh1EskzI8JvFpt6ULly45baStXSCdxyfSr2Jssr3I5pPSDzXhajMkTmN3KNXhx1A+Cg+7TTH82477HoUA4ZY+O6zw46gfBQfdpqebcd9j0KnDLHx3SS00sM3GMGtNouKEIlxWihxKFBQB6ieRzzS6zFmOzckmi9JPLoj1SN0cTWO3C//Z'
    $iconBytes = [Convert]::FromBase64String($iconBase64)
    $stream = [System.IO.MemoryStream]::new($iconBytes, 0, $iconBytes.Length)
    $form.Icon = [System.Drawing.Icon]::FromHandle(([System.Drawing.Bitmap]::new($stream).GetHIcon()))

    $button = New-Object Windows.Forms.Button
    $button.Location = New-Object Drawing.Point(5, 60)
    $button.Width = 385
    $button.Text = "Start Transfer"
    $button.Add_Click($copyScript)

    $label = New-Object Windows.Forms.Label
    $label.Location = New-Object Drawing.Point(5, 10)
    $label.Width = 385
    $label.Text = "Transfer not started"

    $progressBar1 = New-Object System.Windows.Forms.ProgressBar
    $progressBar1.Name = 'progressBar1'
    $progressBar1.Value = 0
    $progressBar1.Style="Continuous"
    $System_Drawing_Size = New-Object System.Drawing.Size
    $System_Drawing_Size.Width = 400 - 15
    $System_Drawing_Size.Height = 20
    $progressBar1.Size = $System_Drawing_Size
    $form.Controls.Add($progressBar1)
    $progressBar1.Left = 5
    $progressBar1.Top = 35

    ###Sync setup###
    $sync.button = $button
    $sync.button2 = $button2
    $sync.label = $label
    $sync.progressBar = $progressBar1
    $sync.x = $x
    $form.Controls.AddRange(@($sync.button, $sync.label, $sync.progressBar, $sync.x))

    #START THE FORM#
    [Windows.Forms.Application]::Run($form)

    #------------------------END-----------------------------

}
##Remote Get w/Delete##
elseif ($x -eq "Remote Get w/ Delete")
{
    ###START IP FORM###
    $form = New-Object System.Windows.Forms.Form
    $form.Text = 'Remote Get w/ Delete'
    $form.Size = New-Object System.Drawing.Size(300,200)
    $form.StartPosition = 'CenterScreen'

    $okButton = New-Object System.Windows.Forms.Button
    $okButton.Location = New-Object System.Drawing.Point(75,120)
    $okButton.Size = New-Object System.Drawing.Size(75,23)
    $okButton.Text = 'Enter'
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
    $label.Text = 'Enter IP Address:'
    $form.Controls.Add($label)

    $textBox = New-Object System.Windows.Forms.TextBox
    $textBox.Location = New-Object System.Drawing.Point(10,40)
    $textBox.Size = New-Object System.Drawing.Size(260,20)
    $form.Controls.Add($textBox)

    #icon
    $iconBase64 = '/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAYEBAUEBAYFBQUGBgYHCQ4JCQgICRINDQoOFRIWFhUSFBQXGiEcFxgfGRQUHScdHyIjJSUlFhwpLCgkKyEkJST/2wBDAQYGBgkICREJCREkGBQYJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCT/wAARCAAgACADAREAAhEBAxEB/8QAGQABAAIDAAAAAAAAAAAAAAAACAEGAAUH/8QAMBAAAQMDAwEGAwkAAAAAAAAAAQIDBAAFBgcRMRIUFxghQZRU0dITIjJRVVZhcZH/xAAaAQACAwEBAAAAAAAAAAAAAAAFBwAEBgED/8QAKREAAQQBAgQGAwEAAAAAAAAAAQACAwQFETEVIZGhEhYyQVFSU9Hwgf/aAAwDAQACEQMRAD8A6Tk0t6345dZcZfQ+xEedbVtv0qCCQf8ARSKpxtksRsdsSB3WymcWxuI+ETO/nUT9fV7dr6aa/lnG/i7n9rNcRsfZR386h/uBXt2vpqeWcb+Luf2pxGx9kndLrzOyHArPdLk/9vMkNFTrnSE9R6iOB5elLPNV4692SKIaNB5dFoacjnwtc7dWlSUrSULSFJUNiCNwRQwHTmFYVI1KyPH9PcbduT9tgOSl7txWCynd1zb+uByaN4epZyFgRNcdPc6nkFTtyxwM8RA19katPsLuOrGZOF8lMYudonyEp2CEk/hHoCeAPlTHyuRixVQeHfZo/u6A1oHWZOf+piW23RbRAj2+CyliNHQG220jySkUoZpXyvMkh1J3WpYwMaGt2Ci6XOJZrdJuM55LMWM2XXVq4SkVIYXzSCKMak8guPeGNLnbBDjPMyn6q5klzrSzHU4GIbTrgShlBPKifIE8k/KnBjMfHi6mm53JG5P9sstYndZk16JI6eM4Xp/jjFqi5BZ1vH78l/tTe7zh5PPHoB+VLnLOvX7BmfE7T2Gh5BHqohgZ4Q4dVe4suPOjokxX2pDDg3Q40oKSofwR5Ggb2OY4teNCFda4OGoWh1EskzI8JvFpt6ULly45baStXSCdxyfSr2Jssr3I5pPSDzXhajMkTmN3KNXhx1A+Cg+7TTH82477HoUA4ZY+O6zw46gfBQfdpqebcd9j0KnDLHx3SS00sM3GMGtNouKEIlxWihxKFBQB6ieRzzS6zFmOzckmi9JPLoj1SN0cTWO3C//Z'
    $iconBytes = [Convert]::FromBase64String($iconBase64)
    $stream = [System.IO.MemoryStream]::new($iconBytes, 0, $iconBytes.Length)
    $form.Icon = [System.Drawing.Icon]::FromHandle(([System.Drawing.Bitmap]::new($stream).GetHIcon()))

    $form.Topmost = $true

    $form.Add_Shown({$textBox.Select()})
    $result = $form.ShowDialog()

    if ($result -eq [System.Windows.Forms.DialogResult]::OK)
    {
        $x = $textBox.Text
    }
    else
    {
        return
    }
    ###END IP FORM###

    ###START COPY FORM###
    $sync = [Hashtable]::Synchronized(@{})

    $copyScript = {
        #Sync setup
        $count = [PowerShell]::Create().AddScript({
            $sync.button.Enabled = $false
            $sync.button.text = "Transfer In Progress"

            #Variable prep
            $x = $sync.x
            $source = "\\$x\C$\scriptfolder\$env:USERNAME"
            $destinations = @()
            $sourceappend = @()
            $options = @()
            $logging = ">> c:\Utilities\pglog.txt"
            $deleteappend = " /MOVE"

            $destinations += {c:\notes}
            $destinations += {c:\notes\data}
            $destinations += {c:\notes\data}
            $destinations += {c:\notes\data}
            $destinations += {c:\notes\data}
            $destinations += {c:\notes\data\archive}
            $destinations += {"$env:USERPROFILE\desktop"}
            $destinations += {"$env:USERPROFILE\favorites"}
            $destinations += {"$env:USERPROFILE\Documents"}
            $destinations += {"$env:USERPROFILE\Downloads"}
            $destinations += {"$env:USERPROFILE\Pictures"}
            $destinations += {"$env:USERPROFILE\Music"}
            $destinations += {"$env:USERPROFILE\Videos"}
            $destinations += {"$env:APPDATA\Microsoft\Templates"}
            $destinations += {"$env:APPDATA\Microsoft\Sticky Notes"}
            $destinations += {"$env:APPDATA\IBM\Personal Communications"}
            $destinations += {"C:\Program Files\Ziegler"}
            $destinations += {"$env:APPDATA\Microsoft\Signatures"}
            $destinations += {"$env:APPDATA\Microsoft\Outlook"}
            $destinations += {"$env:LOCALAPPDATA\Google\Chrome\User Data\Default"}
            $destinations += {"$env:APPDATA\Mozilla\Firefox"}
            $destinations += {"C:\ProgramData\Caterpillar\SIMS DBS Upload Utility"}
            $destinations += {"$env:APPDATA\microsoft\windows\recent\automaticdestinations"}
            $destinations += {"$env:APPDATA\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar"}

            $sourceappend += {\}
            $sourceappend += {\}
            $sourceappend += {\}
            $sourceappend += {\}
            $sourceappend += {\}
            $sourceappend += {\archive}
            $sourceappend += {\desktop}
            $sourceappend += {\favorites}
            $sourceappend += {\mydocs}
            $sourceappend += {\mydownloads}
            $sourceappend += {\Pictures}
            $sourceappend += {\Music}
            $sourceappend += {\Videos}
            $sourceappend += {\templates}
            $sourceappend += {\stickynotes}
            $sourceappend += {\personalcomm}
            $sourceappend += {\stw network upload\}
            $sourceappend += {\Signatures}
            $sourceappend += {\type-ahead}
            $sourceappend += {\Chrome\Default}
            $sourceappend += {\Firefox}
            $sourceappend += {\DBSUploadUtil}
            $sourceappend += {\QuickAccess}
            $sourceappend += {\TaskbarPinnedItems}

            $options += {notes.ini /R:1 /W:2 /NJS /NJH /NP}
            $options += {*.nsf /xf aglib*.nsf /R:1 /W:2 /NJS /NJH /NP}
            $options += {desktop5.dsk /R:1 /W:2 /NJS /NJH /NP}
            $options += {desktop6.ndk /R:1 /W:2 /NJS /NJH /NP}
            $options += {*.id /R:1 /W:2 /MT /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /NJS /NJH /NP}
            $options += {/xf OnDemand* /R:1 /W:2 /E /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /MT /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /MT /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /MT /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /MT /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /MT /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /NJS /NJH /NP /mt}
            $options += {*.NK2 /R:1 /W:2 /E /NJS /NJH /NP /mt}
            $options += {/XD "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Code Cache" /r:1 /w:2 /E /MT /NJS /NJH /NP}
            $options += {/R:1 /W:2 /E /MT /NJS /NJH /NP}
            $options += {/r:1 /w:2 /E /MT /NJS /NJH /NP}
            $options += {/r:1 /w:2 /E /MT /NJS /NJH /NP}
            $options += {/r:1 /w:2 /E /MT /NJS /NJH /NP}

            powershell "Get-WmiObject Win32_printer | Select-Object name > $env:USERPROFILE\Desktop\UsersPrinters.txt" >> c:\Utilities\pglog.txt

            $sync.label.text = "Initiating transfer"

            for ($i = 0; $i -lt $destinations.length; $i++) {
                [int]$pct = ($i/($destinations.count+5))*100
                $sync.progressBar.Value = $pct

                $sync.label.text="Copying "
                $sync.label.text += $destinations[$i]

                $test = "robocopy "
                $test += $source
                $test += $sourceappend[$i]
                $test += " "
                $test += $destinations[$i]
                $test += " "
                $test += $options[$i]
                $test += $deleteappend
                $test += " "
                $test += $logging
            
                Write-Output $sync.label.text >> C:\Utilities\pglog.txt
                Write-Output I is equal to $i >> C:\Utilities\pglog.txt
                Write-Output $test >> C:\Utilities\pglog.txt
                powershell $test
            }

            ###Non-loopable functions###
            #IBM
            $i++
            [int]$pct = ($i/($destinations.count+5))*100
            $sync.progressbar.Value = $pct
            $sync.label.text="Copying IBM Files"
            if ((Get-CimInstance Win32_operatingsystem).OSArchitecture -eq "64-bit") 
            {
                robocopy $source\private-programfiles "$env:ProgramFiles(x86)\IBM\Client Access\Emulator\Private" /R:1 /W:2 /E /MT /NJS /NJH /NP >> c:\Utilities\pglog.txt
                robocopy $source\private "$env:APPDATA\IBM\Client Access\Emulator\Private" /R:1 /W:2 /E /MT /NJS /NJH /NP >> c:\Utilities\pglog.txt
            } else 
            {
                robocopy $source\private-programfiles "$env:ProgramFiles\IBM\Client Access\Emulator\Private" /R:1 /W:2 /E /MT /NJS /NJH /NP >> c:\Utilities\pglog.txt
                robocopy $source\private "$env:APPDATA\IBM\Client Access\Emulator\Private" /R:1 /W:2 /E /MT /NJS /NJH /NP >> c:\Utilities\pglog.txt
            }

            #ET
            $i++
            [int]$pct = ($i/($destinations.count+5))*100
            $sync.progressBar.Value = $pct
            $sync.label.text="Copying ET Files"
            if ((Get-CimInstance Win32_operatingsystem).OSArchitecture -eq "64-bit") {
                robocopy $source\etreports-files "$env:ProgramFiles(x86)\Caterpillar Electronic Technician\Files" /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt
                robocopy $source\etreports-downloads "$env:ProgramFiles(x86)\Caterpillar Electronic Technician\Downloads" /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt
                robocopy $source\etreports-public "%public%\Caterpillar\Electronic Technician" /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt
            } else {
                robocopy $source\etreports-files "C:\Program Files\Caterpillar Electronic Technician\Files" /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt
                robocopy $source\etreports-downloads "C:\Program Files\Caterpillar Electronic Technician\Downloads" /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt  
                robocopy $source\etreports-public "%public%\Caterpillar\Electronic Technician" /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt
            }


            #Taskbar
            $i++
            [int]$pct = ($i/($destinations.count+5))*100
            $sync.progressBar.Value = $pct
            $sync.label.Text="Importing Taskbar Registry Key"
            Copy-Item $source\TaskbarPinnedItemsBackup.reg C:\%temp%\TaskbarPinnedItemsBackup.reg
            reg import C:\%temp%\TaskbarPinnedItemsBackup.reg


            #Printers
            $i++
            [int]$pct = ($i/($destinations.count+5))*100
            $sync.progressBar.Value = $pct
            $sync.label.text="Importing printers"
            powershell -file "\\zieglercat.com\software\BranchPreCache\Technical_Documentation\putget\Add-Printers.ps1"


            ###END COPY###
            [int]$pct = 100
            $sync.progressBar.Value = $pct
            $sync.label.text = "Transfer complete"
            $sync.button.text = "Restart Transfer"
            $sync.button.Enabled = $true
        })

    $runspace = [RunspaceFactory]::CreateRunspace()
    $runspace.ApartmentState = "STA"
    $runspace.ThreadOptions = "ReuseThread"
    $runspace.Open()
    $runspace.SessionStateProxy.SetVariable("sync", $sync)

    $count.Runspace = $runspace
    $count.BeginInvoke()
    }

    ###FORM SETUP###
    $form = New-Object Windows.Forms.Form
    $form.ClientSize = New-Object Drawing.Size(400, 90)
    $form.Text = "Remote Get w/ Delete"
    $form.StartPosition = "CenterScreen"
    $form.FormBorderStyle = "FixedSingle"
    $form.MaximizeBox = $false

    #icon
    $iconBase64 = '/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAYEBAUEBAYFBQUGBgYHCQ4JCQgICRINDQoOFRIWFhUSFBQXGiEcFxgfGRQUHScdHyIjJSUlFhwpLCgkKyEkJST/2wBDAQYGBgkICREJCREkGBQYJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCT/wAARCAAgACADAREAAhEBAxEB/8QAGQABAAIDAAAAAAAAAAAAAAAACAEGAAUH/8QAMBAAAQMDAwEGAwkAAAAAAAAAAQIDBAAFBgcRMRIUFxghQZRU0dITIjJRVVZhcZH/xAAaAQACAwEBAAAAAAAAAAAAAAAFBwAEBgED/8QAKREAAQQBAgQGAwEAAAAAAAAAAQACAwQFETEVIZGhEhYyQVFSU9Hwgf/aAAwDAQACEQMRAD8A6Tk0t6345dZcZfQ+xEedbVtv0qCCQf8ARSKpxtksRsdsSB3WymcWxuI+ETO/nUT9fV7dr6aa/lnG/i7n9rNcRsfZR386h/uBXt2vpqeWcb+Luf2pxGx9kndLrzOyHArPdLk/9vMkNFTrnSE9R6iOB5elLPNV4692SKIaNB5dFoacjnwtc7dWlSUrSULSFJUNiCNwRQwHTmFYVI1KyPH9PcbduT9tgOSl7txWCynd1zb+uByaN4epZyFgRNcdPc6nkFTtyxwM8RA19katPsLuOrGZOF8lMYudonyEp2CEk/hHoCeAPlTHyuRixVQeHfZo/u6A1oHWZOf+piW23RbRAj2+CyliNHQG220jySkUoZpXyvMkh1J3WpYwMaGt2Ci6XOJZrdJuM55LMWM2XXVq4SkVIYXzSCKMak8guPeGNLnbBDjPMyn6q5klzrSzHU4GIbTrgShlBPKifIE8k/KnBjMfHi6mm53JG5P9sstYndZk16JI6eM4Xp/jjFqi5BZ1vH78l/tTe7zh5PPHoB+VLnLOvX7BmfE7T2Gh5BHqohgZ4Q4dVe4suPOjokxX2pDDg3Q40oKSofwR5Ggb2OY4teNCFda4OGoWh1EskzI8JvFpt6ULly45baStXSCdxyfSr2Jssr3I5pPSDzXhajMkTmN3KNXhx1A+Cg+7TTH82477HoUA4ZY+O6zw46gfBQfdpqebcd9j0KnDLHx3SS00sM3GMGtNouKEIlxWihxKFBQB6ieRzzS6zFmOzckmi9JPLoj1SN0cTWO3C//Z'
    $iconBytes = [Convert]::FromBase64String($iconBase64)
    $stream = [System.IO.MemoryStream]::new($iconBytes, 0, $iconBytes.Length)
    $form.Icon = [System.Drawing.Icon]::FromHandle(([System.Drawing.Bitmap]::new($stream).GetHIcon()))

    $button = New-Object Windows.Forms.Button
    $button.Location = New-Object Drawing.Point(5, 60)
    $button.Width = 385
    $button.Text = "Start Transfer"
    $button.Add_Click($copyScript)

    $label = New-Object Windows.Forms.Label
    $label.Location = New-Object Drawing.Point(5, 10)
    $label.Width = 385
    $label.Text = "Transfer not started"

    $progressBar1 = New-Object System.Windows.Forms.ProgressBar
    $progressBar1.Name = 'progressBar1'
    $progressBar1.Value = 0
    $progressBar1.Style="Continuous"
    $System_Drawing_Size = New-Object System.Drawing.Size
    $System_Drawing_Size.Width = 400 - 15
    $System_Drawing_Size.Height = 20
    $progressBar1.Size = $System_Drawing_Size
    $form.Controls.Add($progressBar1)
    $progressBar1.Left = 5
    $progressBar1.Top = 35

    ###Sync setup###
    $sync.button = $button
    $sync.button2 = $button2
    $sync.label = $label
    $sync.progressBar = $progressBar1
    $sync.x = $x
    $form.Controls.AddRange(@($sync.button, $sync.label, $sync.progressBar, $sync.x))

    #START THE FORM#
    [Windows.Forms.Application]::Run($form)

#------------------------END-----------------------------

}

###END PUTGET###