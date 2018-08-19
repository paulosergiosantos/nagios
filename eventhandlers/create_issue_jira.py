import sys
import requests
import json
import logging
import http

JIRA_URL = 'http://jira.inatel.br/jira/rest/api/latest/issue/'
JIRA_AUTH = {'Authorization': 'Basic c2V1dXNlcm5hbWU6c3Vhc2VuaGE='}
JIRA_CONTENT = {'Content-Type': 'application/json'}
JIRA_ACCEPT = {'Accept': 'application/json'}
PROJECT_ID = '131001'
ISSUETYPE_ID = '10806'
ASSIGNEE_NAME = 'paulosergio'
COMPONENT_SOTWARE_ID = '13302'
TASK_TITLE=sys.argv[1]

class Project:
    id = None
    def __init__(self, id):
        self.id = id

class IssueType:
    id = None
    def __init__(self, id):
        self.id = id

class Assignee:
    name = None
    def __init__(self, name):
        self.name = name

class Component:
    id = None
    def __init__(self, id):
        self.id = id

class Fields:
    project = None
    summary = None
    issuetype = None
    assignee = None
    components = None
    def __init__(self, project, summary, issuetype, assignee, components):
        self.project = project
        self.summary = summary
        self.issuetype = issuetype
        self.assignee = assignee
        self.components = components

class IssueData:
    fields: None
    def __init__(self, fields):
        self.fields = fields

def obj_to_dict(obj):
   return obj.__dict__

def enable_log(enable=False):
    if enable:
        http.client.HTTPConnection.debuglevel = 1
        logging.basicConfig()
        logging.getLogger().setLevel(logging.DEBUG)
        requests_log = logging.getLogger("requests.packages.urllib3")
        requests_log.setLevel(logging.DEBUG)
        requests_log.propagate = True

enable_log()
project = Project(PROJECT_ID)
issuetype = IssueType(ISSUETYPE_ID)
assignee = Assignee(ASSIGNEE_NAME)
components = [Component(COMPONENT_SOTWARE_ID)]
summary = TASK_TITLE

fields = Fields(project, summary, issuetype, assignee, components)
issueData = IssueData(fields)

post_url = JIRA_URL
post_headers = {**JIRA_AUTH, **JIRA_CONTENT, **JIRA_ACCEPT}
post_data = json.dumps(issueData.__dict__, default = obj_to_dict)

response = requests.post(post_url, headers = post_headers, data = post_data)
print("Status Code:", response.status_code)
print("%s" % ("Issue criada com sucesso" if response.status_code == 201 else "Erro na criação da issue"))
response_data = response.json()

print(json.dumps(response_data, sort_keys=True,
                 indent=4, separators=(',', ': ')))

print(post_data)
print(json.dumps(post_data, sort_keys=True,
                 indent=4,separators=(',', ': ')))

