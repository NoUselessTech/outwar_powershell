Function Get-UrlParams {
    param( $Url )
    $Params = New-Object PSObject
    $QueryString = ($Url.split('?'))[1]
    $Groups = $QueryString.split('&')

    ForEach($Group in $Groups) {
        $Param,$Value = $Group.split('=')
        $Params | Add-Member `
            -MemberType NoteProperty `
            -Name $Param `
            -Value $Value
    }

    Return $Params
}

Function Set-ToraxCookies {
    param ( $UrlParams )

    $Keys = $UrlParams | Get-Member -MemberType NoteProperty | Select-Object Name

    ForEach($Key in $Keys) {
        $KeyName = $Key.Name
        $Cookie = [System.Net.Cookie]::new($KeyName, $UrlParams.$KeyName)
        $Global:Session.Cookies.Add('http://outwar.com', $Cookie)
        $Global:Session.Cookies.Add('http://torax.outwar.com', $Cookie)
    }
}

Function Set-ToraxHeader {

}

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
        -Method POST `
        -SkipHttpErrorCheck


    $UrlParams = Get-UrlParams -Url $Global:LoginRequest.Headers.Location
    Set-ToraxCookies($UrlParams)

}
