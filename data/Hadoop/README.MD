# Apache Hadoop 3.3.1 

### How to run
0. Run all commands with the sudo user
1. Run ``` docker build -t hadoop-image .```
2. Run ```docker exec -it hadoop-image bash ``` to run log into the hadoop container
3. Run ```run-wordcount.sh``` to run Word Count job

## Run Portainer 

1. Run docker-compose.yml on folder Portainer/
2. cd ```Portainer/ && docker-compose up -d```
3. Acess portainer on localhost:9000
4. Have an easy management and visual of your containers

## Stop Project

1. Run ```./stop-cluster.sh``` and specify the value of how many slaves you want to delete
2. ```./stop-cluster.sh 3``` #Delete 3 slaves and master

### Description

* This cluster consists of a master node and two slaves by default
* You might have to change resource configs. Current config uses 4 cores and 4 Gb RAM

### Web UI
  If you want to see the web UI, you have to access the following address/port:
* ```http://localhost:9870``` HDFS Web UI
* ```http://localhost:8088``` YARN Web UI


