# Apache Hadoop 3.3.1 + Apache Sqoop 1.4.7 + Apache Hive 3.1.2 + Apache Flume 1.9.0

### How to run:
0. Run all commands with the sudo user
1. Run ```initial.sh```
2. Change the path where the github project is downloaded in the ``docker-compose.yml`` file to the one on your local machine 
3. Access Portainer-Web at http://localhost:9000
4. Create Stack on Portainer ```docker-compose.yml``` and start the stack: https://docs.portainer.io/v/ce-2.9/user/docker/stacks/add
5. Run ```start-project.sh``` 
6. Run ```run-wordcount.sh``` to run Word Count job
7. Enjoy!

## Run Project on Remote Server:

1. Have Ansible installed
2. Enter the ansible folder
3. Set your hosts in hosts file in ansible folder
4. Run ```./install-ssh-keys.sh hosts``` and enter the hosts file in front of the script to set the SSH key with your remote host
5. Run ```ansible-playbook playbook.yml```

### Description:

* This cluster consists of a master node and two slaves by default
* You might have to change resource configs. Current config uses 4 cores and 4 Gb RAM

### Web UI:
  If you want to see the web UI, you have to access the following address/port:
* ```http://localhost:9870``` HDFS Web UI
* ```http://localhost:8088``` YARN Web UI
* ```http://localhost:19888``` MapReduce JobHistory Web UI
* ```http://localhost:10002``` HiveServer2 Web UI