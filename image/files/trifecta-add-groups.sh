if [[ -z "$CONSUMER_GROUPS" ]]; then
    # indicates whether Zookeeper-based consumers should be enabled/disabled
    echo "#" >> /root/.trifecta/config.properties
    echo "trifecta.kafka.consumers.zookeeper = true" >> /root/.trifecta/config.properties
else
    # indicates which native Kafka consumers should be retrieved
    echo "#" >> /root/.trifecta/config.properties
    echo "trifecta.kafka.consumers.zookeeper = false" >> /root/.trifecta/config.properties
    echo "trifecta.kafka.consumers.native = $CONSUMER_GROUPS" >> /root/.trifecta/config.properties
fi