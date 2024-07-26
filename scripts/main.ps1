[CmdletBinding()]
param()

$github = $env:CONTEXT_GITHUB | ConvertFrom-Json -Depth 100
$n = [System.Environment]::NewLine


'::group::Context: [GITHUB]'
Write-Verbose ($n + ($github.PSObject.Properties | Where-Object { $_.Name -ne 'event' } | Foreach-Object {
    [pscustomobject]@{
        Name = $_.Name
        Value = $_.Value
    }
} | Sort-Object Name | Out-String))

'::group::Context: [GITHUB_EVENT]'
Write-Verbose ($n + $github.event.PSObject.Properties | Where-Object { $_.Name -ne 'event' } | Foreach-Object {
    [pscustomobject]@{
        Name = $_.Name
        Value = $_.Value
    }
} | Sort-Object Name | Out-String)

'::group::Context: [GITHUB_EVENT_ENTERPRISE]'
Write-Verbose ($n + $github.event.enterprise.PSObject.Properties | Where-Object { $_.Name -ne 'event' } | Foreach-Object {
    [pscustomobject]@{
        Name = $_.Name
        Value = $_.Value
    }
} | Sort-Object Name | Out-String)

'::group::Context: [GITHUB_EVENT_ORGANIZATION]'
Write-Verbose ($n + $github.event.organization.PSObject.Properties | Where-Object { $_.Name -ne 'event' } | Foreach-Object {
    [pscustomobject]@{
        Name = $_.Name
        Value = $_.Value
    }
} | Sort-Object Name | Out-String)

'::group::Context: [GITHUB_EVENT_REPOSITORY]'
Write-Verbose ($n + $github.event.repository.PSObject.Properties | Where-Object { $_.Name -ne 'event' } | Foreach-Object {
    [pscustomobject]@{
        Name = $_.Name
        Value = $_.Value
    }
} | Sort-Object Name | Out-String)

'::group::Context: [ENV]'
$env:CONTEXT_ENV

# '::group::Context: [VARS]'
# $env:CONTEXT_VARS

'::group::Context: [JOB]'
$env:CONTEXT_JOB

# '::group::Context: [JOBS]'
# $env:CONTEXT_JOBS

'::group::Context: [STEPS]'
$env:CONTEXT_STEPS

'::group::Context: [RUNNER]'
$env:CONTEXT_RUNNER | ConvertFrom-Json | Sort-Object

# '::group::Context: [SECRETS]'
# $env:CONTEXT_SECRETS

'::group::Context: [STRATEGY]'
$env:CONTEXT_STRATEGY | ConvertFrom-Json | Sort-Object

'::group::Context: [MATRIX]'
$env:CONTEXT_MATRIX | ConvertFrom-Json | Sort-Object

# '::group::Context: [NEEDS]'
# $env:CONTEXT_NEEDS

'::group::Context: [INPUTS]'
$env:CONTEXT_INPUTS | ConvertFrom-Json | Sort-Object

'::group::Environment Variables'
Get-ChildItem env: | Format-Table -AutoSize

"::group::File system at [$pwd]"
Get-ChildItem -Path . | Select-Object -ExpandProperty FullName | Sort-Object

"::group::PowerShell variables"
Get-Variable