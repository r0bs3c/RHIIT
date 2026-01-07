
# Querying the shell for the path of the known folder is more robust because it works when the folder has been re-directed:

$DesktopPath = [Environment]::GetFolderPath('Desktop')
$DocumentPath = [Environment]::GetFolderPath('MyDocuments')

mkdir $UserDocumentPath\Desktop_Dateien
New-Item -Path $UserDocumentPath\Desktop_Dateien\Errors.txt

#Move Files
try {
  Move-Item -Path "$UserDesktopPath\*.*" -Destination "$UserDocumentPath\Desktop_Dateien" -Exclude *.lnk
}
catch {
  Out-File -Path "$UserDocumentPath\Desktop_Dateien\Errors.txt" "Error File"
  }
Sleep(3)
### Move Folers

# Define paths
$desktopPath = [Environment]::GetFolderPath("Desktop")
$documentsPath = [Environment]::GetFolderPath("MyDocuments")

# Create WScript.Shell COM object for shortcut creation
$wshShell = New-Object -ComObject WScript.Shell

# Get all folders on the Desktop
$folders = Get-ChildItem -Path $desktopPath -Directory

foreach ($folder in $folders) {
    $sourcePath = $folder.FullName
    $destinationPath = Join-Path -Path $documentsPath -ChildPath $folder.Name

    # Move the folder to Documents
    Move-Item -Path $sourcePath -Destination $destinationPath
    

    # Create a shortcut on the Desktop
    $shortcutPath = Join-Path -Path $desktopPath -ChildPath ("{0}.lnk" -f $folder.Name)
    $shortcut = $wshShell.CreateShortcut($shortcutPath)
    $shortcut.TargetPath = $destinationPath
    $shortcut.Save()
}

Write-Host "Folders moved and shortcuts created successfully."

$TargetFolder = "$documentsPath\Desktop_Dateien"
$ShortcutLocation = "$DesktopPath\Lose_Dateien.lnk"

$WshShell = New-Object -ComObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut($ShortcutLocation)
$Shortcut.TargetPath = $TargetFolder
$Shortcut.Save()

Start-Process $documentsPath\Desktop_Dateien
