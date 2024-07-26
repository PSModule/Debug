[CmdletBinding()]
param()

'::group::Context: [GITHUB]'
$env:CONTEXT_GITHUB | ConvertFrom-Json | Format-Table -AutoSize

'::group::Context: [ENV]'
$env:CONTEXT_ENV | ConvertFrom-Json | Format-Table -AutoSize

'::group::Context: [VARS]'
$env:CONTEXT_VARS | ConvertFrom-Json | Format-Table -AutoSize

'::group::Context: [JOB]'
$env:CONTEXT_JOB | ConvertFrom-Json | Format-Table -AutoSize

'::group::Context: [JOBS]'
$env:CONTEXT_JOBS | ConvertFrom-Json | Format-Table -AutoSize

'::group::Context: [STEPS]'
$env:CONTEXT_STEPS | ConvertFrom-Json | Format-Table -AutoSize

'::group::Context: [RUNNER]'
$env:CONTEXT_RUNNER | ConvertFrom-Json | Format-Table -AutoSize

'::group::Context: [SECRETS]'
$env:CONTEXT_SECRETS | ConvertFrom-Json | Format-Table -AutoSize

'::group::Context: [STRATEGY]'
$env:CONTEXT_STRATEGY | ConvertFrom-Json | Format-Table -AutoSize

'::group::Context: [MATRIX]'
$env:CONTEXT_MATRIX | ConvertFrom-Json | Format-Table -AutoSize

'::group::Context: [NEEDS]'
$env:CONTEXT_NEEDS | ConvertFrom-Json | Format-Table -AutoSize

'::group::Context: [INPUTS]'
$env:CONTEXT_INPUTS | ConvertFrom-Json | Format-Table -AutoSize

'::group::Environment Variables'
Get-ChildItem $env: | Format-Table -AutoSize

'::group::File system at [$pwd]'
Get-ChildItem -Path . | Select-Object -ExpandProperty FullName | Sort-Object