function Get-HistoryPaths {
    @(
        "$HOME\.claude\projects",
        "$HOME\.copilot\session-state",
        "$HOME\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine"
    )
}

function Test-PathExists {
    param([Parameter(ValueFromPipeline)][string]$Path)
    process { if (Test-Path $Path) { $Path } }
}

function Clear-AgentHistory {
    [CmdletBinding(SupportsShouldProcess)]
    param()

    Get-HistoryPaths
    | Test-PathExists
    | ForEach-Object {
        if ($PSCmdlet.ShouldProcess($_, 'Remove-Item -Force -Recurse')) {
            Remove-Item -Path $_ -Force -Recurse
        }
        $_
    }
    | ForEach-Object { Write-Host "Removed: $_" -ForegroundColor Green }
}
