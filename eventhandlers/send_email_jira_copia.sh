#!/bin/bash 

#set -xT=$1  
RECEIVER=$2  
TEXT=$3  

SERVER_NAME=$HOSTNAME  
SENDER=$(whoami)  
USER="noreply"

[[ -z $1 ]] && SUBJECT="Notification from $SENDER on server $SERVER_NAME"  
[[ -z $2 ]] && RECEIVER="another_configured_email_address"   
[[ -z $3 ]] && TEXT="no text content"  

MAIL_TXT="Subject: $SUBJECT\nFrom: $SENDER\nTo: $RECEIVER\n\n$TEXT"  
echo -e $MAIL_TXT | sendmail -t
exit 1
