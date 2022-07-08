::6/22/22 TL Consolidated putget to one file w/ menu system, added prompts and delete function for remote get, and removed outdated lines
@Echo off
Setlocal
::Get windows Version numbers
For /f "tokens=2 delims=[]" %%G in ('ver') Do (set _version=%%G) 
For /f "tokens=2,3,4 delims=. " %%G in ('echo %_version%') Do (set _major=%%G& set _minor=%%H& set _build=%%I) 
::Echo Major version: %_major%  Minor Version: %_minor%.%_build%

::***** Common Code *****
:Main
echo ------Menu------	
echo 1.(P) - Put
echo 2.(G) - Get
set /p CHOICE="Enter choice: "
if %CHOICE%==1 goto Put
if %CHOICE%==2 goto Get
if %CHOICE%==P goto Put
if %CHOICE%==G goto Get
if %CHOICE%==p goto Put
if %CHOICE%==g goto Get
if %CHOICE%==put goto Put
if %CHOICE%==get goto Get
if %CHOICE%==Put goto Put
if %CHOICE%==Get goto Get

echo Invalid parameter, please try again
pause
goto Main

:Put
:PromptP
cls
echo ------Put------	
echo 1.(R) - Remote
echo 2.(L) - Local
set /p CHOICE="Enter choice: "
if %CHOICE%==1 goto RemoteP
if %CHOICE%==2 goto LocalP
if %CHOICE%==R goto RemoteP
if %CHOICE%==L goto LocalP
if %CHOICE%==r goto RemoteP
if %CHOICE%==l goto LocalP
if %CHOICE%==remote goto RemoteP
if %CHOICE%==local goto LocalP
if %CHOICE%==Remote goto RemoteP
if %CHOICE%==Local goto LocalP

echo Invalid parameter, please try again
pause
goto PromptP

:RemoteP
cls
echo ------Remote Put------
set /p IPA="Enter destination IP: "
set source=\\%IPA%\C$\scriptfolder\%username%

echo "Putting files on the server..."

::Lotus Notes files
echo "Lotus Notes..."
robocopy c:\notes %source% notes.ini /R:1 /W:2 /NJS /NJH /NP
robocopy c:\notes\data %source% *.nsf /xf aglib*.nsf /R:1 /W:2 /NJS /NJH /NP
robocopy c:\notes\data %source% desktop5.dsk /R:1 /W:2 /NJS /NJH /NP
robocopy c:\notes\data %source% desktop6.ndk /R:1 /W:2 /NJS /NJH /NP
robocopy c:\notes\data %source% *.id /R:1 /W:2 /MT /NJS /NJH /NP
robocopy c:\notes\data\archive %source%\archive /R:1 /W:2 /E /NJS /NJH /NP

::AS400 Connection registry export
echo "AS400 Connection String..."
::reg export "HKCU\Software\IBM\Client Access Express\CurrentVersion\Environments\My Connections" %source%\as400_conn.reg /y

::Get list of installed printers and create textfile on desktop
echo "Gathering Printers..."
powershell "Get-WmiObject Win32_printer | Select-Object name > $env:USERPROFILE\Desktop\UsersPrinters.txt"

::Basic user files
echo "IBM Emulator private..."
if %PROCESSOR_ARCHITECTURE% == AMD64 (
    robocopy "%ProgramFiles(x86)%\ibm\client access\emulator\private" %source%\private-programfiles /R:1 /W:2 /E /NJS /NJH /NP
    robocopy "%appData%\IBM\Client Access\Emulator\private" %source%\private /R:1 /W:2 /E /NJS /NJH /NP
) else (
    robocopy "%ProgramFiles%\ibm\client access\emulator\private" %source%\private-programfiles /R:1 /W:2 /E /NJS /NJH /NP
    robocopy "%appData%\IBM\Client Access\Emulator\private" %source%\private /R:1 /W:2 /E /NJS /NJH /NP
)

echo "Desktop..."
robocopy "%userprofile%\desktop" %source%\desktop /xf OnDemand* /R:1 /W:2 /E /NJS /NJH /NP 

echo "Favorites..."
robocopy "%userprofile%\favorites" %source%\favorites /R:1 /W:2 /E /NJS /NJH /NP 

echo "Documents..."
robocopy "%userprofile%\Documents" %source%\mydocs /R:1 /W:2 /E /MT /NJS /NJH /NP 

echo "Downloads..."
robocopy "%userprofile%\Downloads" %source%\mydownloads /R:1 /W:2 /E /MT /NJS /NJH /NP 

echo "Pictures..."
robocopy "%userprofile%\Pictures" %source%\Pictures /R:1 /W:2 /E /MT /NJS /NJH /NP 

