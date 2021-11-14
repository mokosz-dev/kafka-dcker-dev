#!/bin/bash
if [[ ! -z "$CONSUMER_GROUPS" ]]; then
    while true; do
        IFS=","; for groupToLog in $CONSUMER_GROUPS; do
            COMMAND="JMX_PORT='' kafka-consumer-groups.sh \
                --bootstrap-server localhost:9092,localhost:9192,localhost:9292 \
                --group ${groupToLog} \
                --describe "
            eval "${COMMAND}" >> /var/kafka/logs/consumer_groups.log
        done
        sleep 60
    done
fi