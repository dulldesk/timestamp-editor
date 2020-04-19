function CheckQ {
    param (
         [Parameter(Mandatory = $true)]
         $str
    )
    if ($str -eq 'q') {exit}
}

function FetchTime {
    param (
         [Parameter(Mandatory = $true)]
         $tmename
    )
    
    do {
        $tme = read-host "enter" $tmename "time, or 'n' to skip"
        CheckQ $tme
        if ($tme.ToLower() -eq 'n') {
            $tme = $false
            break
        }
        $tme = $tme -as [DateTime]
    } while (-not $tme)

    return $tme
}

function FetchFile {
    do {
        $f = Read-Host "enter file path"
        CheckQ $f
        $f = $f.replace('"','')
    } while (-not (Test-Path -path $f))
    return $f
}

Write-Host "Timestamp Editor" -f cyan
Write-Host "At any point, enter 'q' to exit"
Write-Host " "

while ($true) {
    $file = Get-Item (FetchFile) -force
    $file
    Write-Host " "
    
    $copyfromfile = read-host "copy all timestamps from another file? [y/n]"
    CheckQ $copyfromfile

    if ($copyfromfile -eq 'y' -or $copyfromfile -eq 'Y') {
        $other = Get-Item (FetchFile) -force
        $file.CreationTime = $other.CreationTime
        $file.LastWriteTime = $other.LastWriteTime
        $file.LastAccessTime = $other.LastAccessTime

    } else {
        Write-Host ' '
        Write-Host "Time format: DD month YYYY [HH:MM[:SS]]"
        Write-Host ' '

        $allsame = (read-host "make all timestamps equal? [y/n]").ToLower()
        CheckQ $allsame

        if ($allsame -eq 'q') {
            $ts = FetchTime "timestamp"
            $file.CreationTime = $ts
            $file.LastWriteTime = $ts
            $file.LastAccessTime = $ts
        } 
        else {
            $times = @('creation','last write time','last access time')

            for ($i=0;$i -lt $times.Length;$i++) {
                $ts = FetchTime $times[$i];
                if (-not $ts) {
                    continue
                }
                if ($i -eq 0) {
                    $file.CreationTime = $ts
                }
                elseif ($i -eq 1) {
                    $file.LastWriteTime = $ts
                }
                elseif ($i -eq 2) {
                    $file.LastAccessTime = $ts
                }
            }
        }
    }
    Write-Host " "
    Write-Host $file.name "timestamps" -f green
    Write-host "creation time " $file.CreationTime
    Write-host "last modification time " $file.LastWriteTime
    Write-host "last access time " $file.LastAccessTime
    Write-Host "  " 
    $ask = Read-Host "continue? [y/n]"
    if ($ask -ne 'y' -and $ask -ne 'Y') {break}
    Write-Host " "
}