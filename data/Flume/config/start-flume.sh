#!/bin/bash

mkdir -p /root/teste

FLUME_CONF_DIR=/usr/local/flume/conf

[[ -d "${FLUME_CONF_DIR}"  ]]  || { echo "Flume config file not mounted in /opt/flume-config";  exit 1; }
[[ -z "${FLUME_AGENT_NAME}" ]] && { echo "FLUME_AGENT_NAME required"; exit 1; }

echo "Starting flume agent : ${FLUME_AGENT_NAME}"

flume-ng agent \
  -c ${FLUME_CONF_DIR} \
  -f ${FLUME_CONF_DIR}/flume.conf \
  -n ${FLUME_AGENT_NAME} \
  -Dflume.root.logger=INFO,console \
  $*

