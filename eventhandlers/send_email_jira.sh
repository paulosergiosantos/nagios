#!/bin/bash 

set -x

CC=paulosergio@inatel.br
SUBJECT=$1 
RECEIVER=$2  
TEXT=$3  

SERVER_NAME=$HOSTNAME  
SENDER=$(whoami)  
USER="noreply"

[[ -z $1 ]] && SUBJECT="Notification from $SENDER on server $SERVER_NAME"  
[[ -z $2 ]] && RECEIVER="another_configured_email_address"   
[[ -z $3 ]] && TEXT="no text content"  

MAIL_TXT="Subject: $SUBJECT\nFrom: $SENDER\nTo: $RECEIVER\n\n$TEXT"  
echo $MAIL_TXT | /usr/bin/sendmail -s "$SUBJECT" -t "$RECEIVER","$CC"
exit 1