echo "Music..."
robocopy "%userprofile%\Music" %source%\Music /R:1 /W:2 /E /MT /NJS /NJH /NP 

echo "Videos..."
robocopy "%userprofile%\Videos" %source%\Videos /R:1 /W:2 /E /MT /NJS /NJH /NP 

echo "Templates and Sticky Notes..."
robocopy "%appdata%\Microsoft\Templates" %source%\templates /R:1 /W:2 /E /NJS /NJH /NP
robocopy "%appdata%\Microsoft\Sticky Notes" %source%\stickynotes /R:1 /W:2 /E /NJS /NJH /NP

::ET/STW report files
echo "ET Files..."
if %PROCESSOR_ARCHITECTURE% == AMD64 (
    robocopy "ProgramFiles(x86)\Caterpillar Electronic Technician\Files" %source%\etreports-files /R:1 /W:2 /E /NJS /NJH /NP
    robocopy "ProgramFiles(x86)\Caterpillar Electronic Technician\Downloads" %source%\etreports-downloads /R:1 /W:2 /E /NJS /NJH /NP
    robocopy "%public%\Caterpillar\Electronic Technician" %source%\etreports-public /R:1 /W:2 /E /NJS /NJH /NP
) else (
    robocopy "C:\Program Files\Caterpillar Electronic Technician\Files" %source%\etreports-files /R:1 /W:2 /E /NJS /NJH /NP
    robocopy "C:\Program Files\Caterpillar Electronic Technician\Downloads" %source%\etreports-downloads /R:1 /W:2 /E /NJS /NJH /NP
    robocopy "%public%\Caterpillar\Electronic Technician" %source%\etreports-public /R:1 /W:2 /E /NJS /NJH /NP
)

::added a dir for copying from shop computers users complaining about missing stuff.
echo "Personalcomm..."
robocopy "%APPDATA%\IBM\Personal Communications" %source%\personalcomm /R:1 /W:2 /E /NJS /NJH /NP

::added stw network upload copy file
echo "STW Network Upload"
robocopy "C:\Program Files\Ziegler" "%source%\stw network upload" /R:1 /W:2 /E /NJS /NJH /NP

::copy Outlook stuff
echo "Outlook stuff..."
robocopy "%APPDATA%\Microsoft\Signatures" "%source%\Signatures" /R:1 /W:2 /E /NJS /NJH /NP /mt
robocopy "%APPDATA%\Microsoft\Outlook" "%source%\type-ahead" *.NK2 /R:1 /W:2 /E /NJS /NJH /NP /mt

::Chrome
echo "Chrome..."
::set chromesrc="%localappdata%\Google\Chrome\User Data\Default"
robocopy "%localappdata%\Google\Chrome\User Data\Default" "%source%\Chrome\Default" /XD "%localappdata%\Google\Chrome\User Data\Default\Code Cache" /r:1 /w:2 /E /MT /NJS /NJH /NP

::Firefox
echo "Firefox..."
robocopy "%AppData%\Mozilla\Firefox" "%source%\Firefox" /R:1 /W:2 /E /MT /NJS /NJH /NP

::DBS Upload Utility
echo "DBS Upload Util config.xml"
robocopy "C:\ProgramData\Caterpillar\SIMS DBS Upload Utility" "%source%\DBSUploadUtil" /r:1 /w:2 /E /MT /NJS /NJH /NP

::Quick Access
echo "Quick Access"
robocopy "%appdata%\microsoft\windows\recent\automaticdestinations" "%source%\QuickAccess" /r:1 /w:2 /E /MT /NJS /NJH /NP

::Pinned Task Bar icons
echo "Pinned Task Bar icons..."
robocopy "%AppData%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar" "%source%\TaskbarPinnedItems" /r:1 /w:2 /E /MT /NJS /NJH /NP
reg export "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" "%source%\TaskbarPinnedItemsBackup.reg" /y

del %USERPROFILE%\Desktop\UsersPrinters.txt
FOR /f "tokens=2-4 delims=/ " %%a in ('date /t') DO (set mydate=%%c-%%a-%%b)
FOR /f "tokens=1-2 delims=/:" %%a in ('time /t') DO (set mytime=%%a:%%b)

goto end

:LocalP
cls
echo ------Local Put------
set /p ZID="Enter Z-Number or E-ID: "
set source=C:\Users\%ZID%
set destination=\\img\Script-UserData\%ZID%

echo "Putting files on the server..."

