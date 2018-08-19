#!/bin/bash

#set -x

JIRA_URL="http://jira.inatel.br/jira/rest/api/latest/issue/"
JIRA_AUTH="\"Authorization: Basic c2V1dXNlcm5hbWU6c3Vhc2VuaGE=\""
JIRA_CONTENT="\"Content-Type: application/json\""
JIRA_ACCEPT="\"Accept': application/json\""

PROJECT_ID=$1
ISSUETYPE_ID=$2
ISSUE_SUMMARY=$3
ISSUE_ASSIGNEE=$4
COMPONENT_ID=$5

ISSUE_DATA="
{
    \"fields\":{
	\"project\":{
		\"id\":\"$PROJECT_ID\"
	},
	\"summary\":\"$ISSUE_SUMMARY\",
	\"issuetype\":{
		\"id\":\"$ISSUETYPE_ID\"
	},
	\"assignee\":{
		\"name\":\"$ISSUE_ASSIGNEE\"
	},
	\"components\":[{
		\"id\":\"$COMPONENT_ID\"
	}]
    }    
}
"

CURL_CMD=$(printf "curl -i  -H %s -H %s -H %s %s -d ' %s '" "$JIRA_AUTH" "$JIRA_CONTENT" "$JIRA_ACCEPT" "$JIRA_URL" "$ISSUE_DATA")

echo $CURL_CMD

