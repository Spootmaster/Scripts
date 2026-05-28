# Removes specific certificates used for manual enrollment

$Certs = Get-ChildItem -Path Cert:\LocalMachine\My | Where-Object { 
    $_.Issuer -match "Company-Cert-CA" -and
    ($_.Extensions | Where-Object { 
        $_.Oid.FriendlyName -eq "Certificate Template Information"
    } | ForEach-Object { 
        $_.Format($true)
    }) -match "Computer Authentication Manual Enrollment"
}

if ($Certs) {
    $Certs | Remove-Item -Force
    Write-Host "Removed $($Certs.Count) certificates."
    exit 0
} else {
    Write-Host "No certificates found."
    exit 1 # Cert removal error
}
