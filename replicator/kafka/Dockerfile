FROM centos:centos8
MAINTAINER seknop@gmail.com
ENV container docker

## patch mirrorlist
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

# 1. Adding Confluent repository
RUN rpm --import https://packages.confluent.io/rpm/5.4/archive.key
COPY confluent.repo /etc/yum.repos.d/confluent.repo
RUN yum -y clean all
RUN yum -y update

# 2. Install zookeeper and kafka
RUN yum install -y java-11-openjdk-devel
RUN yum install -y confluent-platform-2.11

# 3. Configure Kafka and zookeeper for Kerberos 
COPY server.properties /etc/kafka/server.properties
COPY kafka.jaas.config /etc/kafka/kafka_server_jaas.conf
COPY consumer.properties /etc/kafka/consumer.properties

EXPOSE 9093

CMD kafka-server-start /etc/kafka/server.properties