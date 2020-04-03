#!/bin/bash

sudo cat <<EOF > /opt/bitnami/grafana/conf/grafana.ini
instance_name=grafana

[security]
admin_user=admin

[server]
protocol=http
http_addr=0.0.0.0
http_port=3000
domain=127.0.0.1
root_url=%(protocol)s://%(domain)s:%(http_port)s/

[paths]
data=/opt/bitnami/grafana/data
logs=/opt/bitnami/grafana/logs
plugins=/opt/bitnami/grafana/data/plugins
provisioning=/opt/bitnami/grafana/conf/provisioning

[metrics]
enabled=true

[database]
type=sqlite3
max_open_conn=0
max_idle_conn=2
log_queries=false
path=grafana.db

[auth.generic_oauth]
"[auth.saml]"=true

[users]
allow_sign_up = true
auto_assign_org = true
auto_assign_org_role = Viewer
login_hint = username
password_hint = password

[auth.generic_oauth]
name = BitBucket
enabled = true
allow_sign_up = true
client_id =
client_secret =
scopes = account email
auth_url = https://bitbucket.org/site/oauth2/authorize
token_url = https://bitbucket.org/site/oauth2/access_token
api_url = https://api.bitbucket.org/2.0/user
team_ids =
allowed_organizations =

default_theme = dark
EOF

sudo cat <<EOF > /opt/bitnami/grafana/conf/provisioning/dashboards/dashboard.yaml
apiVersion: 1

providers:
- name: "[EKS Test] Jedis API"
  orgId: 1
  folder: 'Test Environment'
  folderUid: ''
  type: file
  disableDeletion: false
  editable: true
  updateIntervalSeconds: 30
  allowUiUpdates: false
  options:
    path: /opt/bitnami/grafana/data

- name: "[EKS ReleaseTest] Jedis API"
  orgId: 1
  folder: 'ReleaseTest Environment'
  folderUid: ''
  type: file
  disableDeletion: false
  editable: true
  updateIntervalSeconds: 30
  allowUiUpdates: false
  options:
    path: /opt/bitnami/grafana/data

- name: "[EKS Staging] Jedis API"
  orgId: 1
  folder: 'Staging Environment'
  folderUid: ''
  type: file
  disableDeletion: false
  editable: true
  updateIntervalSeconds: 30
  allowUiUpdates: false
  options:
    path: /opt/bitnami/grafana/data

- name: "[EKS Prod] Jedis API"
  orgId: 1
  folder: 'Production Environment'
  folderUid: ''
  type: file
  disableDeletion: false
  editable: true
  updateIntervalSeconds: 30
  allowUiUpdates: false
  options:
    path: /opt/bitnami/grafana/data
EOF

sudo cat <<EOF > /opt/bitnami/grafana/conf/provisioning/datasources/prometheus.yml
# config file version
apiVersion: 1

deleteDatasources:
  - name: prometheus
    orgId: 2

datasources:
- name: "[TEST] Jedis API EKS"
  access: proxy
  type: prometheus
  orgId: 1
  url: https://xxx-xxx.ap-southeast-2.elb.amazonaws.com
  editable: true
  jsonData:
    tlsSkipVerify: true
    sslmode: "disable"

- name: "[Release Test] Jedis API EKS"
  access: proxy
  type: prometheus
  orgId: 1
  url: https://xxx-xxx.ap-southeast-2.elb.amazonaws.com
  editable: true
  jsonData:
    tlsSkipVerify: true
    sslmode: "disable"

- name: "[Staging] Jedis API EKS"
  access: proxy
  type: prometheus
  orgId: 1
  url: https://xxx-xxx.ap-southeast-2.elb.amazonaws.com
  editable: true
  jsonData:
    tlsSkipVerify: true
    sslmode: "disable"

- name: "[Prod] Jedis API EKS"
  access: proxy
  type: prometheus
  orgId: 1
  url: https://xxx-xxx.ap-southeast-2.elb.amazonaws.com
  editable: true
  jsonData:
    tlsSkipVerify: true
    sslmode: "disable"
EOF

sudo systemctl restart bitnami

