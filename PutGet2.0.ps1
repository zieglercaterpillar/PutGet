Add-Type -AssemblyName System.Windows.Forms
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

$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $x = $listBox.SelectedItems
}
else
{
    return -1
}

if ($x -eq "Local Put")
{
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

$form.Add_Shown({$textBox.Select()})
$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $x = $textBox.Text
}
else
{
    return -1
}
#---Local Put Starts here---#
   
}
elseif ($x -eq "Local Get")
{
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

$form.Topmost = $true

$form.Add_Shown({$textBox.Select()})
$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $x = $textBox.Text
}
else
{
    return -1
}
#---Local Get Starts here---#   


}
elseif ($x -eq "Remote Put")
{
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

$form.Topmost = $true

$form.Add_Shown({$textBox.Select()})
$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $x = $textBox.Text
}
else
{
    return -1
}
#---Remote Put Starts here---#
$source = "\\$x\C$\scriptfolder\$env:USERNAME"
$destinations = @()
$sourceappend = @()
$options = @()
$logging = ">> c:\Utilities\pglog.txt"

powershell "Get-WmiObject Win32_printer | Select-Object name > $env:USERPROFILE\Desktop\UsersPrinters.txt" >> c:\Utilities\pglog.txt

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
$destinations += {"%localappdata%\Google\Chrome\User Data\Default"}
$destinations += {"$env:APPDATA\Mozilla\Firefox"}
$destinations += {"C:\ProgramData\Caterpillar\SIMS DBS Upload Utility"}
$destinations += {"$env:APPDATA\microsoft\windows\recent\automaticdestinations"}
$destinations += {"$env:APPDATA\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar"}
$destinations += {}
$destinations += {}
$destinations += {}
$destinations += {}


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
$sourceappend += {\stw network upload}
$sourceappend += {\Signatures}
$sourceappend += {\type-ahead}
$sourceappend += {\Chrome\Default}
$sourceappend += {\Firefox}
$sourceappend += {\DBSUploadUtil}
$sourceappend += {\QuickAccess}
$sourceappend += {\TaskbarPinnedItems}
$sourceappend += {}
$sourceappend += {}
$sourceappend += {}
$sourceappend += {}


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
$options += {/XD "%localappdata%\Google\Chrome\User Data\Default\Code Cache" /r:1 /w:2 /E /MT /NJS /NJH /NP}
$options += {/R:1 /W:2 /E /MT /NJS /NJH /NP}
$options += {/r:1 /w:2 /E /MT /NJS /NJH /NP}
$options += {/r:1 /w:2 /E /MT /NJS /NJH /NP}
$options += {/r:1 /w:2 /E /MT /NJS /NJH /NP}
$options += {}
$options += {}
$options += {}
$options += {}
$options += {}

#-----------FORM----------------------
$Title = "Putting Files on Remote Host"
#winform dimensions
$height=150
$width=400
#winform background color
$color = "White"

#create the form
$form1 = New-Object System.Windows.Forms.Form
$form1.Text = $title
$form1.Height = $height
$form1.Width = $width
$form1.BackColor = $color

$form1.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle
#display center screen
$form1.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(150,75)
$cancelButton.Size = New-Object System.Drawing.Size(75,23)
$cancelButton.Text = 'Cancel'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form1.CancelButton = $cancelButton
$form1.Controls.Add($cancelButton)

# create label
$label1 = New-Object system.Windows.Forms.Label
$label1.Text = "not started"
$label1.Left=5
$label1.Top= 10
$label1.Width= $width - 20
#adjusted height to accommodate progress bar
$label1.Height=15
$label1.Font= "Verdana"
#optional to show border
#$label1.BorderStyle=1

#add the label to the form
$form1.controls.add($label1)

$progressBar1 = New-Object System.Windows.Forms.ProgressBar
$progressBar1.Name = 'progressBar1'
$progressBar1.Value = 0
$progressBar1.Style="Continuous"

