Function InstallLegacy {

    ForEach($Ver in 2005..2013) {
        ForEach($Arch in "x86", "x64") {
            $Legacy = "Microsoft.VC++$($Ver)Redist-$($Arch)"
            $Result = Winget Search --Id $Legacy --Exact

            If($Result -like "*No package found*") {
                Break
            } Else {
                Write-Host "Installing $Legacy"
                Winget Install --Id $Legacy
            }
        }
    }
}
Function InstallCurrent {

    $Year = Get-Date | Select-Object -ExpandProperty Year
    $Cont = $True

    While($Cont) {
        ForEach($Arch in "x86", "x64") {
            $Current = "Microsoft.VC++2015-$($Year)Redist-$($Arch)"
            $Result = Winget Search --Id $Current --Exact

            If($Result -like "*No package found*") {
                $Year -= 1
                Break
            } Else {
                Write-Host "Installing $Current"
                Winget Install --Id $Current
                $Cont = $False
            }
        }
    }
}

Function InstallRedist {
    InstallLegacy
    InstallCurrent
}

InstallRedist

Start-Sleep -Seconds 3