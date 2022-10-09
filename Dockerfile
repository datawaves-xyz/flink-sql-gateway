ARG build_for=linux/amd64

FROM --platform=$build_for flink:1.12.7-scala_2.12-java8

EXPOSE 8083

ENV HIVE_VERSION 2.3.9
ENV HIVE_HADOOP_VERSION 2.7.5
ENV FLINK_VERSION 1.12.7
ENV SCALA_VERSION 2.12

RUN mkdir flink-sql-gateway
COPY target/flink-sql-gateway-0.3-SNAPSHOT-bin/flink-sql-gateway-0.3-SNAPSHOT/ flink-sql-gateway/
COPY sql-gateway.yaml flink-sql-gateway/conf/sql-gateway-defaults.yaml

COPY entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh

RUN mkdir hive-metastore

## Kafka
RUN curl -s "https://repo1.maven.org/maven2/org/apache/flink/flink-connector-kafka_$SCALA_VERSION/$FLINK_VERSION/flink-connector-kafka_$SCALA_VERSION-$FLINK_VERSION.jar"  \
    -o "/opt/flink/flink-sql-gateway/lib/flink-connector-kafka_$SCALA_VERSION-$FLINK_VERSION.jar"
RUN curl -s "https://repo1.maven.org/maven2/org/apache/kafka/kafka-clients/2.4.1/kafka-clients-2.4.1.jar" \
    -o "/opt/flink/flink-sql-gateway/lib/kafka-clients-2.4.1.jar"
RUN curl -s "https://repo1.maven.org/maven2/org/apache/flink/flink-connector-hive_$SCALA_VERSION/$FLINK_VERSION/flink-connector-hive_$SCALA_VERSION-$FLINK_VERSION.jar" \
    -o "/opt/flink/flink-sql-gateway/lib/flink-connector-hive_$SCALA_VERSION-$FLINK_VERSION.jar"

## Hive metastore
RUN curl -s "https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-mapreduce-client-core/$HIVE_HADOOP_VERSION/hadoop-mapreduce-client-core-$HIVE_HADOOP_VERSION.jar" \
    -o "/opt/flink/flink-sql-gateway/lib/hadoop-mapreduce-client-core-$HIVE_HADOOP_VERSION.jar"

## Jdbc
RUN curl -s "https://repo1.maven.org/maven2/org/apache/flink/flink-connector-jdbc_$SCALA_VERSION/$FLINK_VERSION/flink-connector-jdbc_$SCALA_VERSION-$FLINK_VERSION.jar" \
    -o "/opt/flink/flink-sql-gateway/lib/flink-connector-jdbc_$SCALA_VERSION-$FLINK_VERSION.jar"
RUN curl -s "https://repo1.maven.org/maven2/org/postgresql/postgresql/42.4.0/postgresql-42.4.0.jar" \
    -o "/opt/flink/flink-sql-gateway/lib/postgresql-42.4.0.jar"
RUN curl -s "https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.30/mysql-connector-java-8.0.30.jar" \
    -o "/opt/flink/flink-sql-gateway/lib/mysql-connector-java-8.0.30.jar"

ENTRYPOINT [ "./entrypoint.sh" ]
