#!/bin/bash

while :
do
	
sleep 10

schematool -dbType postgres -validate

if [ $? -eq 0 ]; then
    echo OK
else
    echo FAIL
    /usr/local/hive/bin/schematool -dbType postgres -initSchema
fi


sleep 2m

netstat -antp | grep "10002"

if [ $? -eq 0 ]; then
    echo OK
else
    echo FAIL
    $HIVE_HOME/bin/hive --service hiveserver2 &
fi

done
