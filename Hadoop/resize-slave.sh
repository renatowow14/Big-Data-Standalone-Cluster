#!bin/bash
N=3
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

