FROM centos:centos8
LABEL MANTAINER pere.urbon@gmail.com
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
COPY zookeeper.properties /etc/kafka/zookeeper.properties

EXPOSE 2181

CMD zookeeper-server-start /etc/kafka/zookeeper.properties 