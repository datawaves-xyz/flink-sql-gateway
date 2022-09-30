#!/bin/sh

echo "jobmanager.rpc.address: $1
jobmanager.rpc.port: 6123
kubernetes.cluster-id: $2
kubernetes.namespace: $3
execution.target: kubernetes-session" > conf/flink-conf.yaml

./flink-sql-gateway/bin/sql-gateway.sh