::Lotus Notes files
echo "Lotus Notes..."
robocopy c:\notes %destination% notes.ini /R:1 /W:2 /NJS /NJH /NP
robocopy c:\notes\data %destination% *.nsf /xf aglib*.nsf /R:1 /W:2 /NJS /NJH /NP
robocopy c:\notes\data %destination% desktop5.dsk /R:1 /W:2 /NJS /NJH /NP
robocopy c:\notes\data %destination% desktop6.ndk /R:1 /W:2 /NJS /NJH /NP
robocopy c:\notes\data %destination% *.id /R:1 /W:2 /MT /NJS /NJH /NP
robocopy c:\notes\data\archive %destination%\archive /R:1 /W:2 /E /NJS /NJH /NP

::AS400 Connection registry export
echo "AS400 Connection String..."
::reg export "HKCU\Software\IBM\Client Access Express\CurrentVersion\Environments\My Connections" %destination%\as400_conn.reg /y

::Basic user files
echo "IBM Emulator private..."
if %PROCESSOR_ARCHITECTURE% == AMD64 (
    robocopy "%ProgramFiles(x86)%\ibm\client access\emulator\private" %destination%\private-programfiles /R:1 /W:2 /E /NJS /NJH /NP
    robocopy "%appData%\IBM\Client Access\Emulator\private" %destination%\private /R:1 /W:2 /E /NJS /NJH /NP
) else (
    robocopy "%ProgramFiles%\ibm\client access\emulator\private" %destination%\private-programfiles /R:1 /W:2 /E /NJS /NJH /NP
    robocopy "%appData%\IBM\Client Access\Emulator\private" %destination%\private /R:1 /W:2 /E /NJS /NJH /NP
)

echo "Desktop..."
robocopy "%source%\desktop" %destination%\desktop /xf OnDemand* /R:1 /W:2 /E /NJS /NJH /NP /MT

echo "Favorites..."
robocopy "%source%\favorites" %destination%\favorites /R:1 /W:2 /E /NJS /NJH /NP

echo "Documents..."
robocopy "%source%\Documents" %destination%\mydocs /R:1 /W:2 /E /MT /NJS /NJH /NP

echo "Downloads..."
robocopy "%source%\Downloads" %destination%\mydownloads /R:1 /W:2 /E /MT /NJS /NJH /NP

echo "Pictures..."
robocopy "%source%\Pictures" %destination%\Pictures /R:1 /W:2 /E /MT /NJS /NJH /NP

echo "Music..."
robocopy "%source%\Music" %destination%\Music /R:1 /W:2 /E /MT /NJS /NJH /NP

echo "Videos..."
robocopy "%source%\Videos" %destination%\Videos /R:1 /W:2 /E /MT /NJS /NJH /NP

echo "Templates and Sticky Notes..."
robocopy "%source%\AppData\Roaming\Microsoft\Templates" %destination%\templates /R:1 /W:2 /E /NJS /NJH /NP
robocopy "%source%\AppData\Roaming\Microsoft\Sticky Notes" %destination%\stickynotes /R:1 /W:2 /E /NJS /NJH /NP

::ET/STW report files
echo "ET Files..."
if %PROCESSOR_ARCHITECTURE% == AMD64 (
    robocopy "ProgramFiles(x86)\Caterpillar Electronic Technician\Files" %destination%\etreports-files /R:1 /W:2 /E /NJS /NJH /NP
    robocopy "ProgramFiles(x86)\Caterpillar Electronic Technician\Downloads" %destination%\etreports-downloads /R:1 /W:2 /E /NJS /NJH /NP
    robocopy "%public%\Caterpillar\Electronic Technician" %destination%\etreports-public /R:1 /W:2 /E /NJS /NJH /NP
) else (
    robocopy "C:\Program Files\Caterpillar Electronic Technician\Files" %destination%\etreports-files /R:1 /W:2 /E /NJS /NJH /NP
    robocopy "C:\Program Files\Caterpillar Electronic Technician\Downloads" %destination%\etreports-downloads /R:1 /W:2 /E /NJS /NJH /NP
    robocopy "%public%\Caterpillar\Electronic Technician" %destination%\etreports-public /R:1 /W:2 /E /NJS /NJH /NP
)

::added a dir for copying from shop computers users complaining about missing stuff.
echo "Personalcomm..."
robocopy "%APPDATA%\IBM\Personal Communications" %destination%\personalcomm /R:1 /W:2 /E /NJS /NJH /NP

::added stw network upload copy file
echo "STW Network Upload"
robocopy "C:\Program Files\Ziegler" "%destination%\stw network upload" /R:1 /W:2 /E /NJS /NJH /NP

