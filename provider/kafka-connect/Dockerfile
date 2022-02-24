FROM confluentinc/cp-server-connect:6.2.0

#ENV CONNECT_PLUGIN_PATH="/usr/share/java,/usr/share/confluent-hub-components"

USER root

RUN confluent-hub install --no-prompt confluentinc/kafka-connect-datagen:0.5.0
RUN confluent-hub install --no-prompt confluentinc/kafka-connect-jdbc:10.2.1
RUN confluent-hub install --no-prompt jcustenborder/kafka-config-provider-azure:0.1.2
