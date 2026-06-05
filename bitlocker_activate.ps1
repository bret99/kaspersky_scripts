# BitLocker Activation Script with Active Directory Key Backup
# Run as Administrator

$ErrorActionPreference = "Stop"

try {
    # Retrieve current BitLocker status for C:
    $blVolume = Get-BitLockerVolume -MountPoint "C:"

    # Check if BitLocker is already fully enabled
    if ($blVolume.ProtectionStatus -eq "On") {
        Write-Host "BitLocker is already enabled on C:"
        exit 0
    }

    # Verify the computer is domain-joined; AD backup requires domain membership
    $computerSystem = Get-WmiObject -Class Win32_ComputerSystem
    if (-not $computerSystem.PartOfDomain) {
        throw "Computer is not domain-joined. Active Directory key backup is not possible."
    }

    # Enable BitLocker with a recovery password protector
    Enable-BitLocker -MountPoint "C:" -RecoveryPasswordProtector -SkipHardwareTest | Out-Null

    # Re-fetch volume data to obtain the new recovery password key protector ID
    $blVolume = Get-BitLockerVolume -MountPoint "C:"
    $recoveryProtector = $blVolume.KeyProtector | Where-Object { $_.KeyProtectorType -eq "RecoveryPassword" }

    if (-not $recoveryProtector) {
        throw "Recovery password protector was not created."
    }

    # Explicitly back up the recovery password to Active Directory
    Backup-BitLockerKeyProtector -MountPoint "C:" -KeyProtectorId $recoveryProtector.KeyProtectorId | Out-Null

    Write-Host "BitLocker enabled successfully on C: and recovery key backed up to Active Directory."

} catch {
    Write-Error "Script failed: $_"
    exit 1
}
