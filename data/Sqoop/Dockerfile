FROM ubuntu:20.04

LABEL Renato Gomes Silverio <renatogomesilverio@gmail>

WORKDIR /root

SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get install -y openssh-server openjdk-8-jdk wget net-tools vim htop inetutils-ping curl telnet

#**************************************** INSTALLING sqoop and configure ******************************

RUN  mkdir sqoop && wget -P /sqoop/ http://archive.apache.org/dist/sqoop/1.4.7/sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz && \
tar -xzvf /sqoop/sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz -C /sqoop

COPY ./config/mysql-connector-java-8.0.25.jar /sqoop/sqoop-1.4.7.bin__hadoop-2.6.0/lib
COPY ./config/commons-lang-2.6.jar /sqoop/sqoop-1.4.7.bin__hadoop-2.6.0/lib

ENV SQOOP_HOME /sqoop/sqoop-1.4.7.bin__hadoop-2.6.0
ENV PATH $PATH:$SQOOP_HOME/bin

RUN echo "export SQOOP_HOME=/sqoop/sqoop-1.4.7.bin__hadoop-2.6.0" >>~/.bashrc && \
echo "export PATH=$PATH:$SQOOP_HOME/bin" >>~/.bashrc

#Install jdbc-driver-postgres
RUN wget https://jdbc.postgresql.org/download/postgresql-42.2.24.jar && mv postgresql-42.2.24.jar /sqoop/sqoop-1.4.7.bin__hadoop-2.6.0/lib

#**************************************** INSTALLING Hadoop binaries ******************************

# Hadoop
ENV HADOOP_VERSION=3.3.1
ENV HADOOP_HOME /usr/local/hadoop
RUN curl --progress-bar -L --retry 3 \
  "http://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz" \
  | gunzip \
  | tar -x -C /usr/local \
 && mv "/usr/local/hadoop-${HADOOP_VERSION}" "${HADOOP_HOME}" \
 && rm -rf "${HADOOP_HOME}/share/doc" \
 && chown -R root:root "${HADOOP_HOME}"

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV HADOOP_HOME=/usr/local/hadoop
ENV PATH="${PATH}:${HADOOP_HOME}/bin"

CMD [ "sh", "-c", "service ssh start; tail -f /dev/null"]
