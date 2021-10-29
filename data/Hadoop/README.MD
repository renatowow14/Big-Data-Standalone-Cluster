# Apache Hadoop 3.3.1 + Apache Sqoop 1.4.7 + Apache Hive 3.1.2 + Apache Flume 1.6

### How to run
0. Run all commands with the sudo user
1. Run ```initial.sh```
2. Run ```run-wordcount.sh``` to run Word Count job

## Run Portainer 

1. Run docker-compose.yml on folder Portainer/
2. cd ```Portainer/ && docker-compose up -d```
3. Acess portainer on localhost:9000
4. Have an easy management and visual of your containers

## Stop Project

1. Run ```./stop-cluster.sh``` and specify the value of how many slaves you want to delete
2. ```./stop-cluster.sh 3``` #Delete 3 slaves and master

## Run Project on Remote Server

1. Have Ansible installed
2. Enter the ansible folder
3. Set your hosts in hosts file in ansible folder
4. Run ```./install-ssh-keys.sh hosts``` and enter the hosts file in front of the script to set the SSH key with your remote host
5. Run ```ansible-playbook playbook.yml```

## Resize Cluster Slaves

1. Run ```./resize-cluster.sh``` and inform number of slaves you nedd up on server
2. Run ```./resize-cluster.sh 4``` #Up 4 slaves on cluster


### Test Apache Sqoop and Apache Hive and Flume

1. Test sqoop:

```docker exec -it hadoop-master bash ```

``` sqoop list-tables --connect jdbc:postgresql://172.25.0.6/hivemetastoredb --username postgres --password new_password ```

2. Test Hive

 ```docker exec -it hadoop-master bash ```

 ```hive ```

 ```show databases; ```

3. Teste Flume

```docker exec -it flume-hdfs bash ```

```cd /root/teste```

```touch "teste" > teste.txt```

```docker exec -it hadoop-master bash ```

```dhadoop fs -ls /flume```


### Description

* This cluster consists of a master node and two slaves by default
* You might have to change resource configs. Current config uses 4 cores and 4 Gb RAM

### Web UI
  If you want to see the web UI, you have to access the following address/port:
* ```http://localhost:9870``` HDFS Web UI
* ```http://localhost:8088``` YARN Web UI
* ```http://localhost:19888``` MapReduce JobHistory Web UI
* ```http://localhost:10002``` HiveServer2 Web UI
