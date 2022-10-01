#!/bin/sh

echo "jobmanager.rpc.address: $1
jobmanager.rpc.port: 6123
kubernetes.cluster-id: $2
kubernetes.namespace: $3
execution.target: kubernetes-session" > conf/flink-conf.yaml

./flink-sql-gateway/bin/sql-gateway.sh \
  --jar flink-sql-gateway/lib/flink-connector-kafka_2.12-1.12.7.jar \
  --jar flink-sql-gateway/lib/kafka-clients-2.4.1.jar