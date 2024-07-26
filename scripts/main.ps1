[CmdletBinding()]
param()

$github = $env:CONTEXT_GITHUB | ConvertFrom-Json -Depth 100 -AsHashtable

'::group::Context: [GITHUB]'
$github | Select-Object -ExcludeProperty event | Sort-Object

'::group::Context: [GITHUB_EVENT]'
$github.event | ConvertTo-Json -Depth 100

'::group::Context: [GITHUB_EVENT_ENTERPRISE]'
$github.event.enterprise | Sort-Object

'::group::Context: [GITHUB_EVENT_ORGANIZATION]'
$github.event.organization | Sort-Object

'::group::Context: [GITHUB_EVENT_REPOSITORY]'
$github.event.repository | Sort-Object

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

'::group::File system at [$pwd]'
Get-ChildItem -Path . | Select-Object -ExpandProperty FullName | Sort-Object