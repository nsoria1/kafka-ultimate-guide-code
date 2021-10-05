FROM ubuntu
RUN apt-get update
RUN apt-get -qq install openjdk-8-jdk openjdk-8-jre
RUN apt-get -qq install wget
RUN apt-get -qq install telnet
RUN mkdir zookeeper && cd zookeeper
RUN wget https://archive.apache.org/dist/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz
RUN tar -zxf zookeeper-3.4.6.tar.gz
RUN mv zookeeper-3.4.6 /usr/local/zookeeper
RUN mkdir -p /var/lib/zookeeper
RUN mkdir -p /usr/local/zookeeper/conf
COPY zoo.cfg /usr/local/zookeeper/conf/
RUN export JAVA_HOME="$(update-alternatives --query java | grep 'Value: ' | grep -o '/.*/jre')"
RUN wget https://archive.apache.org/dist/kafka/0.9.0.1/kafka_2.11-0.9.0.1.tgz
RUN tar -zxf kafka_2.11-0.9.0.1.tgz
RUN mv kafka_2.11-0.9.0.1 /usr/local/kafka
RUN mkdir /tmp/kafka-logs