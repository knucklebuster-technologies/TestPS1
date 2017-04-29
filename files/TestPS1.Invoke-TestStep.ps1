
function Invoke-TestStep {
    [CmdletBinding()]
    param (
        [Parameter(Position=0)]
        [string]
        $Label,
        [Parameter(Position=1)]
        [scriptblock]
        $Script
    )

    $Counter = (Get-Variable -Name 'StepCounter' -ValueOnly -Scope Global) + 1
    Set-Variable -Name 'StepCounter' -Value $Counter -Scope Global

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
        return "STEP $Counter - $Label : PASSED | RETURNED : $JSON"   
    }
    else {
        return "STEP $Counter - $Label : FAILED | RETURNED : $JSON" 
    }
}

Set-Alias -Name 'STEP' -Value Invoke-TestStep