$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Width = $width - 40
$System_Drawing_Size.Height = 20
$progressBar1.Size = $System_Drawing_Size

$progressBar1.Left = 5
$progressBar1.Top = 40

$form1.Controls.Add($progressBar1)

$form1.Show()| out-null

#give the form focus
$form1.Focus() | out-null

#update the form
$label1.text="Preparing to transfer files"
$form1.Refresh()

start-sleep -Seconds 1
#----------------------------FORM-------------------------

$i = 0
for (; $i -lt $destinations.length; $i++)
{
    [int]$pct = ($i/($destinations.count+5))*100
    $progressbar1.Value = $pct

    $label1.text="Copying "
    $label1.text += $destinations[$i]
    $form1.Refresh()

    $test = "robocopy "
    $test += $destinations[$i]
    $test += " "
    $test += $source
    $test += $sourceappend[$i]
    $test += " "
    $test += $options[$i]
    $test += " "
    $test += $logging
    powershell $test
}

#IBM
$i++
[int]$pct = ($i/($destinations.count+5))*100
$progressbar1.Value = $pct

$label1.text="Copying IBM Files"
$form1.Refresh()
if ((Get-CimInstance Win32_operatingsystem).OSArchitecture -eq "64-bit") 
{
    robocopy "%ProgramFiles(x86)%\ibm\client access\emulator\private" $source\private-programfiles /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt
    robocopy "$env:APPDATA\IBM\Client Access\Emulator\private" $source\private /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt
} else 
{
    robocopy "%ProgramFiles%\ibm\client access\emulator\private" $source\private-programfiles /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt
    robocopy "$env:APPDATA\IBM\Client Access\Emulator\private" $source\private /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt
}


#ET
$i++
[int]$pct = ($i/($destinations.count+5))*100
$progressbar1.Value = $pct

$label1.text="Copying ET Files"
$form1.Refresh()
if ((Get-CimInstance Win32_operatingsystem).OSArchitecture -eq "64-bit") {
    robocopy "ProgramFiles(x86)\Caterpillar Electronic Technician\Files" $source\etreports-files /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt
    robocopy "ProgramFiles(x86)\Caterpillar Electronic Technician\Downloads" $source\etreports-downloads /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt
    robocopy "%public%\Caterpillar\Electronic Technician" $source\etreports-public /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt
} else {
    robocopy "C:\Program Files\Caterpillar Electronic Technician\Files" $source\etreports-files /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt
    robocopy "C:\Program Files\Caterpillar Electronic Technician\Downloads" $source\etreports-downloads /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt
    robocopy "%public%\Caterpillar\Electronic Technician" $source\etreports-public /R:1 /W:2 /E /NJS /NJH /NP >> c:\Utilities\pglog.txt
}


#Taskbar
$i++
[int]$pct = ($i/($destinations.count+5))*100
$progressbar1.Value = $pct

$label1.text="Exporting Taskbar Registry Key"
$form1.Refresh()
reg export "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" "$source\TaskbarPinnedItemsBackup.reg" /y >> c:\Utilities\pglog.txt


#Printers
$i++
[int]$pct = ($i/($destinations.count+5))*100
$progressbar1.Value = $pct

$label1.text="Deleting temporary printer file"
$form1.Refresh()
del $env:USERPROFILE\Desktop\UsersPrinters.txt

$form1.Close()
#------------------------END-----------------------------

}
elseif ($x -eq "Remote Get")
{
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

$form.Topmost = $true

$form.Add_Shown({$textBox.Select()})
$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $x = $textBox.Text
}
else
{
    return -1
}
#---Remote Get Starts here---#

}
elseif ($x -eq "Remote Get w/ Delete")
{
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

$form.Topmost = $true

$form.Add_Shown({$textBox.Select()})
$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $x = $textBox.Text
}
else
{
    return -1
}
#---Remote Get w/Delete Starts here---#

}

