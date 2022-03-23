FROM confluentinc/cp-server-connect:7.0.1

ENV CONNECT_PLUGIN_PATH="/usr/share/java,/usr/share/confluent-hub-components"

USER root

#COPY ./jars/ /usr/share/java

RUN confluent-hub install --no-prompt confluentinc/kafka-connect-datagen:0.5.0 \
    && confluent-hub install --no-prompt confluentinc/kafka-connect-jdbc:10.2.1 \
    && confluent-hub install --no-prompt debezium/debezium-connector-mysql:1.8.1
