#!/bin/sh

echo "jobmanager.rpc.address: $1\n
jobmanager.rpc.port: 6123\n
kubernetes.cluster-id: $2\n
execution.target: kubernetes-session" > conf/flink-conf.yaml

./flink-sql-gateway/bin/sql-gateway.sh