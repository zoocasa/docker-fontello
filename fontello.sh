#!/bin/sh

config_path="/data/app/vendor/fontello/config.json"

curl -X POST -F "config=@$config_path" https://fontello.com 2>/dev/null > /data/.fontello_session_id

session_id=$(cat /data/.fontello_session_id)

if [ "$session_id" == "" ]; then
  exit
fi

GREEN='\e[32m'
YELLOW='\e[33m'
MAGENTA='\e[35m'
CYAN='\e[36m'
ORIGINAL='\e[m'

printf "\nA Fontello Session has been generated for you.\n\n"
printf "You can manipulate the fonts on the browser at the URL: ${MAGENTA}https://fontello.com/$session_id\n${ORIGINAL}\n"
printf "Once finished, click \"Save session\" on the website and answer the following prompt on whether you would like to import those changes.\n\n"
printf "${CYAN}Would you like to import your changes? [y/N] ${ORIGINAL}"; read input

if [ "$input" == "y" ] || [ "$input" == "Y" ]; then
  wget -O fontello.zip "https://fontello.com/$session_id/get" 2> /dev/null
  unzip -q fontello.zip
  cp fontello-*/config.json $config_path
  cp fontello-*/css/fontello-codes.css /data/app/vendor/fontello/fontello-codes.css
  cp fontello-*/font/* /data/app/public/assets/fonts/fontello
	printf "\n${GREEN}Your changes HAVE been saved!${ORIGINAL}\n"
else
  printf "\n${YELLOW}Your changes HAVE NOT been saved!${ORIGINAL}\n"
fi
