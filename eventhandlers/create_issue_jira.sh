#!/bin/bash

#set -x

JIRA_URL="http://jira.inatel.br/jira/rest/api/latest/issue/"
JIRA_AUTH="\"Authorization: Basic dXN1YXJpbzpzZW5oYQ==\""
JIRA_CONTENT="\"Content-Type: application/json\""
JIRA_ACCEPT="\"Accept: application/json\""

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

CURL_CMD="curl -i -H ${JIRA_AUTH} -H ${JIRA_CONTENT} -H ${JIRA_ACCEPT} $JIRA_URL -d '${ISSUE_DATA}'"

RESPONSE=$(eval $CURL_CMD)

echo -e "$RESPONSE"
