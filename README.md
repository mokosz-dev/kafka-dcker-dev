# kafka-dev
```
version: '3'
services:
  kafka:
    image: mokosz/kafka-dev:latest
    container_name: kafka
    ports:
    - 2181:2181
    - 9092:9092
    - 9000:9000
    environment:
      KAFKA_CREATE_TOPICS: "Topic1:2,Topic2:2" # <topic name : partitions>,<topic name : partitions>
      CONSUMER_GROUPS: "dev,test,prod" # trifecta.kafka.consumers.native=dev,test,prod
    volumes:
    - /data/zookeeper:/data/zookeeper
    - /var/zookeeper/datalog:/var/zookeeper/datalog
    - /var/zookeeper/logs:/var/zookeeper/logs
    - /var/kafka/logs:/var/kafka/logs
    - /data/kafka:/data/kafka
    - /var/trifecta-ui/logs:/var/trifecta-ui/logs
```