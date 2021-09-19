#!/usr/bin/env bash
set -eux

MASTER_ENDPOINT=http://192.168.50.100:8080
JNLP_CREDENTIALS=admin:admin
NODE_NAME=linux-slave

curl $MASTER_ENDPOINT/jnlpJars/agent.jar > /tmp/agent.jar
exec java -jar /tmp/agent.jar -jnlpUrl $MASTER_ENDPOINT/computer/$NODE_NAME/slave-agent.jnlp -jnlpCredentials "$JNLP_CREDENTIALS"
