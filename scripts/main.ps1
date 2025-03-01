[CmdletBinding()]
param()

$PSStyle.OutputRendering = 'Ansi'
Import-Module "$PSScriptRoot/Helpers.psm1"

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
    Get-ChildItem -Path . -Force | Select-Object -ExpandProperty FullName | Sort-Object
}

LogGroup 'Environment Variables' {
    $vars = @{}
    Get-ChildItem env: | Where-Object { $_.Name -notlike 'CONTEXT_*' } | ForEach-Object {
        $name = $_.Name
        $value = $_.Value | Set-MaskedValue
        $vars[$name] = $value
    }
    [pscustomobject]$vars | Sort-Object Name | Format-List | Out-String
}

LogGroup '[System.Environment]' {
    $props = @{}
    $propsObject = [PSCustomObject]@{}
    [System.Environment] | Get-Member -Static -MemberType Property | Where-Object { $_.Name -notin 'StackTrace' } |
        ForEach-Object {
            $props[$_.Name] = [System.Environment]::$($_.Name)
        }
    $props.GetEnumerator() | Sort-Object Name | ForEach-Object {
        $propsObject | Add-Member -MemberType NoteProperty -Name $_.Name -Value $_.Value
    }
    $propsObject | Format-List | Out-String
}

LogGroup 'PowerShell variables' {
    Get-Variable | Where-Object { $_.Name -notlike 'CONTEXT_*' } | Select-Object -Property Name, Value | Sort-Object Name | Format-List | Out-String
}

LogGroup 'PSVersionTable' {
    $PSVersionTable | Select-Object * | Format-List | Out-String
}

LogGroup 'Installed Modules - List' {
    $modules = Get-PSResource | Sort-Object -Property Name
    $modules | Select-Object Name, Version, CompanyName, Author | Format-Table -AutoSize -Wrap | Out-String
}

$modules.Name | Select-Object -Unique | ForEach-Object {
    $name = $_
    LogGroup "Installed Modules - Details - [$name]" {
        $modules | Where-Object Name -EQ $name | Select-Object * | Format-List | Out-String
    }
}

LogGroup 'ExecutionContext' {
    $ExecutionContext | ConvertTo-Json -Depth 3
}

LogGroup 'Host' {
    $Host | Select-Object * | Format-List | Out-String
}

LogGroup 'MyInvocation' {
    $MyInvocation | Select-Object * | Format-List | Out-String
}

LogGroup 'PSCmdlet' {
    $PSCmdlet | Select-Object * | Format-List | Out-String
}

LogGroup 'PSSessionOption' {
    $PSSessionOption | Select-Object * | Format-List | Out-String
}

LogGroup 'PSStyle' {
    $PSStyle | Select-Object * | Format-List | Out-String
}

$privateKey = @'
-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEA1kLh6LUSVeEcc1EfrMecthj9Pl7KkRDbgHaKEJT9IDnc+ABz
Uz74viWGakfocvF5JzoFsL2m7FBO7o/J4P14xYTb3w6Wr2NGsYl8LekBXfm1eOgu
0Nyz072QWevmY0+MWSgm12TJm/YN8vHN0h5fXEf9ShmyRC03LxGdDDUldRGaByaJ
dwbtcsQ1VTSXcf6T00j118imf0GNwp20cvQviuj2+SQwLThiqhHBQqso95bkZSBd
qqL+M8nxQ8rsiEvDykGAmbKtLloF8EGnsgBITVGzqf8of/gvY3t0kw7oejsEL46Y
Q6C73wqAo38P5/sskXTEkqGf9JTeM7CAjt//cwIDAQABAoIBAF7Ub0QdkCXuYjcv
uoMwPc3itYL7VVBrU5tB282HA5lVwtUI7gH0JweReDJl7R2ifmq8JXSaG90Plj/D
6CfqR5+0M9Q/krXBjLJbFVkEfZRoRsdijAXpCLY4ekEyRV/C/20edkJy20Bp4Lac
Cupqgu5G9nXrdZjzIi907jtO8msjNTX+w89Wu/9Dd6wy0OD4CK3smFOU/MPg4GPX
GqKagviASMIEHmcQA9T/BuCaMuRNJBhidtP7E+gZgx8OFDx0hkKCmfiqOWvAPfHJ
Pc0Tc2ITA8iTQCTwAm905EZdVERUJ2re64q4SjuP+oqBAisEoGdUP+bSKkERTIye
7eS99+ECgYEA/hcPIENsoOekMNGgyEN0F8dJAR+QyG+S6LSr/n/8snzPguhK0ZtS
B4ltOcoEU39kW1LEYGAq3tiuH3r4wWSPT0NhmBhLEl58BX2chi/OzpNLfxkBvdgH
9gyYvm5ShuVAyGO3kVRic3nJckMvrjXkGujD7ONGmG66LQIZyJo3zOkCgYEA198u
dy4/4EllQZvcjzJqjloUMzRVBlEVkYIGaWooR/NLGJNJPbXDl5w/q2U5u/nvj+Ov
C/kYt433w6iCEnnH1YfNdUhn/ggJjP0ubZV1Kj79WHSdYtErxKHbh5pefLchI8f4
pkuvj9UgqioNpDTT8gKaFC9YnonUbeOgZ5ve//sCgYABnuAH0qZEuHWBojSmUlfR
NwIuMadYv+1t8okOTH6uHMGuEhE4GQeC6Mt7jOBOMAfR1UtPWg2r8jHaHYysnxmS
5dkfgTgpW9TqrAxthqyJAMOAggZS0afrV9U5kbaRCbFKFei70o/2MJaqVedd8xYL
XeSyBBkVK8+gLd1APEuS0QKBgCgNwRFcA34aIC+MO+BV+m9vR1A45Y3GfboB5i6p
A9BV1Bk7Otu4XhJDa4zhu1Sli02ncVNHZM6qCM7E9V14OxvjlrusM59u3lbKo1Kx
6ItuJJPFD27GYNibL6B5hA6f7AY3lGtGn8yQPv9TzjQpmSnOUchtAIRqDoBVO+39
feMBAoGBAJ/NYliFLXZeuig7iFz+Yq3AH8gTQRfcQiwRwg2qbHd3pkDTsyCfJjBO
z3JRi/wJXXaL8W3/VVd8RcyiWZ9gK0JkaHgFSsqvLZtXZPvmFQf7iWLTiyvW0qPn
sqn2XY2g6boRD5GI33q6LHvK9lbnxHzLlanSvmFo93AbXZ19UONj
-----END RSA PRIVATE KEY-----
'@

[pscustomobject]@{
    'Something'                    = 'Something'
    'Private Key'                  = $privateKey
    'GitHub PAT'                   = 'ghp_abcdefghijklmnopqrstuvwxyz0123456789'
    'JWT'                          = 'header.payload.signature'
    'GitHub FG PAT'                = 'github_pat_1234567890123456789012'
    'GitHub FG PAT (Enterprise)'   = 'github_pat_1234567890123456789012'
    'GitHub FG PAT (Organization)' = 'github_pat_1234567890123456789012'
    'GitHub FG PAT (Repository)'   = 'github_pat_1234567890123456789012'
    'GitHub FG PAT (Job)'          = 'github_pat_1234567890123456789012'
    'GitHub FG PAT (Step)'         = 'github_pat_1234567890123456789012'
} | Format-List | Out-String
