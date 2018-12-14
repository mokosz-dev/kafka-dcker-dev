#!/bin/bash

cd /var/zookeeper/logs && zkServer.sh start /etc/zookeeper/zoo.cfg -D
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start zkServer: $status"
  exit $status
else
   echo "Starting zookeeper ... BEGIN STARTED in the background on port 2181"
   sleep 3;
fi

kafka-server-start.sh -daemon /etc/kafka/server.properties
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start kafka: $status"
  exit $status
else
   echo "Starting kafka ... BEGIN STARTED in the background on port 9092"
    sleep 3;
fi

trifecta-add-groups.sh
screen -dmS trifectaScreen trifecta-ui
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start trifecta: $status"
  exit $status
else
    echo "Starting trifecta-ui ... BEGIN STARTED in the background on port 9000"
    sleep 3;
fi

screen -dmS createTopicsScreen create-topics.sh

count=0
timeout=600
while [ ! -f /var/kafka/logs/server.log ] && [ ! -f /var/zookeeper/logs/zookeeper.out ] && [ ! -f /var/trifecta-ui/logs/application.log ]; do
    echo "waiting for kafka to be ready"
    sleep 10;
    count=$((count + 10))
    if [ $count -gt timeout ]; then
        break
    fi
done

tail -f /var/kafka/logs/server.log -f /var/zookeeper/logs/zookeeper.out -f /var/trifecta-ui/logs/application.log