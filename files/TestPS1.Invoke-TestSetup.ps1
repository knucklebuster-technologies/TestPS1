
function Invoke-TestSetup {
    [CmdletBinding()]
    param (
        [Parameter(Position=0)]
        [scriptblock]
        $Script
    )

    try {
        $Error.Clear()
        $Returned = Invoke-Command -ScriptBlock $Script
    }
    catch {
        $Returned = $Error[0] | Select-Object -Property Exception
        $Error.Clear()
    }

    $JSON = ConvertTo-Json -InputObject $Returned

    if (($Returned -eq $null) -or ($Returned -eq $true)) {
        return "SETUP : PASSED | RETURNED : $JSON"   
    }
    else {
        return "SETUP : FAILED | RETURNED : $JSON" 
    }
}

Set-Alias -Name 'SETUP' -Value Invoke-TestSetup