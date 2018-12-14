FROM mokosz/os-alpine:1

LABEL mintainer ="Rafał Kałuziński <rafa.kaluzinski@gmail.com>"
LABEL description ="kafka 2.11-2.1.0 & zookeeper 3.4.12 & trifecta-ui 0.22.0rc8b-0.10.1.0"

COPY files/processes-go.sh /bin
COPY files/create-topics.sh /bin
COPY files/trifecta-add-groups.sh /bin
COPY files/log-consumer-groups.sh /bin
COPY files/config.properties /root/.trifecta/

RUN apk add screen && \
    apk add wget unzip && \
    cd /opt && \
    wget https://www-us.apache.org/dist/kafka/2.1.0/kafka_2.11-2.1.0.tgz  -O kafka.tgz && \
    tar -xzvf /opt/kafka.tgz && \
    mv -n /opt/kafka_2.11-2.1.0 /opt/kafka && \
    rm -r /opt/kafka.tgz && \
    wget http://ftp.man.poznan.pl/apache/zookeeper/zookeeper-3.4.12/zookeeper-3.4.12.tar.gz  -O zookeeper.tar.gz && \
    tar -xzvf /opt/zookeeper.tar.gz && \
    mv -n /opt/zookeeper-3.4.12 /opt/zookeeper && \
    rm -r /opt/zookeeper.tar.gz && \
    wget https://github.com/ldaniels528/trifecta/releases/download/v0.22.0rc8-0.10.1.0/trifecta-ui-0.22.0rc8b-0.10.1.0.zip -O trifecta-ui.zip && \
    unzip /opt/trifecta-ui.zip && \
    mv -n /opt/trifecta-ui-0.22.0rc8b-0.10.1.0 /opt/trifecta-ui && \
    rm -r /opt/trifecta-ui.zip && \
    apk del wget unzip && \
    ln -s /opt/zookeeper/conf/ /etc/zookeeper && \
    mkdir -p /data/zookeeper/ /var/zookeeper/datalog /var/zookeeper/logs && \
    ln -s /opt/kafka/config/ /etc/kafka && \
    mkdir -p /var/kafka/logs /data/kafka && \
    ln -s /var/kafka/logs /opt/kafka/logs && \
    ln -s /opt/trifecta-ui/conf/ /etc/trifecta-ui && \
    mkdir -p /var/trifecta-ui/logs && \
    ln -s /var/trifecta-ui/logs /opt/trifecta-ui/logs && \
    chmod 777 /bin/processes-go.sh && \
    chmod 777 /bin/create-topics.sh && \
    chmod 777 /bin/trifecta-add-groups.sh && \
    chmod 777 /bin/log-consumer-groups.sh && \
    echo "init log" >> /var/kafka/logs/consumer_groups.log

COPY files/zoo.cfg /opt/zookeeper/conf/
COPY files/server.properties /opt/kafka/config/

ENV PATH=$PATH:/opt/trifecta-ui/bin:/opt/kafka/bin:/opt/zookeeper/bin

EXPOSE 2181 9092 9000
VOLUME ["/data/zookeeper", "/var/zookeeper/datalog", "/var/zookeeper/logs", "/var/kafka/logs", "/data/kafka", "/var/trifecta-ui/logs"]

CMD ["processes-go.sh"]