::copy Outlook stuff
echo "Outlook stuff..."
robocopy "%source%\AppData\Roaming\Microsoft\Signatures" "%destination%\Signatures" /R:1 /W:2 /E /NJS /NJH /NP
robocopy "%source%\AppData\Roaming\Microsoft\Outlook" "%destination%\type-ahead" *.NK2 /R:1 /W:2 /E /NJS /NJH /NP

::Chrome
echo "Chrome..."
::set chromesrc="%source%\AppData\Local\Google\Chrome\User Data\Default"
robocopy "%source%\AppData\Local\Google\Chrome\User Data\Default" "%destination%\Chrome\Default" /XD "%source%\AppData\Local\Google\Chrome\User Data\Default\Code Cache" /r:1 /w:2 /E /MT /NJS /NJH /NP

::Firefox
echo "Firefox..."
robocopy "%source%\AppData\Roaming\Mozilla\Firefox" "%destination%\Firefox" /R:1 /W:2 /E /MT /NJS /NJH /NP

::DBS Upload Utility
echo "DBS Upload Util config.xml"
robocopy "C:\ProgramData\Caterpillar\SIMS DBS Upload Utility" "%destination%\DBSUploadUtil" /r:1 /w:2 /E /MT /NJS /NJH /NP

::Quick Access
echo "Quick Access"
robocopy "%source%\AppData\Roaming\microsoft\windows\recent\automaticdestinations" "%destination%\QuickAccess" /r:1 /w:2 /E /MT /NJS /NJH /NP

::Pinned Task Bar icons
echo "Pinned Task Bar icons..."
robocopy "%source%\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar" "%destination%\TaskbarPinnedItems" /r:1 /w:2 /E /MT /NJS /NJH /NP
reg export "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" "%destination%\TaskbarPinnedItemsBackup.reg" /y

del %source%\Desktop\UsersPrinters.txt
FOR /f "tokens=2-4 delims=/ " %%a in ('date /t') DO (set mydate=%%c-%%a-%%b)
FOR /f "tokens=1-2 delims=/:" %%a in ('time /t') DO (set mytime=%%a:%%b)

goto end


:Get
:PromptG
cls
echo ------Get------	
echo 1.(R) - Remote
echo 2.(L) - Local
set /p CHOICE="Enter choice: "
if %CHOICE%==1 goto RemoteG
if %CHOICE%==2 goto LocalG
if %CHOICE%==R goto RemoteG
if %CHOICE%==L goto LocalG
if %CHOICE%==r goto RemoteG
if %CHOICE%==l goto LocalG
if %CHOICE%==remote goto RemoteG
if %CHOICE%==local goto LocalG
if %CHOICE%==Remote goto RemoteG
if %CHOICE%==Local goto LocalG

echo Invalid parameter, please try again
pause
goto PromptG

:RemoteG
cls
echo ------Remote Get------
echo 1.(S) - Standard
echo 2.(D) - Delete (Deletes scriptfolder as files are transferred)
set /p CHOICE="Enter choice: "
if %CHOICE%==1 goto Standard
if %CHOICE%==2 goto Delete
if %CHOICE%==S goto Standard
if %CHOICE%==D goto Delete
if %CHOICE%==s goto Standard
if %CHOICE%==d goto Delete
if %CHOICE%==standard goto Standard
if %CHOICE%==delete goto Delete
if %CHOICE%==Standard goto Standard
if %CHOICE%==Delete goto Delete

:Standard
cls
echo ------Standard Remote Get------
set /p IPA="Enter destination IP: "
set source=\\%IPA%\C$\scriptfolder\%username%

::Lotus Notes files
robocopy %source% c:\notes notes.ini /R:1 /W:2 /NJS /NJH /NP
robocopy %source% c:\notes\data *.nsf /R:1 /W:2 /NJS /NJH /NP
robocopy %source% c:\notes\data desktop5.dsk /R:1 /W:2 /NJS /NJH /NP
robocopy %source% c:\notes\data desktop6.ndk /R:1 /W:2 /NJS /NJH /NP
robocopy %source% c:\notes\data *.id /R:1 /W:2 /NJS /NJH /NP
robocopy %source%\archive c:\notes\data\archive /R:1 /W:2 /E /NJS /NJH /NP

::Import AS400 Connections
::copy %source%\as400_conn.reg %temp%
::reg import %temp%\as400_conn.reg

::Re-import Printers
powershell -file "\\zieglercat.com\software\BranchPreCache\Technical_Documentation\putget\Add-Printers.ps1"
del %USERPROFILE%\Desktop\UsersPrinters.txt

