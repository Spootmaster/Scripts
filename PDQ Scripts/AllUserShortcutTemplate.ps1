# Template for creating Chrome desktop shortcuts for all users- modify ShortcutName and Arguments

function Template {
    param (
        [Parameter(Mandatory)] $ShortcutLocation,
        [Parameter(Mandatory)] $ShortcutName,
        [Parameter(Mandatory)] $TargetPath,
        [Parameter(Mandatory)] $WorkingDirectory,
        $Arguments
    )
    $ShortcutPath = Join-Path -Path $ShortcutLocation -ChildPath "$ShortcutName.lnk"
    $WScriptShell = New-Object -ComObject WScript.Shell
    $Shortcut = $WScriptShell.CreateShortcut($ShortcutPath)
    $Shortcut.TargetPath = $TargetPath
    $Shortcut.Arguments = $Arguments
    $Shortcut.WorkingDirectory = $WorkingDirectory
    $Shortcut.Save()
}

$params = @{
    ShortcutLocation = "C:\Users\Public\Desktop"
    ShortcutName      = "website shortcut"
    TargetPath        = "C:\Program Files\Google\Chrome\Application\chrome.exe"
    Arguments         = "https://website.com/"
    WorkingDirectory  = "C:\Program Files\Google\Chrome\Application\chrome.exe"
}
template @params
