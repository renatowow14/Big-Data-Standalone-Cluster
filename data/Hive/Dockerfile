FROM ubuntu:20.04

MAINTAINER Renato Gomes Silverio <renatogomesilverio@gmail>

WORKDIR /root

RUN apt-get update && apt-get install -y openssh-server openjdk-8-jdk wget net-tools vim htop inetutils-ping curl telnet

#**************************************** INSTALLING hive and configure ******************************

ENV HIVE_VERSION=3.1.2
ENV HIVE_HOME=/usr/local/hive
ENV HIVE_CONF_DIR="${HIVE_HOME}/conf"
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV PATH "${PATH}:${HIVE_HOME}/bin"
RUN curl --progress-bar -L \
  "https://archive.apache.org/dist/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz" \
    | gunzip \
    | tar -x -C /usr/local \
  && mv "/usr/local/apache-hive-${HIVE_VERSION}-bin" "${HIVE_HOME}" \
  && chown -R root:root "${HIVE_HOME}" \
  && mkdir -p "${HIVE_HOME}/hcatalog/var/log" \
  && mkdir -p "${HIVE_HOME}/var/log" \
  && mkdir -p "${HIVE_CONF_DIR}" \
  && chmod 777 "${HIVE_HOME}/hcatalog/var/log" \
  && chmod 777 "${HIVE_HOME}/var/log"
COPY ./config/hive-site.xml /usr/local/hive/conf
COPY ./config/validate-db-init.sh /root
RUN cd  /root && chmod +x validate-db-init.sh

#**************************************** Install a hadoop binaries, hive depends on them ******************************

ENV HADOOP_VERSION=3.3.1
ENV HADOOP_HOME=/usr/local/hadoop
RUN curl --progress-bar -L --retry 3 \
  "http://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz" \
  | gunzip \
  | tar -x -C /usr/local \
 && mv "/usr/local/hadoop-${HADOOP_VERSION}" "${HADOOP_HOME}" \
 && rm -rf "${HADOOP_HOME}/share/doc" \
 && chown -R root:root "${HADOOP_HOME}"

#**************************************** hadoop binaries depends on them ******************************

CMD [ "sh", "-c", "service ssh start; tail -f /dev/null"]

#**************************************** Finish Installation ******************************

