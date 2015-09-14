Function Reset-MAKFirefoxCertificateSettings{
    # Certificate DB and exceptions reset
    If(Get-Process -Name "firefox" -ErrorAction SilentlyContinue){Stop-Process -Name "firefox"}
    Get-ChildItem -Path "$Env:APPDATA\Mozilla\Firefox\Profiles" -Recurse -Include "cert8.db","cert_override.txt" | ForEach-Object {
        If(Get-ChildItem -Path "$Env:APPDATA\Mozilla\Firefox\Profiles" -Recurse -Include "$($_.Name).old" -ErrorAction SilentlyContinue){
            Remove-Item -Path "$Env:APPDATA\Mozilla\Firefox\Profiles" -Recurse -Include "$($_.Name).old"
        }
        Rename-Item -Path $_ -NewName "$($_.Name).old"
    }
}

Read-Host -Prompt "Press a key to continue and reset the Firefox settings."
Reset-MAKFirefoxCertificateSettings