::Basic user files
echo "IBM Emulator private..."
if %PROCESSOR_ARCHITECTURE% == AMD64 (
    robocopy %source%\private-programfiles "%ProgramFiles(x86)%\IBM\Client Access\Emulator\Private" /R:1 /W:2 /E /MT /NJS /NJH /NP
    robocopy %source%\private "%APPDATA%\IBM\Client Access\Emulator\Private" /R:1 /W:2 /E /MT /NJS /NJH /NP
) else (
    robocopy %source%\private-programfiles "%ProgramFiles%\IBM\Client Access\Emulator\Private" /R:1 /W:2 /E /MT /NJS /NJH /NP
    robocopy %source%\private "%APPDATA%\IBM\Client Access\Emulator\Private" /R:1 /W:2 /E /MT /NJS /NJH /NP
)

robocopy %source%\desktop %USERPROFILE%\Desktop /R:1 /W:2 /E /MT /NJS /NJH /NP

robocopy %source%\favorites %USERPROFILE%\Favorites /R:1 /W:2 /E /MT /NJS /NJH /NP
robocopy %source%\mydocs %USERPROFILE%\Documents /R:1 /W:2 /E /MT /NJS /NJH /NP
robocopy %source%\mydownloads %USERPROFILE%\Downloads /R:1 /W:2 /E /MT /NJS /NJH /NP
robocopy %source%\Pictures %USERPROFILE%\Pictures /R:1 /W:2 /E /MT /NJS /NJH /NP
robocopy %source%\Music %USERPROFILE%\Music /R:1 /W:2 /E /MT /NJS /NJH /NP
robocopy %source%\Videos %USERPROFILE%\Videos /R:1 /W:2 /E /MT /NJS /NJH /NP
robocopy %source%\templates %APPDATA%\Microsoft\Templates /R:1 /W:2 /E /MT /NJS /NJH /NP
robocopy %source%\stickynotes "%APPDATA%\Microsoft\Sticky Notes" /R:1 /W:2 /E /MT /NJS /NJH /NP

::ET/STW report files
if %PROCESSOR_ARCHITECTURE% == AMD64 (
    robocopy %source%\etreports-files "%ProgramFiles(x86)%\Caterpillar Electronic Technician\Files" /R:1 /W:2 /E /NJS /NJH /NP
    robocopy %source%\etreports-downloads "%ProgramFiles(x86)%\Caterpillar Electronic Technician\Downloads" /R:1 /W:2 /E /NJS /NJH /NP  
    robocopy %source%\etreports-public "%public%\Caterpillar\Electronic Technician" /R:1 /W:2 /E /NJS /NJH /NP
) else (
    robocopy %source%\etreports-files "C:\Program Files\Caterpillar Electronic Technician\Files" /R:1 /W:2 /E /NJS /NJH /NP
    robocopy %source%\etreports-downloads "C:\Program Files\Caterpillar Electronic Technician\Downloads" /R:1 /W:2 /E /NJS /NJH /NP  
    robocopy %source%\etreports-public "%public%\Caterpillar\Electronic Technician" /R:1 /W:2 /E /NJS /NJH /NP
)

::added a dir for copying from shop computers users complaining about missing stuff.
robocopy %source%\personalcomm "%APPDATA%\IBM\Personal Communications" /R:1 /W:2 /E /MT /NJS /NJH /NP

::added stw network upload copy file
robocopy "%source%\stw network upload" "C:\Program Files\Ziegler" /R:1 /W:2 /E /MT /NJS /NJH /NP

::copy Outlook stuff
echo "Outlook stuff..."
robocopy "%source%\Signatures" "%APPDATA%\Microsoft\Signatures" /R:1 /W:2 /E /NJS /NJH /NP
robocopy "%source%\type-ahead" "%APPDATA%\Microsoft\Outlook" *.NK2 /R:1 /W:2 /NJS /NJH /NP

::Chrome
robocopy "%source%\Chrome\Default" "%localappdata%\Google\Chrome\User Data\Default" /r:1 /w:2 /mir /MT /NJS /NJH /NP

::Firefox
robocopy "%source%\Firefox" "%AppData%\Mozilla\Firefox" /R:1 /W:2 /mir /MT /NJS /NJH /NP

::DBSUploadUtil
robocopy "%source%\DBSUploadUtil" "C:\ProgramData\Caterpillar\SIMS DBS Upload Utility" /R:1 /W:2 /mir /MT /NJS /NJH /NP

::Quick Access
robocopy "%source%\QuickAccess" "%appdata%\microsoft\windows\recent\automaticdestinations" /r:1 /w:2 /E /MT /NJS /NJH /NP

