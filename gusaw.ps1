#Requires -Version 5.1

# Configuration
$SmtpHost = 'smtp.test.com' # substitute for actual one
$SmtpPort = 587 # substitute for actual one
$Sender = 'sender@test.com' # substitute for actual one
$Recipient = 'recipe@test.com' # substitute for actual one
$PasswordPlain = '' # substitute for actual one

$SecurePassword = ConvertTo-SecureString -String $PasswordPlain -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential($Sender, $SecurePassword)

$JsonLines = @()

# Helper function to get Registry Key Last Write Time via native API
function Get-RegisterKeyLastWriteTime ($RegPath) {
    try {
        $Hive = $RegPath.Split(":")[0]
        $SubKey = $RegPath.Split("\", 2)[1]
        $BaseKey = if ($Hive -eq "HKLM") { [Microsoft.Win32.Registry]::LocalMachine } else { [Microsoft.Win32.Registry]::CurrentUser }
        $OpenSubKey = $BaseKey.OpenSubKey($SubKey)
        if ($OpenSubKey) {
            $RegKeyType = $OpenSubKey.GetType()
            $MethodInfo = $RegKeyType.GetMethod("QueryValueAndSubKeyInformation", [System.Reflection.BindingFlags]::NonPublic -bor [System.Reflection.BindingFlags]::Instance)
            $Args = New-Object Object[] 5
            $Args[4] = New-Object System.Runtime.InteropServices.ComTypes.FILETIME
            $MethodInfo.Invoke($OpenSubKey, $Args)
            $Ft = ([long]$Args[4].dwHighDateTime -shl 32) -bor [uint32]$Args[4].dwLowDateTime
            $OpenSubKey.Close()
            return [DateTime]::FromFileTime($Ft).ToString("yyyy-MM-ddTHH:mm:ss")
        }
    } catch {}
    return "Unknown"
}

# 1. Collect Registry Startup Items (HKLM and HKCU)
$RegPaths = @(
    @{ Path = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run"; Scope = "HKLM_Run" },
    @{ Path = "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce"; Scope = "HKLM_RunOnce" },
    @{ Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"; Scope = "HKCU_Run" },
    @{ Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce"; Scope = "HKCU_RunOnce" }
)

foreach ($Reg in $RegPaths) {
    if (Test-Path $Reg.Path) {
        $Properties = Get-ItemProperty -Path $Reg.Path -ErrorAction SilentlyContinue
        $Acl = Get-Acl -Path $Reg.Path -ErrorAction SilentlyContinue
        
        if ($Acl) { $KeyOwner = $Acl.Owner } else { $KeyOwner = "Unknown" }
        
        $KeyTime = Get-RegisterKeyLastWriteTime -RegPath $Reg.Path
        
        foreach ($Prop in $Properties.PSObject.Properties) {
            if ($Prop.Name -notin @('PSPath', 'PSParentPath', 'PSChildName', 'PSDrive', 'PSProvider')) {
                $Record = @{
                    type       = "Registry"
                    scope      = $Reg.Scope
                    name       = $Prop.Name
                    command    = $Prop.Value
                    author     = $KeyOwner
                    created_at = $KeyTime
                } | ConvertTo-Json -Depth 3 -Compress
                $JsonLines += $Record
            }
        }
    }
}

# 2. Collect Startup Folders (All Users and Current User)
$StartupFolders = @(
    @{ Path = "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp"; Scope = "AllUsers_Startup" },
    @{ Path = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\StartUp"; Scope = "CurrentUser_Startup" }
)

foreach ($Folder in $StartupFolders) {
    if (Test-Path $Folder.Path) {
        $Files = Get-ChildItem -Path $Folder.Path -File -ErrorAction SilentlyContinue
        foreach ($File in $Files) {
            $FileAcl = Get-Acl -Path $File.FullName -ErrorAction SilentlyContinue
            
            if ($FileAcl) { $FileOwner = $FileAcl.Owner } else { $FileOwner = "Unknown" }
            
            $Record = @{
                type       = "Folder"
                scope      = $Folder.Scope
                name       = $File.Name
                command    = $File.FullName
                author     = $FileOwner
                created_at = $File.CreationTime.ToString("yyyy-MM-ddTHH:mm:ss")
            } | ConvertTo-Json -Depth 3 -Compress
            $JsonLines += $Record
        }
    }
}

# 3. Collect Task Scheduler Tasks (Filtering out native Microsoft system tasks)
try {
    $Tasks = Get-ScheduledTask -ErrorAction SilentlyContinue | Where-Object { $_.TaskPath -notlike "\Microsoft\Windows*" }
    foreach ($Task in $Tasks) {
        
        # Extract Author from Task XML
        $TaskXml = [xml]$Task.Xml
        $TaskAuthor = $TaskXml.Task.RegistrationInfo.Author
        if (-not $TaskAuthor) { $TaskAuthor = $Task.Principal.UserId }
        if (-not $TaskAuthor) { $TaskAuthor = "Unknown" }

        # FIX: Get physical task file creation date to avoid Windows 10/11 1999-11-30 Epoch bug
        $TaskDate = "Unknown"
        $TaskRelativePath = Join-Path -Path $Task.TaskPath -ChildPath $Task.TaskName
        $PhysicalTaskPath = Join-Path -Path "C:\Windows\System32\Tasks" -ChildPath $TaskRelativePath
        
        if (Test-Path $PhysicalTaskPath) {
            $TaskFile = Get-Item -Path $PhysicalTaskPath -ErrorAction SilentlyContinue
            if ($TaskFile) {
                $TaskDate = $TaskFile.CreationTime.ToString("yyyy-MM-ddTHH:mm:ss")
            }
        }
        
        # Fallback to XML Date if physical file reading failed
        if ($TaskDate -eq "Unknown" -and $TaskXml.Task.RegistrationInfo.Date) {
            $TaskDate = $TaskXml.Task.RegistrationInfo.Date
        }

        $Record = @{
            type       = "TaskScheduler"
            scope      = $Task.TaskPath
            name       = $Task.TaskName
            command    = ($Task.Actions.Execute + " " + $Task.Actions.Arguments).Trim()
            author     = $TaskAuthor
            created_at = $TaskDate
        } | ConvertTo-Json -Depth 3 -Compress
        $JsonLines += $Record
    }
} catch {}

# Join with newlines
$JsonReport = $JsonLines -join "`n"

$TempFile = [System.IO.Path]::GetTempFileName() + ".json"
[System.IO.File]::WriteAllText($TempFile, $JsonReport, [System.Text.Encoding]::UTF8)

try {
    Send-MailMessage -SmtpServer $SmtpHost -Port $SmtpPort -UseSsl:$true `
        -From $Sender -To $Recipient `
        -Subject "Enriched Startup and Tasks Report - $(Get-Date -Format 'yyyy-MM-dd HH:mm')" `
        -Body "Attached: Enriched startup items and scheduled tasks report with author metadata from $env:COMPUTERNAME" `
        -Attachments $TempFile `
        -Credential $Credential `
        -Encoding UTF8
    
    Remove-Item -Path $TempFile -Force -ErrorAction SilentlyContinue
} catch {
    Write-Error "Failed to send email: $_"
    exit 1
}
