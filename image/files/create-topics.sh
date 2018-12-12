#!/bin/bash

echo "Starting create topics ... BEGIN STARTED in the background on port 9000"

if [[ -z "$KAFKA_CREATE_TOPICS" ]]; then
    exit 0
fi

if [[ -z "$START_TIMEOUT" ]]; then
    START_TIMEOUT=600
fi

start_timeout_exceeded=false
count=0
step=10
while netstat -lnt | awk '$4 ~ /:9092$/ {exit 1}'; do
    echo "waiting for kafka to be ready"
    sleep $step;
    count=$((count + step))
    if [ $count -gt $START_TIMEOUT ]; then
        start_timeout_exceeded=true
        break
    fi
done

if $start_timeout_exceeded; then
    echo "Not able to auto-create topic (waited for $START_TIMEOUT sec)"
    exit 1
fi

# Expected format:
#   name:partitions:replicas:cleanup.policy
IFS=","; for topicToCreate in $KAFKA_CREATE_TOPICS; do
    echo "creating topics: $topicToCreate"
    IFS=':' read -r -a topicConfig <<< "$topicToCreate"
    COMMAND="JMX_PORT='' kafka-topics.sh \\
		--create \\
		--zookeeper localhost:2181 \\
		--topic ${topicConfig[0]} \\
		--partitions ${topicConfig[1]} \\
		--replication-factor 1 &"
    eval "${COMMAND}"
done

wait