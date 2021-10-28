#!/bin/bash

docker-compose up -d

sudo docker exec hadoop-master bash /root/start-hadoop.sh

sudo docker exec hadoop-master hadoop fs -mkdir /flume

sudo docker exec -it hadoop-master /bin/bash
