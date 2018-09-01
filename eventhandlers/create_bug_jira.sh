#!/bin/bash
#
# Event handler para testar criacao de bug no Jira quando o status de um serviço alaterar para CRITICAL
#

cd /usr/local/nagios/libexec/eventhandlers

exec > create_bug.log

createBug() {
   echo "$1"
   RESPONSE=$(python3 create_issue_jira.py PV Bug "$1")
   echo $RESPONSE
}

echo $(date +"%d-%m-%y %H:%M:%S:") $1 $2 $3 $4 $5

CREATE_BUG_MSG="Bug criado pelo Nagios devido falha no servico $5 do host $4"

# Verificar se o serviço foi alterado para CRITICAL
case "$1" in

CRITICAL)
    # Criar bug somente se for uma alteracao de status HARD 
    case "$2" in
	HARD)
            createBug "$CREATE_BUG_MSG"
	    ;;
	esac
	;;
esac
exit 0