::Pinned Task Bar icons
robocopy "%source%\TaskbarPinnedItems" "%AppData%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar" /r:1 /w:2 /E /MT /NJS /NJH /NP
copy %source%\TaskbarPinnedItemsBackup.reg %temp%
reg import %temp%\TaskbarPinnedItemsBackup.reg

::Fix AS400.ws file
::powershell -file Update-AS400.ws.ps1

FOR /f "tokens=2-4 delims=/ " %%a in ('date /t') DO (set mydate=%%c-%%a-%%b)
FOR /f "tokens=1-2 delims=/:" %%a in ('time /t') DO (set mytime=%%a:%%b)

goto end


:Delete
cls
echo ------Delete Remote Get------
set /p IPA="Enter destination IP: "
set source=\\%IPA%\C$\scriptfolder\%username%

::Lotus Notes files
robocopy %source% c:\notes notes.ini /R:1 /W:2 /NJS /NJH /NP /MOVE
robocopy %source% c:\notes\data *.nsf /R:1 /W:2 /NJS /NJH /NP /MOVE
robocopy %source% c:\notes\data desktop5.dsk /R:1 /W:2 /NJS /NJH /NP /MOVE
robocopy %source% c:\notes\data desktop6.ndk /R:1 /W:2 /NJS /NJH /NP /MOVE
robocopy %source% c:\notes\data *.id /R:1 /W:2 /NJS /NJH /NP /MOVE
robocopy %source%\archive c:\notes\data\archive /R:1 /W:2 /E /NJS /NJH /NP /MOVE

::Import AS400 Connections
::copy %source%\as400_conn.reg %temp%
::reg import %temp%\as400_conn.reg

::Re-import Printers
powershell -file "\\zieglercat.com\software\BranchPreCache\Technical_Documentation\putget\Add-Printers.ps1"
del %USERPROFILE%\Desktop\UsersPrinters.txt

::Basic user files
echo "IBM Emulator private..."
if %PROCESSOR_ARCHITECTURE% == AMD64 (
    robocopy %source%\private-programfiles "%ProgramFiles(x86)%\IBM\Client Access\Emulator\Private" /R:1 /W:2 /E /MT /NJS /NJH /NP /MOVE
    robocopy %source%\private "%APPDATA%\IBM\Client Access\Emulator\Private" /R:1 /W:2 /E /MT /NJS /NJH /NP /MOVE
) else (
    robocopy %source%\private-programfiles "%ProgramFiles%\IBM\Client Access\Emulator\Private" /R:1 /W:2 /E /MT /NJS /NJH /NP /MOVE
    robocopy %source%\private "%APPDATA%\IBM\Client Access\Emulator\Private" /R:1 /W:2 /E /MT /NJS /NJH /NP /MOVE
)

robocopy %source%\desktop %USERPROFILE%\Desktop /R:1 /W:2 /E /MT /NJS /NJH /NP /MOVE

robocopy %source%\favorites %USERPROFILE%\Favorites /R:1 /W:2 /E /MT /NJS /NJH /NP /MOVE
robocopy %source%\mydocs %USERPROFILE%\Documents /R:1 /W:2 /E /MT /NJS /NJH /NP /MOVE
robocopy %source%\mydownloads %USERPROFILE%\Downloads /R:1 /W:2 /E /MT /NJS /NJH /NP /MOVE
robocopy %source%\Pictures %USERPROFILE%\Pictures /R:1 /W:2 /E /MT /NJS /NJH /NP /MOVE
robocopy %source%\Music %USERPROFILE%\Music /R:1 /W:2 /E /MT /NJS /NJH /NP /MOVE
robocopy %source%\Videos %USERPROFILE%\Videos /R:1 /W:2 /E /MT /NJS /NJH /NP /MOVE
robocopy %source%\templates %APPDATA%\Microsoft\Templates /R:1 /W:2 /E /MT /NJS /NJH /NP /MOVE
robocopy %source%\stickynotes "%APPDATA%\Microsoft\Sticky Notes" /R:1 /W:2 /E /MT /NJS /NJH /NP /MOVE

::ET/STW report files
if %PROCESSOR_ARCHITECTURE% == AMD64 (
    robocopy %source%\etreports-files "%ProgramFiles(x86)%\Caterpillar Electronic Technician\Files" /R:1 /W:2 /E /NJS /NJH /NP /MOVE
    robocopy %source%\etreports-downloads "%ProgramFiles(x86)%\Caterpillar Electronic Technician\Downloads" /R:1 /W:2 /E /NJS /NJH /NP /MOVE
    robocopy %source%\etreports-public "%public%\Caterpillar\Electronic Technician" /R:1 /W:2 /E /NJS /NJH /NP /MOVE
) else (
    robocopy %source%\etreports-files "C:\Program Files\Caterpillar Electronic Technician\Files" /R:1 /W:2 /E /NJS /NJH /NP /MOVE
    robocopy %source%\etreports-downloads "C:\Program Files\Caterpillar Electronic Technician\Downloads" /R:1 /W:2 /E /NJS /NJH /NP /MOVE
    robocopy %source%\etreports-public "%public%\Caterpillar\Electronic Technician" /R:1 /W:2 /E /NJS /NJH /NP /MOVE
)

