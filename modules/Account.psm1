Function Get-LoginSession() {
    $Username = Read-Host "Username"
    $Password = Read-Host "Password" -MaskInput
    $LoginUrl = 'https://outwar.com/index.php'
    $ServerId = 1
    $Body = @{
        serverid = $ServerId
        login_username = $Username
        login_password = $Password
    }

    $Global:LoginRequest = Invoke-WebRequest `
        -Uri $LoginUrl `
        -Body $Body `
        -SessionVariable 'Global:Session' `
        -MaximumRedirection 0 `
        -Method POST

    Write-Host $Global:Session
}
