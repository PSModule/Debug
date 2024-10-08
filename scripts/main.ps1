[CmdletBinding()]
param()

$CONTEXT_GITHUB = $env:CONTEXT_GITHUB | ConvertFrom-Json -Depth 100

LogGroup 'Context: [GITHUB]' {
    $CONTEXT_GITHUB | ConvertTo-Json -Depth 100
}

LogGroup 'Context: [GITHUB_EVENT]' {
    $CONTEXT_GITHUB.event | ConvertTo-Json -Depth 100
}

LogGroup 'Context: [GITHUB_EVENT_ENTERPRISE]' {
    $CONTEXT_GITHUB | ConvertTo-Json -Depth 100
}

LogGroup 'Context: [GITHUB_EVENT_ORGANIZATION]' {
    $CONTEXT_GITHUB.event.organization | ConvertTo-Json -Depth 100
}

LogGroup 'Context: [GITHUB_EVENT_REPOSITORY]' {
    $CONTEXT_GITHUB.event.repository | ConvertTo-Json -Depth 100
}

LogGroup 'Context: [ENV]' {
    $env:CONTEXT_ENV
}

# LogGroup 'Context: [VARS]' {
# $env:CONTEXT_VARS
# }

LogGroup 'Context: [JOB]' {
    $env:CONTEXT_JOB
}

# LogGroup 'Context: [JOBS]' {
# $env:CONTEXT_JOBS
# }

LogGroup 'Context: [STEPS]' {
    $env:CONTEXT_STEPS
}

LogGroup 'Context: [RUNNER]' {
    $env:CONTEXT_RUNNER
}

# LogGroup 'Context: [SECRETS]' {
# $env:CONTEXT_SECRETS
# }

LogGroup 'Context: [STRATEGY]' {
    $env:CONTEXT_STRATEGY
}

LogGroup 'Context: [MATRIX]' {
    $env:CONTEXT_MATRIX
}

# LogGroup 'Context: [NEEDS]' {
# $env:CONTEXT_NEEDS
# }
LogGroup 'Context: [INPUTS]' {
    $env:CONTEXT_INPUTS
}

LogGroup "File system at [$pwd]" {
    Get-ChildItem -Path . | Select-Object FullName | Sort-Object FullName | Format-Table -AutoSize -Wrap
}

LogGroup 'Environment Variables' {
    Get-ChildItem env: | Where-Object { $_.Name -notlike 'CONTEXT_*' } | Sort-Object Name | Format-Table -AutoSize -Wrap
}

LogGroup 'PowerShell variables' {
    Get-Variable | Where-Object { $_.Name -notlike 'CONTEXT_*' } | Sort-Object Name | Format-Table -AutoSize -Wrap
}

LogGroup 'PSVersionTable' {
    $PSVersionTable | Select-Object * | Format-List
}

LogGroup 'Installed Modules - List' {
    $modules = Get-PSResource | Sort-Object -Property Name
    $modules | Select-Object Name, Version, CompanyName, Author | Format-Table -AutoSize -Wrap
}

$modules.Name | Select-Object -Unique | ForEach-Object {
    $name = $_
    LogGroup "Installed Modules - Details - [$name]" {
        $modules | Where-Object Name -EQ $name | Select-Object * | Format-List
    }
}

LogGroup 'ExecutionContext' {
    $ExecutionContext | Select-Object * | Format-List
}

LogGroup 'Host' {
    $Host | Select-Object * | Format-List
}

LogGroup 'MyInvocation' {
    $MyInvocation | Select-Object * | Format-List
}

LogGroup 'PSCmdlet' {
    $PSCmdlet | Select-Object * | Format-List
}

LogGroup 'PSSessionOption' {
    $PSSessionOption | Select-Object * | Format-List
}

LogGroup 'PSStyle' {
    $PSStyle | Select-Object * | Format-List
}
