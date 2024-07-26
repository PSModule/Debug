[CmdletBinding()]
param()

$github = $env:CONTEXT_GITHUB | ConvertFrom-Json -Depth 100

'::group::Context: [GITHUB]'
$github | Select-Object -ExcludeProperty event

'::group::Context: [GITHUB_EVENT]'
$github.event | ConvertTo-Json -Depth 100

'::group::Context: [ENV]'
$env:CONTEXT_ENV

'::group::Context: [VARS]'
$env:CONTEXT_VARS

'::group::Context: [JOB]'
$env:CONTEXT_JOB

'::group::Context: [JOBS]'
$env:CONTEXT_JOBS

'::group::Context: [STEPS]'
$env:CONTEXT_STEPS

'::group::Context: [RUNNER]'
$env:CONTEXT_RUNNER

'::group::Context: [SECRETS]'
$env:CONTEXT_SECRETS

'::group::Context: [STRATEGY]'
$env:CONTEXT_STRATEGY

'::group::Context: [MATRIX]'
$env:CONTEXT_MATRIX

'::group::Context: [NEEDS]'
$env:CONTEXT_NEEDS

'::group::Context: [INPUTS]'
$env:CONTEXT_INPUTS

'::group::Environment Variables'
Get-ChildItem env: | Format-Table -AutoSize

'::group::File system at [$pwd]'
Get-ChildItem -Path . | Select-Object -ExpandProperty FullName | Sort-Object