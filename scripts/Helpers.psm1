filter Set-MaskedValue {
    <#
        .SYNOPSIS
        Masks sensitive values such as GitHub tokens, JWT tokens, and private keys.

        .DESCRIPTION
        This function checks an input string against known patterns for sensitive values, such as:
        - GitHub tokens (Personal Access Tokens, OAuth Tokens, Session Tokens, User Tokens)
        - JSON Web Tokens (JWT)
        - Private keys
        If a match is found, the function replaces the value with a corresponding masked placeholder.
        If no match is found, the original value is returned unaltered.

        .EXAMPLE
        Set-MaskedValue -Value 'github_pat_1234567890123456789012'

        Output:
        ```powershell
        ***GITHUB_FG_PAT_TOKEN***
        ```

        Masks a GitHub fine-grained personal access token.

        .EXAMPLE
        Set-MaskedValue -Value 'ghp_abcdefghijklmnopqrstuvwxyz0123456789'

        Output:
        ```powershell
        ***GITHUB_CLASSIC_PAT_TOKEN***
        ```

        Masks a classic GitHub personal access token.

        .EXAMPLE
        Set-MaskedValue -Value 'header.payload.signature'

        Output:
        ```powershell
        ***JWT_TOKEN***
        ```

        Masks a JSON Web Token (JWT).

        .EXAMPLE
        Set-MaskedValue -Value "-----BEGIN RSA PRIVATE KEY-----\nMIIEowIBAA..."

        Output:
        ```powershell
        ***PRIVATE_KEY***
        ```

        Masks a private key.

        .OUTPUTS
        string

        .NOTES
        Returns the masked value if a match is found; otherwise, returns the original value.
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute(
        'PSUseShouldProcessForStateChangingFunctions', '',
        Justification = 'This function is not state-changing. It is a utility function.'
    )]
    [OutputType([string])]
    [CmdletBinding()]
    param (
        # The value to be checked and potentially masked.
        [Parameter(Mandatory, ValueFromPipeline)]
        [string] $Value
    )

    switch -Regex ($Value) {
        'github_pat_' {
            '***GITHUB_FG_PAT_TOKEN***'
            break
        }
        'ghp_' {
            '***GITHUB_CLASSIC_PAT_TOKEN***'
            break
        }
        'ghs_' {
            '***GITHUB_SESSION_TOKEN***'
            break
        }
        'ghu_' {
            '***GITHUB_USER_TOKEN***'
            break
        }
        'gho_' {
            '***GITHUB_OAUTH_TOKEN***'
            break
        }
        '.*\..*\..*' {
            '***JWT_TOKEN***'
            break
        }
        'PRIVATE KEY.*[\s\S]+?.*PRIVATE KEY' {
            '***PRIVATE_KEY***'
            break
        }
        default {
            $Value
        }
    }
}
