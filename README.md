# kafka-dev
```
version: '3'
services:
  kafka:
    image: mokosz/kafka-dev:latest
    container_name: kafka
    ports:
      - 2181:2181 #zookeeper
      - 9092:9092 #kafka server 0
      - 9192:9192 #kafka server 1
      - 9292:9292 #kafka server 2
    environment:
      KAFKA_CREATE_TOPICS: "Topic1:2,Topic2:2" # <topic name : partitions>,<topic name : partitions>
      KAFKA_CREATE_COMPACT_TOPICS: "Topic1:2,Topic2:2" # <topic name : partitions>,<topic name : partitions>
      CONSUMER_GROUPS: "dev,test,prod" # trifecta.kafka.consumers.native=dev,test,prod
    volumes:
    - /data/zookeeper:/data/zookeeper
    - /data/kafka:/data/kafka
