FROM openjdk:18-ea-jdk-alpine3.13

LABEL mintainer ="Rafał Kałuziński <rafa.kaluzinski@gmail.com>"
LABEL description ="kafka 2.13-3.0.0 only by test"

COPY --chmod=777 files/processes-go.sh /bin
COPY --chmod=777 files/create-topics.sh /bin
COPY --chmod=777 files/create-compact-topics.sh /bin
COPY --chmod=777 files/log-consumer-groups.sh /bin
COPY --chmod=777 files/zookeeper-run.sh /bin
COPY --chmod=777 files/kafka-0-run.sh /bin
COPY --chmod=777 files/kafka-1-run.sh /bin
COPY --chmod=777 files/kafka-2-run.sh /bin

RUN apk add --no-cache screen && \
    apk add --no-cache wget unzip && \
    apk add --no-cache bash && \
    cd /opt && \
    wget https://dlcdn.apache.org/kafka/3.0.0/kafka_2.13-3.0.0.tgz  -O kafka.tgz && \
    tar -xzvf /opt/kafka.tgz && \
    mv -n /opt/kafka_2.13-3.0.0 /opt/kafka && \
    rm -r /opt/kafka.tgz && \
    mkdir -p /var/kafka/logs/server_0 /var/kafka/logs/server_1 /var/kafka/logs/server_2 /data/kafka/server_0 /data/kafka/server_1 /data/kafka/server_2 && \
    mkdir -p /data/zookeeper && \
    echo "init log" >> /var/kafka/logs/consumer_groups.log

COPY files/server_0.properties /opt/kafka/config/
COPY files/server_1.properties /opt/kafka/config/
COPY files/server_2.properties /opt/kafka/config/
COPY files/zookeeper_0.properties /opt/kafka/config/


ENV PATH=$PATH:/opt/kafka/bin

EXPOSE 2181 9092 9192 9292
VOLUME ["/data/zookeeper", "/var/kafka/logs", "/data/kafka"]

CMD ["processes-go.sh"]


