#!/bin/bash

# N is the node number of hadoop cluster
echo -e -n "Digite quantos slaves deseja subir : "
read valor 
N=$valor
i=1
i=0


valor06='#!bin/bash
N=valor
i=1
i=0

while [ $i -lt $N ]
do
	i=$(( $i + 1 ))
	sudo docker rm -f hadoop-slave$i &> /dev/null
	echo "start hadoop-slave$i container..."
	sudo docker run -itd \
	                --net=hadoop \
	                --name hadoop-slave$i \
	                --hostname hadoop-slave$i \
	                hadoop-image &> /dev/null

done 
'
echo "$valor06" > resize-slave.sh

# change slaves file

rm config/workers
while [ $i -lt $N ]
do
	i=$(( $i + 1 ))	
	echo "hadoop-slave$i" >> config/workers

done 

sed -i s/N=valor/N=$valor/g resize-slave.sh

bash ./resize-slave.sh

sudo docker restart hadoop-master
sudo docker cp config/workers hadoop-master:/usr/local/hadoop/etc/hadoop/
sudo docker exec hadoop-master bash /root/start-hadoop.sh
