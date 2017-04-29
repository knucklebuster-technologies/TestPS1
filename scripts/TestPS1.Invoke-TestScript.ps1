
function Invoke-TestScript {
    [CmdletBinding()]
    param (
        [Parameter(Position=0)]
        [string]
        $Label,
        [Parameter(Position=1)]
        [scriptblock]
        $Script
    )

    #Declare Test Level Variables
    Set-Variable -Name ErrorActionPreference -Value 'Stop' -Scope Global
    Set-Variable -Name 'StepCounter' -Value 0 -Scope Global
    
    Write-Verbose -Message "Running Test Script With Label $Label"
    
    #Add Commands
    . "$PSModuleRoot\files\TestPS1.Invoke-TestSetup.ps1"
    . "$PSModuleRoot\files\TestPS1.Invoke-TestStep.ps1"

    #Execute The Test Script
    Invoke-Command $Script -Verbose

    #Cleanup Test Level Variables
    Remove-Variable -Name 'StepCounter' -Scope Global -Force
    Set-Variable -Name ErrorActionPreference -Value 'Continue' -Scope Global
}

Set-Alias -Name 'TestScript' -Value Invoke-TestScript

#Register as Public Function to be exported  
if( Test-Path Variable:PUBLIC ) {
    $PUBLIC.Function += "$(( $MyInvocation.MyCommand.Name -replace '.ps1','' ).Trim() )"
}