# Check if running as Admin
$Elevated = (New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

# If running as Admin, apply for all users.
# If not running as Admin, apply for only this user.
$Scope = If($Elevated) { "LocalMachine" } Else { "CurrentUser" }

# Check the existing policy.
$Policy = Get-ExecutionPolicy -Scope $Scope

# If Default, set to Bypass
# If Bypass, set to Default
$Policy = If($Policy -eq "Bypass") { "Default" } Else { "Bypass" }

# Make changes
Set-ExecutionPolicy -Scope $Scope -ExecutionPolicy $Policy -Force

# Generate output
$Output = @(
    "Name = Execution Policy"
    "Value = $Policy"
    "Scope = $Scope"
) -join "`n"

# Display output
Write-Output $Output