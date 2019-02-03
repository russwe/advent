$parents = New-Object 'System.Collections.Generic.HashSet[string]'
$children = New-Object 'System.Collections.Generic.HashSet[string]'

Get-Content '.\d7.in' |% {
    # pvtnv (77)
    # vxfoyx (101) -> aqytxb, ltnnn
    $_ -match '(\w+) \((\d+)\)(?: -> (.*))?' > $null
    $p = $Matches[1]
    $w = $Matches[2]
    $c = $Matches[3] -split ','

    Write-Host -Fore Yellow "$p /$w/ $c"

    $parents.Add($p.Trim()) > $null
    $c |% { $children.Add($_.Trim()) > $null }
}

$root = New-Object 'System.Collections.Generic.HashSet[string]' $parents
$root.ExceptWith($children)

$root