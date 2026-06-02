# =========================================================
# Configuration
# =========================================================
$SourceDir      = "C:\Users\john.doe\Downloads\Telegram Desktop"
$FileExtension  = ".docx"  # Target file extension, substitute for actual one file extension

$SmtpHost       = 'smtp.test.com' # substitute for actual one
$SmtpPort       = 587 # substitute for actual one
$Sender         = 'sender@test.com' # substitute for actual one
$Recipient      = 'recipe@test.com' # substitute for actual one
$PasswordPlain  = '' # substitute for actual one

# =========================================================
# Runtime Logic
# =========================================================
$Timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$ZipPath   = Join-Path $env:TEMP "Archive_$Timestamp.zip"

try {
    # 1. Check Directory
    if (-not (Test-Path -Path $SourceDir)) {
        throw "Directory not found: $SourceDir"
    }

    # 2. Find Files by extension
    $SearchFilter = "*" + $FileExtension
    $TargetFiles = Get-ChildItem -Path $SourceDir -Filter $SearchFilter -File
    
    if ($null -eq $TargetFiles -or $TargetFiles.Count -eq 0) {
        Write-Output "No files with extension $FileExtension found in $SourceDir. Exiting."
        exit 0
    }

    # 3. Create ZIP Archive
    # Force compression even if file exists
    Compress-Archive -Path $TargetFiles.FullName -DestinationPath $ZipPath -Force

    # 4. Prepare Email
    $Message = New-Object System.Net.Mail.MailMessage($Sender, $Recipient)
    $Message.Subject = "Auto-Archive: $FileExtension files ($Timestamp)"
    $Message.Body    = "Sent from agent. Source: $SourceDir. Count: $($TargetFiles.Count)"

    # 5. Add Attachment
    $Attachment = New-Object System.Net.Mail.Attachment($ZipPath)
    $Message.Attachments.Add($Attachment)

    # 6. SMTP Send
    $Smtp = New-Object System.Net.Mail.SmtpClient($SmtpHost, $SmtpPort)
    $Smtp.EnableSsl = $true
    $Smtp.Credentials = New-Object System.Net.NetworkCredential($Sender, $PasswordPlain)
    
    $Smtp.Send($Message)
}
catch {
    # Non-interactive error output
    [Console]::Error.WriteLine("CRITICAL ERROR: " + $_.Exception.Message)
    exit 1
}
finally {
    # 7. Cleanup
    if ($null -ne $Attachment) { $Attachment.Dispose() }
    if ($null -ne $Message) { $Message.Dispose() }
    if ($null -ne $Smtp) { $Smtp.Dispose() }
    
    if (Test-Path $ZipPath) {
        Remove-Item $ZipPath -Force -ErrorAction SilentlyContinue
    }
}
