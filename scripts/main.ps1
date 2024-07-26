[CmdletBinding()]
param()

$n = [System.Environment]::NewLine


$CONTEXT_GITHUB = $env:CONTEXT_GITHUB | ConvertFrom-Json -Depth 100
'::group::Context: [GITHUB]'
$CONTEXT_GITHUB | ConvertTo-Json -Depth 100

'::group::Context: [GITHUB_EVENT]'
$CONTEXT_GITHUB.event | ConvertTo-Json -Depth 100

'::group::Context: [GITHUB_EVENT_ENTERPRISE]'
$CONTEXT_GITHUB | ConvertTo-Json -Depth 100

'::group::Context: [GITHUB_EVENT_ORGANIZATION]'
$CONTEXT_GITHUB.event.organization | ConvertTo-Json -Depth 100

'::group::Context: [GITHUB_EVENT_REPOSITORY]'
$CONTEXT_GITHUB.event.repository | ConvertTo-Json -Depth 100

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
$env:CONTEXT_RUNNER

# '::group::Context: [SECRETS]'
# $env:CONTEXT_SECRETS

'::group::Context: [STRATEGY]'
$env:CONTEXT_STRATEGY

'::group::Context: [MATRIX]'
$env:CONTEXT_MATRIX

# '::group::Context: [NEEDS]'
# $env:CONTEXT_NEEDS

'::group::Context: [INPUTS]'
$env:CONTEXT_INPUTS

"::group::File system at [$pwd]"
Get-ChildItem -Path . | Select-Object FullName | Sort-Object FullName | Format-Table -AutoSize -Wrap

'::group::Environment Variables'
Get-ChildItem env: | Where-Object {€_.Name -notlike 'CONTEXT_*'} | Sort-Object Name | Format-Table -AutoSize -Wrap

"::group::PowerShell variables"
Get-Variable | Where-Object {€_.Name -notlike 'CONTEXT_*'} | Sort-Object Name | Format-Table -AutoSize -Wrap

"::group::PSVersionTable"
$PSVersionTable | Select-Object *

"::group::ExecutionContext"
$ExecutionContext | Select-Object *

"::group::Host"
$Host | Select-Object *

"::group::MyInvocation"
$MyInvocation | Select-Object *

"::group::PSCmdlet"
$PSCmdlet | Select-Object *

"::group::PSSessionOption"
$PSSessionOption | Select-Object *

"::group::PSStyle"
$PSStyle | Select-Object *
