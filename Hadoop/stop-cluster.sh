#!/bin/bash

# the default node number is 2
N=$1
i=1
i=0

while [ $i -lt $N ]
do

i=$(( $i + 1 ))	   

sudo docker rm -f hadoop-master &> /dev/null
sudo docker rm -f hadoop-slave$i  &> /dev/null

             
echo "Deletando SLAVE $i"                  
done 