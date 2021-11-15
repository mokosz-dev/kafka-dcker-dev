#!/bin/bash

echo "start zookeeper"
screen -dmS zookeeper zookeeper-run.sh

sleep 10;

echo "start kafka servers"
screen -dmS kafka_0 kafka-0-run.sh
screen -dmS kafka_1 kafka-1-run.sh
screen -dmS kafka_2 kafka-2-run.sh

screen -dmS createTopicsScreen create-topics.sh
screen -dmS createCompactTopicsScreen create-compact-topics.sh

screen -dmS logConsumerScreen log-consumer-groups.sh

count=0
timeout=600
while [ ! -f /var/kafka/logs/server_0/server.log ] && [ ! -f /var/kafka/logs/server_1/server.log ] && [ ! -f /var/kafka/logs/server_1/server.log ]; do
    echo "waiting for kafka to be ready"
    sleep 10;
    count=$((count + 10))
    if [ $count -gt timeout ]; then
        break
    fi
done

tail -f /var/kafka/logs/server_0/server.log -f /var/kafka/logs/server_1/server.log -f /var/kafka/logs/server_2/server.log -f /var/kafka/logs/consumer_groups.log