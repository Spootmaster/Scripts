# Removes all specific WiFi certificates from the system

$Certs = Get-ChildItem -Path Cert:\LocalMachine\My | Where-Object { $_.Issuer -match "Company-Cert-CA" }

if ($Certs) {
    $Certs | Remove-Item -Force
    Write-Host "Removed $($Certs.Count) certificates."
    exit 0
} else {
    Write-Host "No certificates found."
    exit 1 # Cert removal error
}
