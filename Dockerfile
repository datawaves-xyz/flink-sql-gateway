ARG build_for=linux/amd64

FROM --platform=$build_for flink:1.12.7-scala_2.12-java11

EXPOSE 8083

RUN mkdir flink-sql-gateway
COPY target/flink-sql-gateway-0.3-SNAPSHOT-bin/flink-sql-gateway-0.3-SNAPSHOT/ flink-sql-gateway/
COPY sql-gateway.yaml flink-sql-gateway/conf/sql-gateway-defaults.yaml
RUN mkdir flink-sql-gateway/log

COPY entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh

# Download dependency jar
RUN curl -s "https://repo1.maven.org/maven2/org/apache/flink/flink-connector-kafka_2.12/1.12.7/flink-connector-kafka_2.12-1.12.7.jar" -o "/opt/flink/flink-sql-gateway/lib/flink-connector-kafka_2.12-1.12.7.jar"

ENTRYPOINT [ "./entrypoint.sh" ]
