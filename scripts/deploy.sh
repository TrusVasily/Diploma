#!/usr/bin/env bash


mvn clean package

echo 'Copy files...'

scp -i ~/.ssh/id_rsa \
    target/sweater-1.0-SNAPSHOT.jar \
    isit2@192.168.43.37:/home/isit2/

echo 'Restart server...'

ssh -i ~/.ssh/id_rsa isit2@192.168.43.37 << EOF
pgrep java | xargs kill -9
nohup java -jar sweater-1.0-SNAPSHOT.jar > log.txt &
EOF

echo 'Bye'