# PowerShell edition of the dumby Outwar script
# Author: Connor Peoples
# Handle: @NoUselessTech
# Email: connor@nouseless.tech
# Version: 0.1

# Variables
$Location = (Get-Location).Path
$Global:Header = @{
    accept = '*/*'
}

# Imports
Import-Module "$Location/modules/Account.psm1"

# Functions


# Logic
Get-LoginSession

