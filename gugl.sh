#Set email from
EMAIL_FROM='test@test.com'
EMAIL_FROM_PASS='test'
#Set email to
EMAIL_TO='test.test@test.com'
#Get IP
IP=$(curl ifconfig.me/ip)
#Get hostname
HOSTNAME=$(hostname)
#Ip2location API key
API="TTTTTTTTTTTTTT"
#Get Ip2location data
curl -s "https://api.ip2location.io/?key=$API&ip=$IP&format=json" > geolocation.json
GEOLOCATION=$(cat geolocation.json | tr { '\n' | tr , '\n' | tr } '\n')
#Send email
curl --ssl-reqd --url "smtp://smtp.test.com:587" --user "$EMAIL_FROM:$EMAIL_FROM_PASS" --mail-from $EMAIL_FROM --mail-rcpt $EMAIL_TO \
--upload-file - <<EOF
From: User geolocation <$EMAIL_FROM>
To: John Doe <$EMAIL_TO>
Subject: $HOSTNAME geolocation 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

$HOSTNAME geolocation =>
$GEOLOCATION
EOF

#Delete tracks
rm -f geolocation.json
rm -f gugl.sh



