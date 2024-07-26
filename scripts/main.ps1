[CmdletBinding()]
param()

$n = [System.Environment]::NewLine


$CONTEXT_GITHUB = $env:CONTEXT_GITHUB | ConvertFrom-Json -Depth 100
'::group::Context: [GITHUB]'
$CONTEXT_GITHUB | Select-Object -ExcludeProperty event | ConvertTo-Json -Depth 100

'::group::Context: [GITHUB_EVENT]'
Write-Verbose ($n + ($CONTEXT_GITHUB.event.PSObject.Properties | Foreach-Object {
    [pscustomobject]@{
        Name = $_.Name
        Value = $_.Value
    }
} | Sort-Object Name | Format-Table -AutoSize -Wrap | Out-String))

'::group::Context: [GITHUB_EVENT_ENTERPRISE]'
Write-Verbose ($n + ($CONTEXT_GITHUB.event.enterprise.PSObject.Properties | Foreach-Object {
    [pscustomobject]@{
        Name = $_.Name
        Value = $_.Value
    }
} | Sort-Object Name | Format-Table -AutoSize -Wrap | Out-String))

'::group::Context: [GITHUB_EVENT_ORGANIZATION]'
Write-Verbose ($n + ($CONTEXT_GITHUB.event.organization.PSObject.Properties | Foreach-Object {
    [pscustomobject]@{
        Name = $_.Name
        Value = $_.Value
    }
} | Sort-Object Name | Format-Table -AutoSize -Wrap | Out-String))

'::group::Context: [GITHUB_EVENT_REPOSITORY]'
Write-Verbose ($n + ($CONTEXT_GITHUB.event.repository.PSObject.Properties | Foreach-Object {
    [pscustomobject]@{
        Name = $_.Name
        Value = $_.Value
    }
} | Sort-Object Name | Format-Table -AutoSize -Wrap | Out-String))

'::group::Context: [ENV]'
$CONTEXT_ENV = $env:CONTEXT_ENV | ConvertFrom-Json -Depth 100
Write-Verbose ($n + ($context_env.event.repository.PSObject.Properties | Foreach-Object {
    [pscustomobject]@{
        Name = $_.Name
        Value = $_.Value
    }
} | Sort-Object Name | Format-Table -AutoSize -Wrap | Out-String))

# '::group::Context: [VARS]'
# $env:CONTEXT_VARS

'::group::Context: [JOB]'
$CONTEXT_JOB = $env:CONTEXT_JOB | ConvertFrom-Json -Depth 100
Write-Verbose ($n + ($CONTEXT_JOB.event.repository.PSObject.Properties | Foreach-Object {
    [pscustomobject]@{
        Name = $_.Name
        Value = $_.Value
    }
} | Sort-Object Name | Format-Table -AutoSize -Wrap | Out-String))

# '::group::Context: [JOBS]'
# $env:CONTEXT_JOBS

'::group::Context: [STEPS]'
$CONTEXT_STEPS = $env:CONTEXT_STEPS | ConvertFrom-Json -Depth 100
Write-Verbose ($n + ($CONTEXT_STEPS.event.repository.PSObject.Properties | Foreach-Object {
    [pscustomobject]@{
        Name = $_.Name
        Value = $_.Value
    }
} | Sort-Object Name | Format-Table -AutoSize -Wrap | Out-String))

'::group::Context: [RUNNER]'
$CONTEXT_RUNNER = $env:CONTEXT_RUNNER | ConvertFrom-Json -Depth 100
Write-Verbose ($n + ($CONTEXT_RUNNER.event.repository.PSObject.Properties | Foreach-Object {
    [pscustomobject]@{
        Name = $_.Name
        Value = $_.Value
    }
} | Sort-Object Name | Format-Table -AutoSize -Wrap | Out-String))

# '::group::Context: [SECRETS]'
# $env:CONTEXT_SECRETS

'::group::Context: [STRATEGY]'
$CONTEXT_STRATEGY = $env:CONTEXT_STRATEGY | ConvertFrom-Json -Depth 100
Write-Verbose ($n + ($CONTEXT_STRATEGY.event.repository.PSObject.Properties | Foreach-Object {
    [pscustomobject]@{
        Name = $_.Name
        Value = $_.Value
    }
} | Sort-Object Name | Format-Table -AutoSize -Wrap | Out-String))

'::group::Context: [MATRIX]'
$CONTEXT_MATRIX = $env:CONTEXT_MATRIX | ConvertFrom-Json -Depth 100
Write-Verbose ($n + ($CONTEXT_MATRIX.event.repository.PSObject.Properties | Foreach-Object {
    [pscustomobject]@{
        Name = $_.Name
        Value = $_.Value
    }
} | Sort-Object Name | Format-Table -AutoSize -Wrap | Out-String))

# '::group::Context: [NEEDS]'
# $env:CONTEXT_NEEDS

'::group::Context: [INPUTS]'
$CONTEXT_INPUTS = $env:CONTEXT_INPUTS | ConvertFrom-Json -Depth 100
Write-Verbose ($n + ($CONTEXT_INPUTS.event.repository.PSObject.Properties | Foreach-Object {
    [pscustomobject]@{
        Name = $_.Name
        Value = $_.Value
    }
} | Sort-Object Name | Format-Table -AutoSize -Wrap | Out-String))

'::group::Environment Variables'
Write-Verbose ($n + (Get-ChildItem env: | Sort-Object Name | Format-Table -AutoSize -Wrap | Out-String))

"::group::File system at [$pwd]"
Write-Verbose ($n + (Get-ChildItem -Path . | Select-Object FullName | Sort-Object FullName | Format-Table -AutoSize -Wrap | Out-String))

"::group::PowerShell variables"
Write-Verbose ($n + (Get-Variable | Sort-Object Name | Format-Table -AutoSize -Wrap | Out-String))

"::group::PSVersionTable"
$PSVersionTable

"::group::ExecutionContext"
$ExecutionContext

"::group::Host"
$Host

"::group::MyInvocation"
$MyInvocation

"::group::PSCmdlet"
$PSCmdlet

"::group::PSSessionOption"
$PSSessionOption

"::group::PSStyle"
$PSStyle
