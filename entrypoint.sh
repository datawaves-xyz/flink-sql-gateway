#!/bin/sh

echo "jobmanager.rpc.address: $1
jobmanager.rpc.port: 6123
kubernetes.cluster-id: $2
kubernetes.namespace: $3
execution.target: kubernetes-session" > conf/flink-conf.yaml

echo "<configuration>
<property>
  <name>javax.jdo.option.ConnectionURL</name>
  <value>$4</value>
  <description>metadata is stored in a MySQL server</description>
</property>

<property>
  <name>javax.jdo.option.ConnectionDriverName</name>
  <value>com.mysql.jdbc.Driver</value>
  <description>MySQL JDBC driver class</description>
</property>

<property>
  <name>javax.jdo.option.ConnectionUserName</name>
  <value>$5</value>
  <description>user name for connecting to mysql server</description>
</property>

<property>
  <name>javax.jdo.option.ConnectionPassword</name>
  <value>$6</value>
  <description>password for connecting to mysql server</description>
</property>

<property>
  <name>hive.metastore.uris</name>
  <value>$7</value>
  <description>IP address (or fully-qualified domain name) and port of the metastore host</description>
</property>

<property>
  <name>hive.metastore.schema.verification</name>
  <value>true</value>
</property>
</configuration>" > hive-metastore/hive-site.xml

./flink-sql-gateway/bin/sql-gateway.sh \
  --jar flink-sql-gateway/lib/flink-connector-kafka_2.12-1.12.7.jar \
  --jar flink-sql-gateway/lib/kafka-clients-2.4.1.jar \
  --jar flink-sql-gateway/lib/flink-connector-hive_2.12-1.12.7.jar \
  --jar flink-sql-gateway/lib/hadoop-mapreduce-client-core-2.7.5.jar \
  --jar flink-sql-gateway/lib/flink-connector-jdbc_2.12-1.12.7.jar \
  --jar flink-sql-gateway/lib/postgresql-42.4.0.jar
