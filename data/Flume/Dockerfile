FROM ubuntu:20.04

LABEL Renato Gomes Silverio <renatogomesilverio@gmail>

WORKDIR /root

SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get install -y openssh-server openjdk-8-jdk wget net-tools vim htop inetutils-ping curl telnet

ENV FLUME_VERSION=1.9.0
ENV FLUME_HOME=/usr/local/flume
ENV FLUME_CONF_DIR=/usr/local/flume/conf
RUN curl --progress-bar -L --retry 3 \
  "http://archive.apache.org/dist/flume/${FLUME_VERSION}/apache-flume-${FLUME_VERSION}-bin.tar.gz" \
  | gunzip \
  | tar -x -C /usr/local \
 && mv "/usr/local/apache-flume-${FLUME_VERSION}-bin" "${FLUME_HOME}" \
 && rm -rf "${FLUME_HOME}/docs" \
 && chown -R root:root "${FLUME_HOME}"
ENV PATH=$PATH:$FLUME_HOME/bin
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

COPY ./config/start-flume.sh /root
RUN chmod -R 777 /root/start-flume.sh

#**************************************** Install a hadoop binaries, hive depends on them ******************************

ENV HADOOP_VERSION=3.3.1
ENV HADOOP_HOME=/usr/local/hadoop
RUN curl --progress-bar -L --retry 3 \
  "http://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz" \
  | gunzip \
  | tar -x -C /usr/local \
 && mv "/usr/local/hadoop-${HADOOP_VERSION}" "${HADOOP_HOME}" \
 && chown -R root:root "${HADOOP_HOME}"

RUN cd /usr/local/hadoop/share/hadoop/common/ && cp -rvp *.jar /usr/local/flume/lib \
&& cd /usr/local/hadoop/share/hadoop/common/lib/ && cp -rvp *.jar /usr/local/flume/lib \
&& cd /usr/local/hadoop/share/hadoop/hdfs/ && cp -rvp *.jar /usr/local/flume/lib 

RUN cd /usr/local && rm -rfv hadoop/



#**************************************** Install a hadoop binaries, hive depends on them ******************************

CMD [ "sh", "-c", "service ssh start; tail -f /dev/null"]
