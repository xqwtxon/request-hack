#!/bin/sh

###############################################
##		Spam Bot Request	     ##
##    Made by @xqwtxon (github.com/xqwtxon)  ##
###############################################


count=0
error=0
success=0
max=$(cat config/max-request.txt)
update_url=https://github.com/xqwtxon/spam-bot-request/blob/main/version.txt?raw=true

if [ "$(cat config/max-request.txt)" == "" ]; then
	echo "[!] Please specify max request on the config!"
	exit 1
fi

if [ "$(cat config/url.txt)" == "" ]; then
	echo "[!] Please specify url the config."
	exit 1
fi

if [ "$(cat config/useragent.txt)" == "" ]; then
	echo "[!] Please specify the user agent on the config."
	exit 1
fi

if [ -e "request.cache" ]; then
	rm "request.cache"
fi

if [ ! -e "logs/" ]; then
	mkdir logs
fi

if [ -e "request.log" ]; then
	mv "request.log" "logs/request-$(date +%F)-$(date +%H-%I-%S)-old.log"
fi

echo "[?] Spam Bot Request by @xqwtxon"
echo "[?] Spam Bot Request by @xqwtxon" >> "request.log"
sleep 1s
echo "[!] USE THIS AT YOUR OWN RISK! I AM NOT RESPONSIBLE TO ANY DAMAGES TO THE GITHUB OR YOU. IF YOU ARE USING THIS GITHUB, TERMS OF SERVICE MAY CAN BREAK IN THIS FEATURE. PLEASE USE THIS AT YOUR OWN RISKS!"
echo "[!] USE THIS AT YOUR OWN RISK! I AM NOT RESPONSIBLE TO ANY DAMAGES TO THE GITHUB OR YOU. IF YOU ARE USING THIS GITHUB, TERMS OF SERVICE MAY CAN BREAK IN THIS FEATURE. PLEASE USE THIS AT YOUR OWN RISKS!" >> "request.log"
sleep 10s
echo -n "[*] Checking Program Update: "
curl -sL ${update_url} -o "update.cache"
if [ ! "$?" == "0" ]; then
	echo "Update Notify Error"
else echo "$(cat update.cache)" && rm "update.cache"
fi
clear
while true; do
	trap -p SIGINT
	if [ $count == $max ]; then
		clear
		echo "[*] Requested to $(cat config/url.txt): (${count} all request)"
		echo "[?] Success: ${success}"
		echo "[?] Failed: ${error}"
		echo "[*] Added to $(cat config/url.txt): (${count} all request)" >> "request.log"
                echo "[?] Success: ${success}" >> "request.log"
                echo "[?] Failed: ${error}" >> "request.log"
		exit 0
	else echo -n "[*] Adding Request (${count}): " && count=$(expr $count + 1) && echo -n "[*] Adding Request (${count}): " >> "request.log"
	fi
	curl -A $(cat config/useragent.txt) -sL $(cat config/url.txt) >> "request.cache"
	if [ ! "$?" == "0" ]; then
		echo "Request Error" && error=$(expr ${error} + 1) && echo "Request Error" >> "request.log"
	else echo "Done" && success=$(expr $success + 1) && echo "Done" >> "request.log"
	fi
done
