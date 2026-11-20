#!/bin/sh
# Ouvre une session DVWA (admin / password) et affiche la valeur du cookie PHPSESSID.
# Usage : sh dvwa_session.sh [URL]    (URL par défaut : http://srv-web/DVWA)
URL=${1:-http://srv-web/DVWA}
J=$(mktemp)
T=$(curl -s -c "$J" "$URL/login.php" | grep -o "user_token' value='[0-9a-f]*" | cut -d"'" -f3)
curl -s -b "$J" -c "$J" -o /dev/null -d "username=admin&password=password&Login=Login&user_token=$T" "$URL/login.php"
awk '$6=="PHPSESSID"{print $7}' "$J"
rm -f "$J"
