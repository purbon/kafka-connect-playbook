FROM centos:centos8
MAINTAINER pere.urbon@gmail.com
ENV container docker

## patch mirrorlist
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

# 1. Update the system
RUN yum -y update

# 2. Setup the local Kafka Version
COPY data/kafka_2.12-2.2.1.tgz /opt/kafka_2.12-2.2.1.tgz
RUN cd /opt && tar -xvzf kafka_2.12-2.2.1.tgz
RUN mv /opt/kafka_2.12-2.2.1 /opt/kafka

# 2. Install zookeeper and kafka
RUN yum install -y java-11-openjdk-devel

# 3. Configure Kafka and zookeeper for Kerberos 
COPY server.properties /opt/kafka/server.properties
COPY kafka.jaas.config /opt/kafka/kafka_server_jaas.conf
COPY consumer.properties /opt/kafka/consumer.properties

EXPOSE 9093

CMD /opt/kafka/bin/kafka-server-start.sh /opt/kafka/server.properties