 param(
    [bool]
    $DevMode=$false
)

#Copy the psm1 root path into a variable for later use
$PSModuleRoot = $PSScriptRoot

#PSObject containing list of module members to export at loading
$PUBLIC = New-Object psobject -Property @{
    'Function' = $( New-Object System.Collections.Generic.List[string]  )
    'Variable' = $( New-Object System.Collections.Generic.List[string]  )
    'Alias'    = $( New-Object System.Collections.Generic.List[string]  )
}
$PUBLIC.PSObject.TypeNames.Insert(0,"Module.ExportedMembers")

#dot source ps1 files into the modules execution context
Get-ChildItem -Path "$PSModuleRoot\scripts" -Filter "*ps1" |
Select-Object -ExpandProperty FullName |
ForEach-Object { . "$_" }

#Export members from the modules context to the callers
if($DevMode) {
    Export-ModuleMember -Function * -Variable * -Alias *
}
else {
    Export-ModuleMember -Function $PUBLIC.Function -Variable $PUBLIC.Variable -Alias $PUBLIC.Alias
}
