Import-Module "C:\AtomicRedTeam\invoke-atomicredteam\Invoke-AtomicRedTeam.psd1" -Force

New-EventLog -LogName Application -Source "MYSCRIPTSTART"   
New-EventLog -LogName Application -Source "MYSCRIPTEND"

for ($i=0; $i -lt 1000; $i++) {
     
    Write-EventLog -LogName Application -Source "MYSCRIPTSTART" -EntryType Information -EventId 1 -Message "TEST LOG ENTRY"
    New-Item -Path "C:\Users\marek\Documents\MyTestFileStart-$($i).txt" -ItemType File
    
    Invoke-AtomicTest T1003.002-1

    Write-EventLog -LogName Application -Source "MYSCRIPTEND" -EntryType Information -EventId 1 -Message "TEST LOG ENTRY"
    New-Item -Path "C:\Users\marek\Documents\MyTestFileEnd-$($i).txt" -ItemType File

    Invoke-AtomicTest T1003.002-1 -Cleanup

    Start-Sleep -Seconds 30   
}

Set-Location C:\Users\marek\Downloads\KAPE
.\kape.exe --tsource C: --tdest Z:\withsysmon_1000x\T1003.002-1 --target '$J,$MFT,EventLogs'