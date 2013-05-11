#!/bin/bash

OLD_IFS=$IFS
IFS=$'\n'
for WEBSITE in $(cat "$(pwd)/WEBSITES"); do

	cat <<DATA

server {
	server_name ${WEBSITE};
	location / { rewrite ^ http://www.${WEBSITE}$request_uri? permanent; }
}
server {
	server_name www.${WEBSITE};
	root /srv/qnn-agent-sites/sites/${WEBSITE}/_site;
	index index.html;
}

DATA

done
IFS=$OLD_IFS