::added a dir for copying from shop computers users complaining about missing stuff.
robocopy %source%\personalcomm "%APPDATA%\IBM\Personal Communications" /R:1 /W:2 /E /MT /NJS /NJH /NP /MOVE

::added stw network upload copy file
robocopy "%source%\stw network upload" "C:\Program Files\Ziegler" /R:1 /W:2 /E /MT /NJS /NJH /NP /MOVE

::copy Outlook stuff
echo "Outlook stuff..."
robocopy "%source%\Signatures" "%APPDATA%\Microsoft\Signatures" /R:1 /W:2 /E /NJS /NJH /NP /MOVE
robocopy "%source%\type-ahead" "%APPDATA%\Microsoft\Outlook" *.NK2 /R:1 /W:2 /NJS /NJH /NP /MOVE

::Chrome
robocopy "%source%\Chrome\Default" "%localappdata%\Google\Chrome\User Data\Default" /r:1 /w:2 /mir /MT /NJS /NJH /NP /MOVE

::Firefox
robocopy "%source%\Firefox" "%AppData%\Mozilla\Firefox" /R:1 /W:2 /mir /MT /NJS /NJH /NP /MOVE

::DBSUploadUtil
robocopy "%source%\DBSUploadUtil" "C:\ProgramData\Caterpillar\SIMS DBS Upload Utility" /R:1 /W:2 /mir /MT /NJS /NJH /NP /MOVE

::Quick Access
robocopy "%source%\QuickAccess" "%appdata%\microsoft\windows\recent\automaticdestinations" /r:1 /w:2 /E /MT /NJS /NJH /NP /MOVE

::Pinned Task Bar icons
robocopy "%source%\TaskbarPinnedItems" "%AppData%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar" /r:1 /w:2 /E /MT /NJS /NJH /NP /MOVE
copy %source%\TaskbarPinnedItemsBackup.reg %temp%
reg import %temp%\TaskbarPinnedItemsBackup.reg

::Fix AS400.ws file
::powershell -file Update-AS400.ws.ps1

FOR /f "tokens=2-4 delims=/ " %%a in ('date /t') DO (set mydate=%%c-%%a-%%b)
FOR /f "tokens=1-2 delims=/:" %%a in ('time /t') DO (set mytime=%%a:%%b)

goto end


:LocalG
cls
echo ------Local Get------
set /p ZID="Enter Z-Number or E-ID: "
set source=\\img\Script-UserData\%ZID%
set destination=C:\Users\%ZID%

::Lotus Notes files
robocopy %source% c:\notes notes.ini /R:1 /W:2 /NJS /NJH /NP
robocopy %source% c:\notes\data *.nsf /R:1 /W:2 /NJS /NJH /NP
robocopy %source% c:\notes\data desktop5.dsk /R:1 /W:2 /NJS /NJH /NP
robocopy %source% c:\notes\data desktop6.ndk /R:1 /W:2 /NJS /NJH /NP
robocopy %source% c:\notes\data *.id /R:1 /W:2 /NJS /NJH /NP
robocopy %source%\archive c:\notes\data\archive /R:1 /W:2 /E /NJS /NJH /NP

::Import AS400 Connections
::copy %source%\as400_conn.reg %temp%
::reg import %temp%\as400_conn.reg

::Re-import Printers
powershell -file "\\zieglercat.com\software\BranchPreCache\Technical_Documentation\putget\Add-Printers.ps1"
del %destination%\Desktop\UsersPrinters.txt

::Basic user files
echo "IBM Emulator private..."
if %PROCESSOR_ARCHITECTURE% == AMD64 (
    robocopy %source%\private-programfiles "%ProgramFiles(x86)%\IBM\Client Access\Emulator\Private" /R:1 /W:2 /E /MT /NJS /NJH /NP
    robocopy %source%\private "%destination%\AppData\Roaming\IBM\Client Access\Emulator\Private" /R:1 /W:2 /E /MT /NJS /NJH /NP
) else (
    robocopy %source%\private-programfiles "%ProgramFiles%\IBM\Client Access\Emulator\Private" /R:1 /W:2 /E /MT /NJS /NJH /NP
    robocopy %source%\private "%destination%\AppData\Roaming\IBM\Client Access\Emulator\Private" /R:1 /W:2 /E /MT /NJS /NJH /NP
)

