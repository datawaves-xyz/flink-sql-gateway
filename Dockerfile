ARG build_for=linux/amd64

FROM --platform=$build_for flink:1.12.7-scala_2.12-java11

RUN mkdir flink-sql-gateway
COPY target/flink-sql-gateway-0.3-SNAPSHOT-bin/flink-sql-gateway-0.3-SNAPSHOT/ flink-sql-gateway/
COPY sql-gateway.yaml flink-sql-gateway/conf/sql-gateway-defaults.yaml

COPY entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh

ENTRYPOINT [ "./entrypoint.sh" ]
