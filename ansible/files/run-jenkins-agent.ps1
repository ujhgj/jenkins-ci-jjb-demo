$MASTER_ENDPOINT = "http://192.168.50.100:8080"
$JNLP_CREDENTIALS = "admin:admin"
$NODE_NAME = "windows-slave"

curl "$MASTER_ENDPOINT/jnlpJars/agent.jar" -O agent.jar
java.exe -jar agent.jar -jnlpUrl "$MASTER_ENDPOINT/computer/$NODE_NAME/slave-agent.jnlp" -jnlpCredentials "$JNLP_CREDENTIALS"
