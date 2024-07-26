[CmdletBinding()]
param()

'::group::Context: [GITHUB]'
$env:CONTEXT_GITHUB

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
Get-ChildItem env: | Format-List

'::group::File system at [$pwd]'
Get-ChildItem -Path . | Select-Object -ExpandProperty FullName | Sort-Object