[Environment]::SetEnvironmentVariable("HOME", "$env:USERPROFILE", "User")
[Environment]::SetEnvironmentVariable("XDG_CONFIG_HOME", "$env:USERPROFILE\.config", "User")

Write-Host "HOME and XDG_CONFIG_HOME have been set. Please restart your terminal/session for changes to take effect."
