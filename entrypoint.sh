#!/bin/sh

echo "jobmanager.rpc.address: $1\
jobmanager.rpc.port: 6123\
kubernetes.cluster-id: $2\
execution.target: kubernetes-session" > conf/flink_conf.yaml

./flink-sql-gateway/bin/sql-gateway.sh