robocopy %source%\desktop %destination%\Desktop /R:1 /W:2 /E /MT /NJS /NJH /NP

robocopy %source%\favorites %destination%\Favorites /R:1 /W:2 /E /MT /NJS /NJH /NP
robocopy %source%\mydocs %destination%\Documents /R:1 /W:2 /E /MT /NJS /NJH /NP
robocopy %source%\mydownloads %destination%\Downloads /R:1 /W:2 /E /MT /NJS /NJH /NP
robocopy %source%\Pictures %destination%\Pictures /R:1 /W:2 /E /MT /NJS /NJH /NP
robocopy %source%\Music %destination%\Music /R:1 /W:2 /E /MT /NJS /NJH /NP
robocopy %source%\Videos %destination%\Videos /R:1 /W:2 /E /MT /NJS /NJH /NP
robocopy %source%\templates %destination%\AppData\Roaming\Microsoft\Templates /R:1 /W:2 /E /MT /NJS /NJH /NP
robocopy %source%\stickynotes "%destination%\AppData\Roaming\Microsoft\Sticky Notes" /R:1 /W:2 /E /MT /NJS /NJH /NP

::ET/STW report files
if %PROCESSOR_ARCHITECTURE% == AMD64 (
    robocopy %source%\etreports-files "%ProgramFiles(x86)%\Caterpillar Electronic Technician\Files" /R:1 /W:2 /E /NJS /NJH /NP
    robocopy %source%\etreports-downloads "%ProgramFiles(x86)%\Caterpillar Electronic Technician\Downloads" /R:1 /W:2 /E /NJS /NJH /NP  
    robocopy %source%\etreports-public "%public%\Caterpillar\Electronic Technician" /R:1 /W:2 /E /NJS /NJH /NP
) else (
    robocopy %source%\etreports-files "C:\Program Files\Caterpillar Electronic Technician\Files" /R:1 /W:2 /E /NJS /NJH /NP
    robocopy %source%\etreports-downloads "C:\Program Files\Caterpillar Electronic Technician\Downloads" /R:1 /W:2 /E /NJS /NJH /NP  
    robocopy %source%\etreports-public "%public%\Caterpillar\Electronic Technician" /R:1 /W:2 /E /NJS /NJH /NP
)

::added a dir for copying from shop computers users complaining about missing stuff.
robocopy %source%\personalcomm "%destination%\AppData\Roaming\IBM\Personal Communications" /R:1 /W:2 /E /MT /NJS /NJH /NP

::copy Outlook stuff
echo "Outlook stuff..."
robocopy "%source%\Signatures" "%destination%\AppData\Roaming\Microsoft\Signatures" /R:1 /W:2 /E /NJS /NJH /NP
robocopy "%source%\type-ahead" "%destination%\AppData\Roaming\Microsoft\Outlook" *.NK2 /R:1 /W:2 /NJS /NJH /NP

::Chrome
robocopy "%source%\Chrome\Default" "%destination%\AppData\Local\Google\Chrome\User Data\Default" /r:1 /w:2 /mir /mt /NJS /NJH /NP

::Firefox
robocopy "%source%\Firefox" "%destination%\AppData\Roaming\Mozilla\Firefox" /R:1 /W:2 /mir /mt /NJS /NJH /NP

::DBSUploadUtil
robocopy "%source%\DBSUploadUtil" "C:\ProgramData\Caterpillar\SIMS DBS Upload Utility" /R:1 /W:2 /mir /mt /NJS /NJH /NP

::Quick Access
robocopy "%source%\QuickAccess" "%destination%\AppData\Roaming\microsoft\windows\recent\automaticdestinations" /r:1 /w:2 /E /mt /NJS /NJH /NP

::Pinned Task Bar icons
robocopy "%source%\TaskbarPinnedItems" "%destination%\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar" /r:1 /w:2 /E /MT /NJS /NJH /NP
copy %source%\TaskbarPinnedItemsBackup.reg %temp%
reg import %temp%\TaskbarPinnedItemsBackup.reg

FOR /f "tokens=2-4 delims=/ " %%a in ('date /t') DO (set mydate=%%c-%%a-%%b)
FOR /f "tokens=1-2 delims=/:" %%a in ('time /t') DO (set mytime=%%a:%%b)

goto end

:end
cls
echo Script complete
msg * "Transfer Completed"
pause

