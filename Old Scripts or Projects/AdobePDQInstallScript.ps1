# Silent installation of Adobe Acrobat Reader
# I'll give a little history lession on this script because it was one of the first ones I ever made for pdq and it took me weeks to figure out. At this point it is almost un-usable tbh for many reasons.
# The main one being that I learned how to use Microsoft Orca afterward so I could just make an mst file and put all the installArgs into that but also because I don't even use this installer anymore, 
# this is the base one you get when you try to install adobe from any computer lol
# This script was great, it would never say if it worked or not in pdq connect so you just had to pray... but it worked about 95% of the time and I used it on prob 250 computers for a few months before moving to a better solution.

param(
    [string]$InstallerPath = ".\reader_en_install.exe"
)

function Install-AdobeReader {
    if (-not (Test-Path $InstallerPath)) {
        Write-Host "ERROR: Installer not found at: $InstallerPath"
        return $false
    }
    
    try {
        $installArgs = @(
            "/sAll",
            "/rs", 
            "/msi",
            "EULA_ACCEPT=YES",
            "DISABLE_ARMSERVICE=1"
        ) -join " "
        
        $process = Start-Process -FilePath $InstallerPath -ArgumentList $installArgs -Wait -PassThru -NoNewWindow
        
        if ($process.ExitCode -eq 0) {
            Write-Host "SUCCESS: Adobe Acrobat Reader installed successfully!"
            return $true
        } else {
            return $true
        }
    }
    catch {
        Write-Host "ERROR: Installation failed: $($_.Exception.Message)"
        return $false
    }
}

$result = Install-AdobeReader

if ($result) {
    Write-Host "Installation completed."
} else {
    Write-Host "Installation failed."
}
